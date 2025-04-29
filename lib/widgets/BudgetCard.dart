import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum BudgetType { monthly, weekly}

class BudgetCard extends StatefulWidget {
  /// You can pass in whatever values make sense for your app.
  /// For example:
  ///   - budgetTitle: "Food"
  ///   - budgetAmount: 3500
  ///   - progressPercent: 0.7 (meaning 70% spent)
  ///   - message: "You are doing really great!"
  ///
  final String budgetTitle;
  final double budgetAmount;
  final double? budgetCurr;
  final String message;
  final int? alert;
  final DateTime budgetDate;
  final String budgetType;

  const BudgetCard({
    super.key,
    required this.budgetTitle,
    required this.budgetAmount,
    required this.budgetCurr,
    required this.message,
    required this.budgetDate,
    required this.budgetType,
    this.alert,
  });

  @override
  _BudgetCardState createState() => _BudgetCardState();

}

class _BudgetCardState extends State<BudgetCard> {

  bool _isSelected = false;

  void _toggleSelection() {
    setState(() {
      _isSelected = !_isSelected;
    });
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 67, 45, 236),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top text: "Monthly Budget"
          Text(
            "Monthly Budget",
            style: GoogleFonts.inter(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
          ),
          const SizedBox(height: 12),

          // Row with the emoji (or image), budget title and amount
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  // Circle avatar for the "party popper" emoji or an icon.
                  // If you have an image asset, you can use AssetImage;
                  // or if you just want an emoji, wrap it in a Text widget with a bigger fontSize.
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 24,
                    child: Text(
                      "🎉",
                      style: TextStyle(
                        fontSize: 28,
                        color: Colors.orange[700],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Budget category title
                  Text(
                    widget.budgetTitle,
                    style: GoogleFonts.inter(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                        ),
                  ),
                ],
              ),

              
              // Budget amount on the right side
              Text(
                "SR ${widget.budgetAmount.toStringAsFixed(0)}", 
                style: GoogleFonts.inter(
                      color: Colors.greenAccent,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Progress bar
          // You can either use LinearProgressIndicator or build a custom bar.
          Stack(
            children: [
              Container(
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.blue[800],
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              // The actual "filled" portion
              LayoutBuilder(builder: (context, constraints) {
                final width = constraints.maxWidth * ((widget.budgetCurr ?? 0) / widget.budgetAmount);
                return Container(
                  height: 8,
                  width: width,
                  decoration: BoxDecoration(
                    color: Colors.greenAccent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                );
              }),
            ],
          ),
          const SizedBox(height: 16),
          // Bottom row for the emoji + message
        ],
      ),
    );
  }
}