import 'package:auto_expense_tracker/models/financial_data.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class HomeScreen extends StatefulWidget {
  final FinancialData financialData;

  const HomeScreen({super.key, required this.financialData});
  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  // List of card data (color, amount, subtitle)
  final List<Map<String, dynamic>> cards = [
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 70),
        SizedBox(
          height: 180, // Fixed height for the cards container
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: cards.length,
            itemBuilder: (context, index) {
              return SizedBox( // Use SizedBox for fixed dimensions
                width: 150, // Fixed width
                height: 180, // Fixed height
                child: Container(
                  margin: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: cards[index]['color'],
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
        Row(
          children: [
            const SizedBox(width: 10),
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Spending Breakdown",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "+\$3,470",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
        const SizedBox(height: 20),
        // Bar Chart
        Container(
          height: 300,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: 20,
              barGroups: _createBarGroups(),
              titlesData: FlTitlesData(
                show: true,
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      switch (value.toInt()) {
                        case 0:
                          return Text('Jan');
                        case 1:
                          return Text('Feb');
                        case 2:
                          return Text('Mar');
                        case 3:
                          return Text('Apr');
                        case 4:
                          return Text('May');
                        default:
                          return Text('');
                      }
                    },
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      return Text(value.toInt().toString());
                    },
                  ),
                ),
              ),
              borderData: FlBorderData(show: false),
              gridData: FlGridData(show: false),
            ),
          ),
        ),
      ],
    );
  }

  List<BarChartGroupData> _createBarGroups() {
    return [
      BarChartGroupData(
        x: 0,
        barRods: [
          BarChartRodData(
            toY: 8,
            color: Colors.blue,
            width: 20,
          ),
        ],
      ),
      BarChartGroupData(
        x: 1,
        barRods: [
          BarChartRodData(
            toY: 12,
            color: Colors.green,
            width: 20,
          ),
        ],
      ),
      BarChartGroupData(
        x: 2,
        barRods: [
          BarChartRodData(
            toY: 16,
            color: Colors.orange,
            width: 20,
          ),
        ],
      ),
      BarChartGroupData(
        x: 3,
        barRods: [
          BarChartRodData(
            toY: 10,
            color: Colors.red,
            width: 20,
          ),
        ],
      ),
      BarChartGroupData(
        x: 4,
        barRods: [
          BarChartRodData(
            toY: 14,
            color: Colors.purple,
            width: 20,
          ),
        ],
      ),
    ];
  }
}