import '../User/Transaction.dart';
import 'APIClient.dart';

class OpenDataAPI {
  APIClient apiClient;

  OpenDataAPI({required this.apiClient});

  List<Transaction> fetchTransactions(String cardId) {
    // Implement logic to fetch transactions using the APIClient
    // Example: Use apiClient.get to fetch transactions for the given cardId
    return [];
  }
}