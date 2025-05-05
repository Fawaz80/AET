import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BudgetDetailScreen extends StatelessWidget {
  final Map<String, dynamic> budgetData;
  final Color primaryColor = const Color.fromARGB(255, 59, 35, 245);

  const BudgetDetailScreen({
    Key? key,
    required this.budgetData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String frequency = budgetData['budgetFrequency'] ?? "Monthly";
    final double budgetAmount =
        (budgetData['budgetAmount'] ?? 0).toDouble();
    final double budgetCurr =
        (budgetData['budgetCurr'] ?? 0).toDouble();
    final double leftover =
        (budgetAmount - budgetCurr).clamp(0, double.infinity);

    // If monthly, split into 4; if weekly, limit = budgetAmount
    final double weeklyLimit = frequency == "Monthly"
        ? budgetAmount / 4
        : budgetAmount;

    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        children: [
          // 1) Purple header
          SafeArea(
            bottom: false,
            child: Container(
              color: primaryColor,
              padding: const EdgeInsets.symmetric(
                  horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top row: back + delete
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(Icons.arrow_back,
                            color: Colors.white),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pop(context, {
                          'action': 'delete',
                          'budget': budgetData,
                        }),
                        child: const Icon(Icons.delete,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Title
                  Text(
                    "$frequency Budget",
                    style: GoogleFonts.inter(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "You’ve spent SR ${budgetCurr.toStringAsFixed(2)} for the past 7 days",
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 48),

          // 2) White body
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                    top: Radius.circular(32)),
              ),
              padding: const EdgeInsets.fromLTRB(
                  20, 24, 20, 0),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.stretch,
                children: [
                  // "What's left to spend" row
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "What’s left to spend",
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        "SR ${leftover.toStringAsFixed(2)}",
                        style: GoogleFonts.inter(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),

                  // Card with spent / limit info
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius:
                          BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        // Labels row
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment
                                  .spaceBetween,
                          children: [
                            Text(
                              "You’ve already spent",
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight:
                                    FontWeight.w500,
                                color: Colors.black54,
                              ),
                            ),
                            Text(
                              "Spend limit per week",
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight:
                                    FontWeight.w500,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        // Values row
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment
                                  .spaceBetween,
                          children: [
                            Text(
                              "SR ${budgetCurr.toStringAsFixed(0)}",
                              style: GoogleFonts.inter(
                                fontSize: 20,
                                fontWeight:
                                    FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            Text(
                              weeklyLimit
                                  .toStringAsFixed(0),
                              style: GoogleFonts.inter(
                                fontSize: 20,
                                fontWeight:
                                    FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        // Progress bar
                        LinearProgressIndicator(
                          value: (budgetCurr /
                                  weeklyLimit)
                              .clamp(0, 1),
                          backgroundColor:
                              Color.fromARGB(20, 13, 119,207),
                          color: primaryColor,
                          minHeight: 10,
                        ),
                        const SizedBox(height: 12),
                      
                      ],
                    ),
                  ),

                  // …additional content like "Add spending" goes here…
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
