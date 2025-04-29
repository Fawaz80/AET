import 'bank_account.dart';
class User {
  final String userId;
  final PersonalInfo personalInfo;
  final Preferences preferences;
  final List<BankAccount> bankAccounts;

  User({
    required this.userId,
    required this.personalInfo,
    required this.preferences,
    required this.bankAccounts,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['user_id'],
      personalInfo: PersonalInfo.fromJson(json['personal_info']),
      preferences: Preferences.fromJson(json['preferences']),
      bankAccounts: List<BankAccount>.from(
          json['bank_accounts'].map((x) => BankAccount.fromJson(x))),
    );
  }
}

class PersonalInfo {
  final String name;
  final String dob;

  PersonalInfo({
    required this.name,
    required this.dob,
  });

  factory PersonalInfo.fromJson(Map<String, dynamic> json) {
    return PersonalInfo(
      name: json['name'],
      dob: json['dob'],
    );
  }
}

class Preferences {
  final String theme;
  final String language;
  final bool notificationsEnabled;

  Preferences({
    required this.theme,
    required this.language,
    required this.notificationsEnabled,
  });

  factory Preferences.fromJson(Map<String, dynamic> json) {
    return Preferences(
      theme: json['theme'],
      language: json['language'],
      notificationsEnabled: json['notifications_enabled'],
    );
  }
}