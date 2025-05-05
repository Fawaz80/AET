import 'package:auto_expense_tracker/widgets/analysis_barchart.dart';
import 'package:auto_expense_tracker/widgets/analysis_piechart.dart';
import 'package:auto_expense_tracker/widgets/transaction_search_bar.dart';
import 'package:flutter/material.dart';
import '../models/financial_data.dart';
import 'dart:math';

class AnalysisScreen extends StatefulWidget {
  final FinancialData financialData;

  const AnalysisScreen({super.key, required this.financialData});

  @override
  State<AnalysisScreen> createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> {
  int _currentTextIndex = 0;
  final List<String> _analysisTexts = ['PieChart', 'BarChart'];
  final Random _random = Random();

  String _sortValue = 'By Month';
  String _filterValue = 'By Date';

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
            // Sort & Filter Controls with "Expense" title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Right side: label
                  const Text(
                    'Expense',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      height: 1.0,
                    ),
                  ),
                  Row(
                    children: [
                      DropdownButton<String>(
                        value: _sortValue,
                        items: ['By Year', 'By Month', 'By Week']
                            .map((value) => DropdownMenuItem(
                                  value: value,
                                  child: Text(value),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _sortValue = value!;
                          });
                        },
                      ),
                      const SizedBox(width: 8),
                      DropdownButton<String>(
                        value: _filterValue,
                        items: ['By Date', 'By Category']
                            .map((value) => DropdownMenuItem(
                                  value: value,
                                  child: Text(value),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _filterValue = value!;
                          });
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),

            // Chart area with swipe gestures
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.35,
              child: GestureDetector(
                onHorizontalDragEnd: (details) {
                  if (details.primaryVelocity == null) return;

                  if (details.primaryVelocity! > 0) {
                    // Right swipe
                    setState(() {
                      _currentTextIndex =
                          (_currentTextIndex + 1) % _analysisTexts.length;
                    });
                  } else if (details.primaryVelocity! < 0) {
                    // Left swipe
                    setState(() {
                      _currentTextIndex =
                          (_currentTextIndex - 1) % _analysisTexts.length;
                      if (_currentTextIndex < 0) {
                        _currentTextIndex = _analysisTexts.length - 1;
                      }
                    });
                  }
                },
                child: _buildCurrentChart(),
              ),
            ),

            // Transaction List
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
    // List of company names
    final List<String> companies = [
      'McDonalds',
      'Apple CO.',
      'Zara Co.',
      'Meed',
      'Steam Store',
      'Mcdonalds',
      'Samsung inc.',
      'Tommy Hilfiger',
      'Aramco Co.',
      'Uber'
    ];

    // List of categories
    final List<String> categories = [
      'Food',
      'Electronics',
      'Clothes',
      'Gas',
      'Other'
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 12.0),
            child: Text(
              'Recent Transactions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                height: 1.0,
              ),
            ),
          ),
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: companies.length,
            separatorBuilder: (context, index) =>
                const Divider(height: 1, thickness: 1),
            itemBuilder: (context, index) {
              final company = companies[index];
              final category = categories[index % categories.length];
              final amount = (_random.nextInt(750) + 1).toString();
              final date = _getFormattedDate(index);
              final receiptNumber = 'RCPT-${1000 + index}';

              return InkWell(
                onTap: () {
                  _showTransactionDetails(
                    context,
                    company: company,
                    amount: amount,
                    date: date,
                    category: category,
                    receiptNumber: receiptNumber,
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            _getCategoryIcon(category),
                            color: _getCategoryColor(category),
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                company,
                                style: const TextStyle(fontSize: 14),
                              ),
                              Text(
                                '$category • $date',
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.grey),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Text(
                        '-\$$amount',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _showTransactionDetails(
    BuildContext context, {
    required String company,
    required String amount,
    required String date,
    required String category,
    required String receiptNumber,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Transaction Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetailRow('Company:', company),
              _buildDetailRow('Amount:', '-\$$amount'),
              _buildDetailRow('Date:', date),
              _buildDetailRow('Category:', category),
              _buildDetailRow('Receipt #:', receiptNumber),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 8),
          Text(value),
        ],
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Food':
        return Icons.restaurant;
      case 'Electronics':
        return Icons.electrical_services;
      case 'Clothes':
        return Icons.checkroom;
      case 'Gas':
        return Icons.local_gas_station;
      default:
        return Icons.receipt;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Food':
        return Colors.green;
      case 'Electronics':
        return Colors.blue;
      case 'Clothes':
        return Colors.purple;
      case 'Gas':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  String _getFormattedDate(int daysAgo) {
    final date = DateTime.now().subtract(Duration(days: daysAgo));
    return '${date.day}/${date.month}/${date.year}';
  }
}