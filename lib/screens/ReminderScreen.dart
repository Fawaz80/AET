import 'package:flutter/material.dart';
import '../models/financial_data.dart';
class ReminderScreen extends StatelessWidget {
   final FinancialData financialData;

  const ReminderScreen({super.key, required this.financialData});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Reminder Screen"));
  }
}