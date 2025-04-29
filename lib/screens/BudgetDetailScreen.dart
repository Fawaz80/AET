import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BudgetDetailScreen extends StatelessWidget {
  final Map<String, dynamic> budgetData;

  // Provide the same purple color you use in AnalysisScreen:
  final Color primaryColor = const Color.fromARGB(255, 59, 35, 245);

  const BudgetDetailScreen({super.key, required this.budgetData});

  @override
  Widget build(BuildContext context) {
    // Example fields pulled from budgetData
    final String frequency = budgetData['budgetFrequency'] ?? "Monthly";
    final double budgetAmount = (budgetData['budgetAmount'] ?? 0).toDouble();
    final double budgetCurr = (budgetData['budgetCurr'] ?? 0).toDouble();

    // You can define 'spent in the past 7 days' as budgetCurr
    // or track it differently. For simplicity, let's assume it's budgetCurr.
    final double spentThisWeek = budgetCurr;

    // Leftover = total budget minus current usage
    final double leftover = budgetAmount - spentThisWeek;

    return Scaffold(
      // If you want an AppBar with back arrow, you could do that here or inside the stack.
      body: Stack(
        children: [
          // 1) The purple top section
          Container(
            height: 300,
            color: primaryColor,
            padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Row: back button, etc.
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    // If you want a settings/menu icon on the right:
                    InkWell(
                      onTap: () {
                        // e.g., open some menu or popUp
                      },
                      child: const Icon(Icons.more_vert, color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Title: "Monthly Budget" or "Weekly Budget"
                Text(
                  "$frequency Budget",
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),

                // "You've spent SR ___ for the past 7 days"
                Text(
                  "You’ve spent SR ${spentThisWeek.toStringAsFixed(2)} for the past 7 days",
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),

          // 2) The white container overlay
          Positioned(
            top: 240, // a bit less than 300, so there's a purple overlap
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // "What's left to spend"
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "What's left to spend",
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          // e.g. "SR 120"
                          "SR ${leftover.toStringAsFixed(2)}",
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
                    // If you want a simple progress bar showing how much spent vs. total,
                    // you could add it here. Or skip it entirely. No red line / message.
                    // Example of a single color progress:
                    /*
                    LinearProgressIndicator(
                      value: (spentThisWeek / budgetAmount).clamp(0, 1),
                      backgroundColor: Colors.grey.shade300,
                      color: primaryColor,
                      minHeight: 6,
                    ),
                    const SizedBox(height: 20),
                    */
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
