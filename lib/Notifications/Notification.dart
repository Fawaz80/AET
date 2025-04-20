
class Notification {
  String notificationId;
  String message;
  DateTime date;

  Notification({
    required this.notificationId,
    required this.message,
    required this.date,
  });

  bool sendNotification(String userId, String message) {
    // Logic to send notification
    return true;
  }
}