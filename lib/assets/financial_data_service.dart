import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/financial_data.dart';

class FinancialDataService
 {
  Future<FinancialData> loadFinancialData() async {
    try {
      // Load JSON file from assets
      final String jsonString =
          await rootBundle.loadString('lib/assets/Data.json');
      
      // Parse JSON string
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      
      // Convert to FinancialData object
      return FinancialData.fromJson(jsonData);
    } catch (e) {
      throw Exception('Failed to load financial data: $e');
    }
  }
}