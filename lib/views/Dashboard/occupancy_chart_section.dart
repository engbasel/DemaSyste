import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OccupancyChartSection extends StatelessWidget {
  const OccupancyChartSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFF1F5F9),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "الإحصائيات الأسبوعية",
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            SizedBox(height: 200, child: BarChart(_mainBarData())),
          ],
        ),
      ),
    );
  }

  BarChartData _mainBarData() {
    // Dummy data for the chart
    final barGroups = [
      _makeGroupData(0, 5, 12),
      _makeGroupData(1, 6.5, 12),
      _makeGroupData(2, 5, 12),
      _makeGroupData(3, 7.5, 12),
      _makeGroupData(4, 9, 12),
      _makeGroupData(5, 11.5, 12),
      _makeGroupData(6, 6.5, 12),
    ];

    return BarChartData(
      maxY: 16,
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            String weekDay = DateFormat('EEE').format(
              DateTime.now().subtract(Duration(days: 6 - group.x.toInt())),
            );
            return BarTooltipItem(
              '$weekDay\n',
              const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: (rod.toY - 1).toString(),
                  style: const TextStyle(
                    color: Colors.yellow,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            );
          },
        ),
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (double value, TitleMeta meta) {
              final text = DateFormat('E').format(
                DateTime.now().subtract(Duration(days: 6 - value.toInt())),
              );
              return SideTitleWidget(meta: meta, child: Text(text));
            },
            reservedSize: 38,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (double value, TitleMeta meta) {
              if (value % 4 == 0) return Text('${value.toInt()}');
              return const Text('');
            },
            reservedSize: 28,
          ),
        ),
      ),
      borderData: FlBorderData(show: false),
      barGroups: barGroups,
      gridData: const FlGridData(show: false),
    );
  }

  BarChartGroupData _makeGroupData(int x, double y, double width) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y + 1,
          width: width,
          color: Colors.blue,
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    );
  }
}
