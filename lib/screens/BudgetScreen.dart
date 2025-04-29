import 'package:auto_expense_tracker/screens/BudgetDetailScreen.dart';
import 'package:auto_expense_tracker/screens/CreateBudget.dart';
import '../widgets/BudgetCard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({super.key});

  @override
  _AnalysisState createState() => _AnalysisState();
}

class _AnalysisState extends State<BudgetScreen> {
  // Keep a list of all newly created budgets
  // Each item in the list is a Map<String, dynamic> returned by CreateBudgetModal
  final List<Map<String, dynamic>> _budgets = [];

  /// Use async so we can 'await' the result from showModalBottomSheet
  Future<void> _openAddExpenseOverlay() async {
    final result = await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        // Return your existing CreateBudgetModal widget here
        return const CreateBudgetModal();
      },
    );

    // If the user actually created a budget, 'result' will be a Map
    // If user cancelled, result might be null
    if (result != null && result is Map<String, dynamic>) {
      if (!result.containsKey('budgetAmount')) {
        result['budgetAmount'] = 0;
      }
      if (!result.containsKey('budgetCurr')) {
        result['budgetCurr'] = 0;
      }
      if (!result.containsKey('category')) {
        result['category'] = 'Misc';
      }
      if (!result.containsKey('budgetFrequency')) {
        result['budgetFrequency'] = 'Monthly';
      }
      setState(() {
        // Add the newly created budget to the list
        _budgets.add(result);
      });
    }
  }

  Future<void> _openBudgetDetails(int index, Map<String, dynamic> data) async {
    // Replace `BudgetDetailScreen` with whatever you name your detail page widget.
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => BudgetDetailScreen(
          budgetData: data,
        ),
      ),
    );

    // If user pressed 'Save' or 'Delete', the detail page might return a Map:
    // { 'action': 'delete' } or { 'action': 'update', 'budget': updatedMap }
    if (result == null) return; // user pressed back, no changes

    final action = result['action'];
    final returnedBudget = result['budget'] as Map<String, dynamic>?;

    if (action == 'delete' && returnedBudget != null) {
      setState(() {
        // Removes by object reference
        _budgets.remove(returnedBudget);
      });
    } else if (action == 'update' && returnedBudget != null) {
      // Find old item in _budgets, replace with updated
      final oldIndex = _budgets.indexOf(data);
      if (oldIndex != -1) {
        setState(() {
          _budgets[oldIndex] = returnedBudget;
        });
      }
    }
  }

  double get totalSpent {
    double sum = 0;
    for (final bud in _budgets) {
      // Make sure each bud has 'budgetCurr'
      sum += (bud['budgetCurr'] ?? 0);
    }
    return sum;
  }

  double get totalBudget {
    double sum = 0;
    for (final bud in _budgets) {
      // Make sure each bud has 'budgetAmount'
      sum += (bud['budgetAmount'] ?? 0);
    }
    return sum;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 59, 35, 245),
      body: Stack(
        children: [
          Column(
            children: [
              // Top Section (Fixed)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 59, 35, 245),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 44), // For status bar spacing
                    const SizedBox(
                      height: 44,
                      child: Text(
                        "Budget",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 26),
                    SizedBox(
                      height: 72,
                      child: Column(
                        children: [
                          Text(
                            "SR ${(totalBudget - totalSpent).toStringAsFixed(2)} Left",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 29,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Out of SR ${totalBudget.toStringAsFixed(2)}",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: _openAddExpenseOverlay,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text("+ Create new budget"),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Scrollable Bottom Section + Decorations
          Stack(
            children: [
              Positioned(
                top: 10,
                left: 0,
                child: Opacity(
                  opacity: 1,
                  child: Image.asset('assets/images/Coint.png'),
                ),
              ),
              Positioned(
                top: 165,
                right: 0,
                child: Opacity(
                  opacity: 1,
                  child: Image.asset('assets/images/coin.png'),
                ),
              ),
              Positioned(
                top: 340, // Adjust based on top section height
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(32)),
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: _budgets.isEmpty
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 90),
                                // Larger bold text
                                Text(
                                  "There are no Budgets here yet.",
                                  style: GoogleFonts.inter(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors
                                        .black, // or your preferred text color
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 12),
                                // Smaller gray text
                                Text(
                                  "Press the Create New Budget button to create your first Budget!",
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black54, // slightly gray
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                // Existing code that shows your BudgetCard widgets
                                for (int i = 0; i < _budgets.length; i++) ...[
                                  GestureDetector(
                                    onTap: () =>
                                        _openBudgetDetails(i, _budgets[i]),
                                    child: BudgetCard(
                                      budgetTitle: _budgets[i]['category'],
                                      budgetAmount: _budgets[i]['budgetAmount'],
                                      budgetCurr: _budgets[i]['budgetCurr'],
                                      message: '',
                                      budgetDate: _budgets[i]['budgetDate'],
                                      budgetType: _budgets[i]['budgetType'],
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                ],
                              ],
                            ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
