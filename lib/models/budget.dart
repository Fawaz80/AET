class Budget {
  final String budgetId;
  final String category;
  final int amountAllocated;
  final String timePeriod;
  final NotificationThresholds notificationThresholds;

  Budget({
    required this.budgetId,
    required this.category,
    required this.amountAllocated,
    required this.timePeriod,
    required this.notificationThresholds,
  });

  factory Budget.fromJson(Map<String, dynamic> json) {
    return Budget(
      budgetId: json['budget_id'],
      category: json['category'],
      amountAllocated: json['amount_allocated'],
      timePeriod: json['time_period'],
      notificationThresholds:
          NotificationThresholds.fromJson(json['notification_thresholds']),
    );
  }
}

class NotificationThresholds {
  final int warning;
  final int critical;

  NotificationThresholds({
    required this.warning,
    required this.critical,
  });

  factory NotificationThresholds.fromJson(Map<String, dynamic> json) {
    return NotificationThresholds(
      warning: json['warning'],
      critical: json['critical'],
    );
  }
}