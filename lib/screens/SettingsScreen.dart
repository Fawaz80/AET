import 'package:flutter/material.dart';
import '../models/financial_data.dart';
class SettingsScreen extends StatelessWidget {
   final FinancialData financialData;

  const SettingsScreen({super.key, required this.financialData});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Settings Screen"));
  }
}
