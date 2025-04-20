
class SpendingLimit {
  String limitId;
  String userId;
  String type;
  double limit;
  String category;
  List<int> thresholdsNotified;

  SpendingLimit({
    required this.limitId,
    required this.userId,
    required this.type,
    required this.limit,
    required this.category,
    this.thresholdsNotified = const [],
  });

  bool setLimit(String userId, SpendingLimit limitDetails) {
    // Logic to set spending limit
    return true;
  }

  void checkLimit(String userId) {
    // Logic to check spending limit
    return;
  }
}
