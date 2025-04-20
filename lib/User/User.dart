
import 'Settings.dart';

class User{
  int id;
  String name;
  String email;
  String phoneNumber;
  Settings settings;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.settings,
  });

  bool registerUser(String name, String email, String phoneNumber) {
    this.name = name;
    this.email = email;
    this.phoneNumber = phoneNumber;
    return true;
  }

  bool updateSettings(Settings newSettings) {
    settings = newSettings;
    return true;
  }

  User getUserDetails() {
    return this;
  }
}
