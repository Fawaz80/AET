import 'package:auto_expense_tracker/models/financial_data.dart';
import 'package:auto_expense_tracker/widgets/transaction_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class HomeScreen extends StatefulWidget {
  final FinancialData financialData;

  const HomeScreen({super.key, required this.financialData});

  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  List<Map<String, dynamic>> cards = [
    {
      'color': Colors.green,
      'amount': '4321',
      'subtitle': 'AlAhli Bank',
      'icon': Icons.account_balance_wallet,
    },
    {
      'color': Colors.blue,
      'amount': '5678',
      'subtitle': 'AlRajhi',
      'icon': Icons.account_balance_wallet,
    },
    {
      'color': Colors.brown,
      'amount': '9012',
      'subtitle': 'Alinma',
      'icon': Icons.account_balance_wallet,
    },
    {
      'color': Colors.blue.shade900,
      'amount': '3456',
      'subtitle': 'BSF',
      'icon': Icons.account_balance_wallet,
    },
  ];

  String selectedRange = "Wk"; // Wk, Mn, Yr
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _expiryController = TextEditingController();
  String _selectedBank = 'AlRajhi';
  double totalExpenses = 3470.0; // Initial total expenses
  final TextEditingController _expenseAmountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final todayIndex = DateTime.now().weekday % 7; // 0: Sunday, ..., 6: Saturday
    final currentDayValue = (todayIndex + 3).toDouble(); // Value for current day

    return Column(
      
      children: [
         const SizedBox(height: 70),
        
        SizedBox(
          height: 200, // Increased height by 20px
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: cards.length + 1, // +1 for the add card button
            itemBuilder: (context, index) {
              if (index == cards.length) {
                return _buildAddCardButton(context);
              }
              return SizedBox(
                width: 150,
                height: 200,
                child: Container(
                  margin: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        cards[index]['color'],
                        cards[index]['color'].withOpacity(0.7),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          cards[index]['icon'],
                          color: Colors.white,
                          size: 24,
                        ),
                        const Spacer(),
                        Center(
                          child: Text(
                            cards[index]['amount'],
                            style: const TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          cards[index]['subtitle'],
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 30),
        // Updated Total Expenses row
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            
            child: Row(
              children: [
                const Text(
                  "Total Expenses: ",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  "\$${totalExpenses.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => _showAddExpenseDialog(context),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    selectedRange == "Wk"
                        ? "This Week"
                        : selectedRange == "Mn"
                            ? "This Month"
                            : "This Year",
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
              ToggleButton(
                label: "Wk",
                selected: selectedRange == "Wk",
                onTap: () => setState(() => selectedRange = "Wk"),
              ),
              const SizedBox(width: 8),
              ToggleButton(
                label: "Mn",
                selected: selectedRange == "Mn",
                onTap: () => setState(() => selectedRange = "Mn"),
              ),
              const SizedBox(width: 8),
              ToggleButton(
                label: "Yr",
                selected: selectedRange == "Yr",
                onTap: () => setState(() => selectedRange = "Yr"),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        if (selectedRange == "Wk")
          Container(
            height: 250,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 7,
                barGroups: _createWeeklyBarGroups(todayIndex, currentDayValue),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      getTitlesWidget: (value, meta) {
                        const days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
                        return Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            days[value.toInt()],
                            style: TextStyle(
                              color: value.toInt() == todayIndex
                                  ? Colors.blue
                                  : Colors.blueGrey,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                borderData: FlBorderData(show: false),
                gridData: FlGridData(show: false),
              ),
            ),
          ),
      ],
    );
  }

  void _showAddExpenseDialog(BuildContext context) {
    _expenseAmountController.clear();
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Expense'),
          content: TextField(
            controller: _expenseAmountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Amount to add',
              hintText: 'Enter amount',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final amount = double.tryParse(_expenseAmountController.text) ?? 0;
                if (amount > 0) {
                  setState(() {
                    totalExpenses += amount;
                  });
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Apply'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildAddCardButton(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 200,
      child: Card(
        color: Colors.grey[300],
        margin: const EdgeInsets.all(10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(12.0),
          onTap: () => _showAddCardDialog(context),
          child: const Center(
            child: Icon(Icons.add, size: 40, color: Colors.grey),
          ),
        ),
      ),
    );
  }

  void _showAddCardDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Card'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _cardNumberController,
                  decoration: const InputDecoration(
                    labelText: 'Card Number',
                    hintText: '1234 5678 9012 3456',
                  ),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: _cvvController,
                  decoration: const InputDecoration(
                    labelText: 'CVV',
                    hintText: '123',
                  ),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: _expiryController,
                  decoration: const InputDecoration(
                    labelText: 'Expiry Date',
                    hintText: 'MM/YY',
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _selectedBank,
                  items: ['AlRajhi', 'Alinma', 'BSF', 'AlAhli Bank']
                      .map((bank) => DropdownMenuItem(
                            value: bank,
                            child: Text(bank),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedBank = value!;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Bank',
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                _addNewCard();
                Navigator.of(context).pop();
              },
              child: const Text('Add Card'),
            ),
          ],
        );
      },
    );
  }

  void _addNewCard() {
    final newCard = {
      'color': _getBankColor(_selectedBank),
      'amount': _cardNumberController.text.length > 4
          ? _cardNumberController.text.substring(_cardNumberController.text.length - 4)
          : _cardNumberController.text,
      'subtitle': _selectedBank,
      'icon': Icons.account_balance_wallet,
    };

    setState(() {
      cards.add(newCard);
      _cardNumberController.clear();
      _cvvController.clear();
      _expiryController.clear();
    });
  }

  Color _getBankColor(String bank) {
    switch (bank) {
      case 'AlRajhi':
        return Colors.blue;
      case 'Alinma':
        return Colors.brown;
      case 'BSF':
        return Colors.blue.shade900;
      case 'AlAhli Bank':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  List<BarChartGroupData> _createWeeklyBarGroups(int todayIndex, double currentDayValue) {
    return List.generate(7, (index) {
      final bool isToday = index == todayIndex;
      final bool isPast = index < todayIndex;

      Color fillColor;
      BorderSide? border;

      if (isToday) {
        fillColor = Colors.blue;
      } else if (isPast) {
        fillColor = Colors.blueGrey;
      } else {
        fillColor = Colors.white;
        border = const BorderSide(color: Colors.blue, width: 0.2);
      }

      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: isPast 
                ? (index + 3).toDouble() // Random value for past days
                : currentDayValue, // Same value as current day for future days
            color: fillColor,
            width: 45,
            borderSide: border,
            borderRadius: BorderRadius.circular(5),
          ),
        ],
      );
    });
  }
}

class ToggleButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const ToggleButton({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 30,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? Colors.blue : Colors.transparent,
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}