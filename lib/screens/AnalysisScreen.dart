import 'package:auto_expense_tracker/widgets/analysis_barchart.dart';
import 'package:auto_expense_tracker/widgets/analysis_piechart.dart';
import 'package:auto_expense_tracker/widgets/transaction_search_bar.dart';
import 'package:flutter/material.dart';
import '../models/financial_data.dart';

class AnalysisScreen extends StatefulWidget {
  final FinancialData financialData;

  const AnalysisScreen({super.key, required this.financialData});

  @override
  State<AnalysisScreen> createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> {
  int _currentTextIndex = 0;
  final List<String> _analysisTexts = ['PieChart', 'BarChart'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50),
            // Search bar (fixed at top)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: TransactionSearchBar(),
            ),
            // Chart area with swipe gestures
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.6, // 60% of screen
              child: GestureDetector(
                onHorizontalDragEnd: (details) {
                  if (details.primaryVelocity == null) return;
                  
                  if (details.primaryVelocity! > 0) {
                    // Right swipe
                    setState(() {
                      _currentTextIndex = (_currentTextIndex + 1) % _analysisTexts.length;
                    });
                  } else if (details.primaryVelocity! < 0) {
                    // Left swipe
                    setState(() {
                      _currentTextIndex = (_currentTextIndex - 1) % _analysisTexts.length;
                      if (_currentTextIndex < 0) {
                        _currentTextIndex = _analysisTexts.length - 1;
                      }
                    });
                  }
                },
                child: _buildCurrentChart(),
              ),
            ),
            // Additional content
            _buildTransactionList(),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentChart() {
    try {
      switch (_currentTextIndex) {
        case 0:
          return const AnalysisPiechart();
        case 1:
          return const AnalysisBarchart();
        default:
          return const AnalysisPiechart();
      }
    } catch (e) {
      return Center(
        child: Text('Error loading chart: ${e.toString()}'),
      );
    }
  }

  Widget _buildTransactionList() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recent Transactions',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 10,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              return ListTile(
                leading: const Icon(Icons.receipt, color: Colors.blue),
                title: Text('Transaction ${index + 1}'),
                subtitle: Text('Category • ${_getFormattedDate(index)}'),
                trailing: Text(
                  '-\$${(index + 1) * 50}',
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  String _getFormattedDate(int daysAgo) {
    final date = DateTime.now().subtract(Duration(days: daysAgo));
    return '${date.day}/${date.month}/${date.year}';
  }
}