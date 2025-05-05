import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class AnalysisBarchart extends StatelessWidget {
  const AnalysisBarchart({super.key});

  // Make this static since it's used in static-like context
  static double _validateValue(double value) {
    return value.isFinite ? value : 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        children: [
          SizedBox(
            height: 180,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 750,
                minY: 0,
                barGroups: _createBarGroups(),
                titlesData: FlTitlesData(
                  show: true,
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 28,
                      interval: 250,
                      getTitlesWidget: (value, meta) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 4.0),
                          child: Text(
                            value.toInt().toString(),
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                borderData: FlBorderData(show: false), // ✅ moved here
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 250,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: Colors.grey.withOpacity(0.2),
                      strokeWidth: 1,
                    );
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 20,
            runSpacing: 8,
            children: [
              _buildLegendItem(Colors.blue, "Food"),
              _buildLegendItem(Colors.green, "Electronics"),
              _buildLegendItem(Colors.orange, "Clothes"),
              _buildLegendItem(Colors.red, "Gas"),
              _buildLegendItem(Colors.purple, "Other"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(Color color, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  List<BarChartGroupData> _createBarGroups() {
    double barwidth = 50;
    return [
      BarChartGroupData(
        x: 0,
        barRods: [
          BarChartRodData(
            toY: _validateValue(350),
            color: Colors.blue,
            width: barwidth,
            borderRadius: BorderRadius.circular(5),
          ),
        ],
      ),
      BarChartGroupData(
        x: 1,
        barRods: [
          BarChartRodData(
            toY: _validateValue(250),
            color: Colors.green,
            width: barwidth,
            borderRadius: BorderRadius.circular(5),
          ),
        ],
      ),
      BarChartGroupData(
        x: 2,
        barRods: [
          BarChartRodData(
            toY: _validateValue(200),
            color: Colors.orange,
            width: barwidth,
            borderRadius: BorderRadius.circular(5),
          ),
        ],
      ),
      BarChartGroupData(
        x: 3,
        barRods: [
          BarChartRodData(
            toY: _validateValue(150),
            color: Colors.red,
            width: barwidth,
            borderRadius: BorderRadius.circular(5),
          ),
        ],
      ),
      BarChartGroupData(
        x: 4,
        barRods: [
          BarChartRodData(
            toY: _validateValue(50),
            color: Colors.purple,
            width: barwidth,
            borderRadius: BorderRadius.circular(5),
          ),
        ],
      ),
    ];
  }
}
