import 'user.dart';
import 'budget.dart';
import 'category.dart';

class FinancialData {
  final List<User> users;
  final List<Budget> budgets;
  final List<Category> categories;

  FinancialData({
    required this.users,
    required this.budgets,
    required this.categories,
  });

  factory FinancialData.fromJson(Map<String, dynamic> json) {
    return FinancialData(
      users: List<User>.from(json['users'].map((x) => User.fromJson(x))),
      budgets: List<Budget>.from(json['budgets'].map((x) => Budget.fromJson(x))),
      categories: List<Category>.from(
          json['categories'].map((x) => Category.fromJson(x))),
    );
  }
}