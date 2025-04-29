import '../widgets/BudgetCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

/// Call this function wherever you want to show the create budget modal.
/// For example, on button press: showCreateBudgetModal(context);
void showCreateBudgetModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) {
      return const CreateBudgetModal();
    },
  );
}

enum BudgetType { monthly, weekly}

class CreateBudgetModal extends StatefulWidget {
  const CreateBudgetModal({super.key});

  @override
  State<CreateBudgetModal> createState() => _CreateBudgetModalState();
}

class _CreateBudgetModalState extends State<CreateBudgetModal> {
  // Page controller for two pages
  final PageController _pageController = PageController();

  // User inputs (from Page 1)
  String budgetFrequency = 'Monthly';
  String category = '';
  DateTime? budgetDate = DateTime.now();
  double budgetAmount = 0;

  // Alert toggle & slider (shown on Page 2)
  bool receiveAlert = false;
  double alertValue = 0.8; // 80% by default

  // Current page index
  int _currentPage = 0;

  // Colors & text styles
  final Color primaryColor = const Color(0xFF5F2EEA); // main accent
  final Color backgroundColor = const Color(0xFFF6F4FA);

  // For the calendar icon color, if you wish to reuse the old color
  final Color calendarIconColor = const Color.fromARGB(255, 59, 35, 245);

