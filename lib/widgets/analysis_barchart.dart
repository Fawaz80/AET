import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class AnalysisBarchart extends StatelessWidget {
  const AnalysisBarchart({super.key});

  // Helper method to validate and convert values
  double _validateValue(double value) {
    return value.isFinite ? value : 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: 20, // Fixed maximum Y value
          minY: 0, // Explicitly set minimum Y
          barGroups: _createBarGroups(),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  // Safe value conversion
                  final intValue = value.isFinite ? value.toInt() : 0;
                  switch (intValue) {
                    case 0: return const Text('Jan');
                    case 1: return const Text('Feb');
                    case 2: return const Text('Mar');
                    case 3: return const Text('Apr');
                    case 4: return const Text('May');
                    default: return const Text('');
                  }
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  // Safe value conversion
                  return Text(value.isFinite ? value.toInt().toString() : '0');
                },
                reservedSize: 40,
              ),
            ),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(show: false),
          gridData: FlGridData(show: false),
        ),
      ),
    );
  }

  List<BarChartGroupData> _createBarGroups() {
    return [
      BarChartGroupData(
        x: 0,
        barRods: [
          BarChartRodData(
            toY: _validateValue(8),
            color: Colors.blue,
            width: 20,
          ),
        ],
      ),
      BarChartGroupData(
        x: 1,
        barRods: [
          BarChartRodData(
            toY: _validateValue(12),
            color: Colors.green,
            width: 20,
          ),
        ],
      ),
      BarChartGroupData(
        x: 2,
        barRods: [
          BarChartRodData(
            toY: _validateValue(16),
            color: Colors.orange,
            width: 20,
          ),
        ],
      ),
      BarChartGroupData(
        x: 3,
        barRods: [
          BarChartRodData(
            toY: _validateValue(10),
            color: Colors.red,
            width: 20,
          ),
        ],
      ),
      BarChartGroupData(
        x: 4,
        barRods: [
          BarChartRodData(
            toY: _validateValue(14),
            color: Colors.purple,
            width: 20,
          ),
        ],
      ),
    ];
  }
}