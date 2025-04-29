import 'package:auto_expense_tracker/models/financial_data.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

// Placeholder Screens
class HomeScreen extends StatefulWidget {
  final FinancialData financialData;

  const HomeScreen({super.key, required this.financialData});
  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  // State variable to hold the list of card titles
  List<String> cardTitles = [
    'Card 1',
    'Card 2',
    'Card 3',
    'Card 4',
    'Card 5',
  ];

  // Function to add a new card
  void _addCard() {
    setState(() {
      cardTitles.add('Card ${cardTitles.length + 1}');
    });
  }

  // Function to remove a card
  void _removeCard(int index) {
    setState(() {
      cardTitles.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 70,
        ),
        Flexible(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: cardTitles.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onDoubleTap: () => _removeCard(index), // Remove card on tap
                child: Card(
                  margin: EdgeInsets.all(10.0),
                  child: Container(
                    color: Colors.blue,
                    width: 150.0,
                    padding: EdgeInsets.all(16.0),
                    child: Center(
                      child: Text(
                        cardTitles[index],
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Row(
          children: [
            SizedBox(
              width: 10,
            ),
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
            SizedBox(
              width: 10,
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        // Bar Chart
        Container(
          height: 300, // Set a fixed height for the chart
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: 20, // Maximum Y-axis value
              barGroups: _createBarGroups(),
              titlesData: FlTitlesData(
                show: true,
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      // Customize X-axis labels
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
                      // Customize Y-axis labels
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

  // Create bar groups (data for the chart)
  List<BarChartGroupData> _createBarGroups() {
    return [
      BarChartGroupData(
        x: 0, // X-axis position
        barRods: [
          BarChartRodData(
            toY: 8, // Y-axis value
            color: Colors.blue,
            width: 20, // Bar width
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
