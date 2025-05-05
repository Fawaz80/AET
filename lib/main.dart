import 'package:auto_expense_tracker/screens/BudgetScreen.dart';
import 'package:auto_expense_tracker/screens/EditProfileScreen.dart';
import 'package:auto_expense_tracker/screens/ProfileScreen.dart';
import 'package:flutter/material.dart';
import 'package:auto_expense_tracker/screens/HomeScreen.dart';
import 'package:auto_expense_tracker/screens/AnalysisScreen.dart';
import 'package:auto_expense_tracker/screens/SettingsScreen.dart';
import 'package:auto_expense_tracker/screens/ChatScreen.dart'; // Add this import
import 'package:auto_expense_tracker/assets/financial_data_service.dart';
import 'package:auto_expense_tracker/models/financial_data.dart';

import 'screens/ChatScreen.dart';

void main() async {
  // Ensure Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();
  print('financial data values starting ');
  // Load financial data before running the app
  final FinancialDataService dataService = FinancialDataService();
  final FinancialData financialData = await dataService.loadFinancialData();
  print('financial data values given ');

  runApp(
    MyApp(financialData: financialData),
  );
}

class MyApp extends StatelessWidget {
  final FinancialData financialData;

  const MyApp({super.key, required this.financialData});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DashboardScreen(
        financialData: financialData,
      ),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  final FinancialData financialData;

  const DashboardScreen({super.key, required this.financialData});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    // Initialize pages with the financial data
    _pages = [
      HomeScreen(financialData: widget.financialData),
      AnalysisScreen(financialData: widget.financialData),
      ChatScreen(), // New Chatbot screen in the middle
      BudgetScreen(),
      ProfileScreen(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 40), // Directly set size here
              label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.pie_chart, size: 40), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.chat, size: 40), label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.wallet, size: 40), label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.person, size: 40), label: ""),
        ],
      ),
    );
  }
}
