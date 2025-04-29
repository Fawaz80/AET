import 'transaction.dart';

class BankAccount {
  final String accountId;
  final String bankName;
  final String accountNumber;
  final String accountType;
  final double balance;
  final List<Transaction> transactions;

  BankAccount({
    required this.accountId,
    required this.bankName,
    required this.accountNumber,
    required this.accountType,
    required this.balance,
    required this.transactions,
  });

  factory BankAccount.fromJson(Map<String, dynamic> json) {
    return BankAccount(
      accountId: json['account_id'],
      bankName: json['bank_name'],
      accountNumber: json['account_number'],
      accountType: json['account_type'],
      balance: json['balance'].toDouble(),
      transactions: List<Transaction>.from(
          json['transactions'].map((x) => Transaction.fromJson(x))),
    );
  }
}

