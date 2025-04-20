import 'Transaction.dart';


class Card {
  int cardID;
  int userID;
  String bankName;
  List<Transaction> transactions;

  Card({
    required this.cardID,
    required this.userID,
    required this.bankName,
    this.transactions = const [],
  });

  bool addCard(int userID, int cardID, String bankName, List<Transaction> transactions) {
    this.userID = userID;
    this.cardID = cardID;
    this.bankName = bankName;
    this.transactions = transactions;
    return true;
  }

  bool removeCards() {
    // Logic to remove card
    return true;
  }

  List<Transaction> getCardTransactions(int cardID) {
    return transactions.where((t) => t.cardId == cardID.toString()).toList();
  }
}
