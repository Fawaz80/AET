import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum BudgetType { monthly, weekly }

class BudgetCard extends StatefulWidget {
  final String budgetTitle;
  final double budgetAmount;
  final double? budgetCurr;
  final String message;
  final int? alert;
  final DateTime budgetDate;
  final String budgetType;

  const BudgetCard({
    Key? key,
    required this.budgetTitle,
    required this.budgetAmount,
    required this.budgetCurr,
    required this.message,
    required this.budgetDate,
    required this.budgetType,
    this.alert,
  }) : super(key: key);

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

  // Mapping from category name to emoji
  static const Map<String, String> _categoryEmoji = {
    'Restaurants':   '🍽️',
    'Cafe':          '☕',
    'Gas':           '⛽',
    'Groceries':     '🛒',
    'Entertainment': '🎬',
    'Shopping':      '🛍️',
  };

  @override
  Widget build(BuildContext context) {
    final String emoji = _categoryEmoji[widget.budgetTitle] ?? '';
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _isSelected 
            ? Colors.blue.shade700 
            : const Color.fromARGB(255, 67, 45, 236),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top text: budget frequency or type
          Text(
            '${widget.budgetType[0].toUpperCase()}${widget.budgetType.substring(1)} Budget',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),

          // Row with the emoji, category title, and amount
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 24,
                    child: Text(
                      emoji,
                      style: const TextStyle(fontSize: 28),
                    ),
                  ),
                  const SizedBox(width: 12),
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
              Text(
                'SR ${widget.budgetAmount.toStringAsFixed(0)}',
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
          Stack(
            children: [
              Container(
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.blue[800],
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              LayoutBuilder(builder: (context, constraints) {
                final double percent =
                    (widget.budgetCurr ?? 0) / widget.budgetAmount;
                final width = constraints.maxWidth * percent.clamp(0, 1);
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

          // Optional message
          if (widget.message.isNotEmpty) ...[
            Text(
              widget.message,
              style: GoogleFonts.inter(color: Colors.white70),
            ),
          ],
        ],
      ),
    );
  }
}
