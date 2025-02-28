import openai
import os
import random
import pandas as pd
import re
import json

# OpenAI API setup
OPENAI_API_KEY = os.getenv("OPENAI_API_KEY")
if not OPENAI_API_KEY:
    raise ValueError("OpenAI API key not found in environment variables")
openai.api_key = OPENAI_API_KEY

# Real sample data of transactions in Arabic format
TRANSACTIONS = [
    "شراء\nبطاقة:0510;مدى-ابل باي\nمبلغ:SAR 47.80\nلدى:HALA MARK\nفي:25-2-2 06:44",
    "شراء\nبطاقة:0510;مدى-ابل باي\nمبلغ:SAR 19.70\nلدى:FAIRWAY\nفي:25-2-5 00:27",
    "شراء انترنت\nبطاقة:8905;مدى\nمن:4360\nمبلغ:SAR 7.95\nلدى:AMAZON SA\nفي:25-2-5 17:44",
    "شراء\nبطاقة:0510;مدى-ابل باي\nمبلغ:SAR 10.45\nلدى:BAJH TRAD\nفي:25-2-6 14:00",
    "شراء\nبطاقة:0510;مدى-ابل باي\nمبلغ:SAR 37.40\nلدى:Raed Food\nفي:25-2-7 15:24",
    "شراء\nبطاقة:0510;مدى-ابل باي\nمبلغ:SAR 12.26\nلدى:FAIRWAY\nفي:25-2-8 22:10",
    "شراء\nبطاقة:0510;مدى-ابل باي\nمبلغ:SAR 24\nلدى:KEEF ALTA\nفي:25-2-8 17:07",
    "شراء\nبطاقة:0510;مدى-ابل باي\nمبلغ:SAR 5\nلدى:Al Wusoom\nفي:25-2-9 17:24",
    "شراء\nبطاقة:0510;مدى-ابل باي\nمبلغ:SAR 53.77\nلدى:Pure Beve\nفي:25-2-15 14:49",
    "شراء\nبطاقة:0510;مدى-ابل باي\nمبلغ:SAR 13\nلدى:Mtam Smaa\nفي:25-2-16 16:45",
    "شراء\nبطاقة:0510;مدى-ابل باي\nمبلغ:SAR 14\nلدى:GROUP QAF\nفي:25-2-17 10:29"
]

# ---- Utility Functions ----
def get_random_transaction_text() -> str:
    """Returns a random transaction from the dataset."""
    return random.choice(TRANSACTIONS)

# ---- Parsing Functions ----
def extract_transaction_details(transaction: str):

    amount_match = re.search(r"مبلغ:SAR ([\d.]+)", transaction)
    vendor_match = re.search(r"لدى:([\w\s]+)", transaction)
    date_match = re.search(r"في:(\d+-\d+-\d+ \d+:\d+)", transaction)
    type_match = re.search(r"^(شراء|بطاقة ائتمانية:تحويل)", transaction)
    card_number = re.search(r'بطاقة:(\d{4})', transaction)
    if all([amount_match, vendor_match, date_match, type_match]):  
        vendor = vendor_match.group(1).strip().replace("\nفي", "")  
        return {
            "Type": type_match.group(1),
            "Amount (SAR)": float(amount_match.group(1)),
            "Vendor": vendor,
            "Date": pd.to_datetime(date_match.group(1), format="%y-%m-%d %H:%M").isoformat(),
            "Card Number": card_number.group(1)
        }
    return None  

# ---- OpenAI API Call ----
def get_gpt_category(vendor: str) -> str:
    try:
        client = openai.OpenAI()
        response = client.chat.completions.create(
            model="gpt-4o-mini",
            messages=[
                {
                    "role": "system",
                    "content": "You are a financial transaction categorizer. Respond with exactly one category from: Groceries, Restaurants, Dining, Shopping, Beverages, Entertainment, Transport, Health, Education, Other. No additional text."
                },
                {
                    "role": "user",
                    "content": f"Based on the vendor name '{vendor}', what category does this transaction belong to?"
                }
            ],
            temperature=0.3,
            max_tokens=20
        )
        category = response.choices[0].message.content.strip()
        # Validate the category is one of the expected ones
        valid_categories = {"Groceries", "Restaurants", "Dining", "Shopping", 
                          "Beverages", "Entertainment", "Transport", "Health", 
                          "Education"}
        return category if category in valid_categories else "Other"
    except Exception as e:
        print(f"Error calling OpenAI API: {e}")
        return "Other"

# ---- Process Transactions & Save as JSON ----
def analyze_single_transaction(transaction):
    processed_data = []
    parsed_tx = extract_transaction_details(transaction)
    if parsed_tx:
        parsed_tx["Category"] = get_gpt_category(parsed_tx["Vendor"])  
        processed_data.append(parsed_tx)
    return processed_data

def save_transactions_to_json(data, filename="data/transactions_analysis.json"):
    with open(filename, "w", encoding="utf-8") as f:
        json.dump(data, f, ensure_ascii=False, indent=4)
    print(f"Data saved to {filename}")

if __name__ == "__main__":
    random_transaction = get_random_transaction_text()
    categorized_transactions = analyze_single_transaction(random_transaction)
    save_transactions_to_json(categorized_transactions)
 