  TextStyle get headlineStyle => GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      );

  TextStyle get subtitleStyle => GoogleFonts.inter(
        fontSize: 14,
        color: Colors.black54,
      );

  TextStyle get labelStyle => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
      );

  TextStyle get inputStyle => GoogleFonts.inter(
        fontSize: 16,
        color: Colors.black87,
      );

  @override
  Widget build(BuildContext context) {
    final double modalHeight = MediaQuery.of(context).size.height * 0.95;

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      height: modalHeight,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          // Drag handle (optional)
          Container(
            width: 40,
            height: 5,
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
          ),

          // PageView
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildPage1(),
                _buildPage2(),
              ],
            ),
          ),

          // Bottom nav row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Back / Cancel
              TextButton(
                onPressed: _currentPage == 0
                    ? () => Navigator.pop(context)
                    : _goToPreviousPage,
                child: Text(
                  _currentPage == 0 ? "Cancel" : "Back",
                  style: GoogleFonts.inter(
                    color: primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              // Next / Create
              ElevatedButton(
                onPressed: _getActionButtonOnPressed(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                child: Text(
                  _currentPage == 0 ? "Next" : "Create budget",
                  style: GoogleFonts.inter(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- Page Navigation & Validation ---

  VoidCallback? _getActionButtonOnPressed() {
    if (_currentPage == 0) {
      // Validate page 1
      return _validatePage1() ? _goToNextPage : null;
    } else {
      // Validate page 2, then submit
      return _validatePage2() ? _submitBudget : null;
    }
  }

  void _goToNextPage() {
    setState(() {
      _currentPage = 1;
    });
    _pageController.animateToPage(
      1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _goToPreviousPage() {
    setState(() {
      _currentPage = 0;
    });
    _pageController.animateToPage(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  bool _validatePage1() {
    // Must pick frequency, category, date, and have an amount > 0
    return budgetFrequency.isNotEmpty &&
        category.trim().isNotEmpty &&
        budgetDate != null &&
        budgetAmount > 0;
  }

  bool _validatePage2() {
    // Already collected everything. If you have new inputs on page2, validate them
    // For now, we just rely on page1 being valid
    return true;
  }

  // --- Page 1: Frequency, Category, Date, and Amount ---

  // 1) Add a controller at the top of your _AnalysisState (or wherever the modal is):
final TextEditingController _amountController = TextEditingController(text: "0");

// 2) Modify your _buildPage1() to include a TextField:
Widget _buildPage1() {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Create your budget", style: headlineStyle),
        const SizedBox(height: 8),
        Text(
          "Select how often you'll track your budget, pick a category, choose a date, and set an amount.",
          style: subtitleStyle,
        ),
        const SizedBox(height: 24),

        // Budget Frequency
        Text("Budget Frequency", style: labelStyle),
        const SizedBox(height: 8),
        Row(
          children: [
            Radio<String>(
              value: "Monthly",
              groupValue: budgetFrequency,
              activeColor: primaryColor,
              onChanged: (val) {
                setState(() {
                  budgetFrequency = val ?? "Monthly";
                });
              },
            ),
            Text("Monthly", style: inputStyle),
            const SizedBox(width: 20),
            Radio<String>(
              value: "Weekly",
              groupValue: budgetFrequency,
              activeColor: primaryColor,
              onChanged: (val) {
                setState(() {
                  budgetFrequency = val ?? "Weekly";
                });
              },
            ),
            Text("Weekly", style: inputStyle),
          ],
        ),
        const SizedBox(height: 24),

        // Category
        Text("Category", style: labelStyle),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: category.isEmpty ? null : category,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          hint: Text("Select a category", style: inputStyle),
          items: const [
            DropdownMenuItem(
              value: "Restaurants",
              child: Text("🍽 Restaurants"),
            ),
            DropdownMenuItem(
              value: "Cafe",
              child: Text("☕ Cafe"),
            ),
            DropdownMenuItem(
              value: "Gas",
              child: Text("⛽ Gas"),
            ),
            DropdownMenuItem(
              value: "Groceries",
              child: Text("🛒 Groceries"),
            ),
            DropdownMenuItem(
              value: "Entertainment",
              child: Text("🎉 Entertainment"),
            ),
            DropdownMenuItem(
              value: "Shopping",
              child: Text("🛍 Shopping"),
            ),
          ],
          onChanged: (val) {
            setState(() {
              category = val ?? '';
            });
          },
        ),
        const SizedBox(height: 24),

        // Date selection
        Text("Select Date", style: labelStyle),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: _selectDate,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.calendar_month, color: calendarIconColor),
                const SizedBox(width: 12),
                Text(
                  budgetDate == null
                      ? "Select date"
                      : _formatDate(budgetDate!),
                  style: inputStyle.copyWith(
                    color: budgetDate == null
                        ? Colors.black26
                        : Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),

        // Budget Amount
        Text("Budget Amount", style: labelStyle),
        const SizedBox(height: 8),

        // A large TextField in the center so user can type the amount
        Center(
          child: SizedBox(
            width: 200, // choose a width that fits your design
            child: TextField(
              controller: _amountController,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              style: GoogleFonts.inter(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
              decoration: InputDecoration(
                border: InputBorder.none, // or OutlineInputBorder if you prefer
                hintText: "0",
                hintStyle: TextStyle(color: Colors.black26),
              ),
              onChanged: (value) {
                setState(() {
                  budgetAmount = double.tryParse(value) ?? 0;
                });
              },
            ),
          ),
        ),

        const SizedBox(height: 24),

        // Quick increments row (+100, +500, +1000)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _quickAmountButton(100),
            _quickAmountButton(500),
            _quickAmountButton(1000),
          ],
        ),
      ],
    ),
  );
}

  /// Page 2: Budget Preview UI 
Widget _buildPage2() {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Text("Budget preview", style: headlineStyle),
        const SizedBox(height: 8),

        Text(
          "Here's a quick summary of your budget before creating it.",
          style: subtitleStyle,
        ),
        const SizedBox(height: 24),

        // The purple card (similar to your screenshot, minus the account info)
        Container(
          child: BudgetCard(budgetAmount: budgetAmount,budgetTitle: category ,message: 'WOW',budgetCurr: 0, budgetDate: budgetDate!, budgetType: budgetFrequency,)
        ),

        // Spacing below the card
        const SizedBox(height: 24),

        // Start Date section
        Text("Start date", style: labelStyle),
        const SizedBox(height: 8),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              budgetDate == null
                  ? "--/--/----"
                  : "${_formatDate(budgetDate!)}  $budgetFrequency budget",
              style: inputStyle,
            ),
            InkWell(
              onTap: _changeDate,
              child: Text(
                "Change",
                style: GoogleFonts.inter(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),

        // Spacing between date and alert
        const SizedBox(height: 24),

        // Receive Alert section
        Text("Receive Alert", style: labelStyle),
        const SizedBox(height: 8),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Receive alert when it\nreaches a certain limit",
              style: subtitleStyle.copyWith(color: Colors.black87),
            ),
            Switch(
              value: receiveAlert,
              activeColor: primaryColor,
              onChanged: (val) {
                setState(() {
                  receiveAlert = val;
                });
              },
            ),
          ],
        ),

        // If user enabled alerts, show slider
        if (receiveAlert) ...[
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Slider(
                  value: alertValue,
                  onChanged: (val) {
                    setState(() {
                      alertValue = val;
                    });
                  },
                  activeColor: primaryColor,
                  inactiveColor: Colors.grey.shade300,
                ),
              ),
              Text(
                "${(alertValue * 100).round()}%",
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ],

        // Extra bottom spacing if needed
        const SizedBox(height: 40),
      ],
    ),
  );
}


  // Quick increments on Page 1
  Widget _quickAmountButton(int amount) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          budgetAmount += amount;
          _amountController.text = budgetAmount.toString();
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 0,
      ),
      child: Text(
        "+$amount",
        style: inputStyle.copyWith(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  // Show date picker for initial selection
  Future<void> _selectDate() async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 2),
      lastDate: DateTime(now.year + 5),
    );
    if (pickedDate != null) {
      setState(() {
        budgetDate = pickedDate;
      });
    }
  }

  // "Change" date from page 2
  Future<void> _changeDate() async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: budgetDate ?? now,
      firstDate: DateTime(now.year - 2),
      lastDate: DateTime(now.year + 5),
    );
    if (pickedDate != null) {
      setState(() {
        budgetDate = pickedDate;
      });
    }
  }

  // Format e.g. "Jan 20, 2022"
  String _formatDate(DateTime date) {
    final months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
    ];
    final m = months[date.month - 1];
    final d = date.day;
    final y = date.year;
    return "$m $d, $y";
  }

  /// Submit the budget (pop with all data)
  void _submitBudget() {
    Navigator.pop(
      context,
      {
        'budgetType': budgetFrequency,
        'category': category,
        'budgetDate': budgetDate,
        'budgetAmount': budgetAmount,
        'receiveAlert': receiveAlert,
        'alertThreshold': alertValue, // 0..1 range
      },
    );
  }
}
