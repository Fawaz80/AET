class Transaction {
  String transactionId;
  String cardId;
  double amount;
  String category;
  DateTime date;

  Transaction({
    required this.transactionId,
    required this.cardId,
    required this.amount,
    required this.category,
    required this.date,
  });

  bool addTransaction(Transaction transactionDetails) {
    // Logic to add transaction
    return true;
  }

  List<Transaction> getTransactions(String cardId, dynamic filters) {
    // Logic to get transactions with optional filters
    return [];
  }
}