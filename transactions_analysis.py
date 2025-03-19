"""
Saudi Bank Transaction Analyzer
------------------------------
This script processes and analyzes Saudi bank SMS transactions, specifically focusing on purchase transactions.
It performs the following functions:
1. Extracts transaction details from Arabic SMS format (amount, vendor, date, card number)
2. Validates transaction type (purchase/شراء)
3. Categorizes transactions using OpenAI's API based on vendor names
4. Saves processed data in JSON format
"""

from openai import OpenAI
import os
import pandas as pd
import re
import json

from dotenv import load_dotenv
load_dotenv()

# OpenAI API setup
OPENAI_API_KEY = os.getenv("OPENAI_API_KEY")
if not OPENAI_API_KEY:
    raise ValueError("OpenAI API key not found in environment variables")
OpenAI.api_key = OPENAI_API_KEY

def extract_transaction_details(transaction: str):
    """Extract details from SMS text"""

    type_match = re.search(r"^(شراء|بطاقة ائتمانية:تحويل)", transaction)
    if not type_match:
        return None
    else:
        amount_match = re.search(r"مبلغ:SAR ([\d.]+)", transaction)
        vendor_match = re.search(r"لدى:([\w\s]+)", transaction)
        date_match = re.search(r"في:(\d{2}-\d{1,2}-\d{1,2})", transaction)  
        time_match = re.search(r"في:[\d-]+ (\d{2}:\d{2})", transaction)     
        type_match = re.search(r"^(شراء|بطاقة ائتمانية:تحويل)", transaction)
        card_number_match = re.search(r'بطاقة:(\d{4})', transaction)
        if all([amount_match, vendor_match, date_match, time_match, type_match, card_number_match]):
            try:
                vendor = vendor_match.group(1).strip().replace("\nفي", "")
                date_str = date_match.group(1)
                time_str = time_match.group(1)
                full_datetime = pd.to_datetime(f"{date_str} {time_str}", format="%y-%m-%d %H:%M")
                return {
                    "Type": type_match.group(1),
                    "Amount (SAR)": float(amount_match.group(1)),
                    "Vendor": vendor,
                    "Category": "Other",
                    "Card Number": card_number_match.group(1),
                    "Date": full_datetime.date().isoformat(),
                    "Time": time_str
                }
            except ValueError as e:
                print(f"Error parsing date/time: {e}")
                return None

# ---- OpenAI API Call ----
VALID_CATEGORIES = {
    "Food", "Shopping", "Transport", "Health", 
    "Education", "Utilities", "Entertainment", "Other"
}

def get_gpt_category(vendor: str, amount: float):
    try:

        client = OpenAI()
        response = client.chat.completions.create(
            # ---- Classify transaction by vendor name & amount  ----

            model="gpt-4o-mini", 
            messages=[
                {
                    "role": "system",
                    "content": "You are a financial transaction categorizer. Respond with exactly one category from: Food, Shopping, Transport, Health, Education, Utilities, Entertainment, Other. No additional text."
                },
                {
                    "role": "user",
                    "content": f"Based on the vendor name '{vendor}' and transaction amount 'SAR {amount}', what category does this transaction belong to?"
                }
            ],
            temperature=0.3,
            max_tokens=20
        )
        category = response.choices[0].message.content.strip()
        return category if category in VALID_CATEGORIES else "Other"
    except Exception as e:
        print(f"Error calling OpenAI API: {e}")
        return "Other"

# ---- Process Transactions & Save as JSON ----
def analyze_transaction(transaction):
    if not transaction:
        return None
    
    processed_data = transaction.copy()  # Create a copy instead of modifying original
    processed_data["Category"] = get_gpt_category(
        processed_data["Vendor"],
        processed_data["Amount (SAR)"]
    )
    return [processed_data]  

def save_transactions_to_json(data, filename="py/data/transactions_analysis.json"):
    try:
        os.makedirs(os.path.dirname(filename), exist_ok=True)
        with open(filename, "w", encoding="utf-8") as f:
            json.dump(data, f, ensure_ascii=False, indent=4)
        print(f"Data saved to {filename}")
    except (OSError, IOError) as e:
        print(f"Error saving file: {e}")
        raise




if __name__ == "__main__":
    # Example usage
    sms_text = input("Enter the transaction SMS text: ")
    try:
        transaction_details = extract_transaction_details(sms_text)
        transaction = analyze_transaction(transaction_details)
        if transaction:
            save_transactions_to_json(transaction)
            print("Transaction processed successfully")
        else:
            print("Could not process transaction")
    except Exception as e:
        print(f"Error processing SMS: {e}")

# Example SMS format:
# شراء\nبطاقة:0510;مدى-ابل باي\nمبلغ:SAR 47.80\nلدى:HALA MARK\nفي:25-2-2 06:44