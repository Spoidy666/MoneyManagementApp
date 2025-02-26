import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:moneyapp/db/category_db.dart';

class ExpensePieChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Map<String, double>>(
      valueListenable: expenseDataNotifier,
      builder: (context, expenseData, child) {
        return expenseData.isEmpty
            ? Center(
                child: Text('Click on "+" to add a new entry '),
              )
            : PieChart(
                duration: Duration(milliseconds: 800),
                curve: Curves.easeInOut,
                PieChartData(
                  centerSpaceRadius: 80,
                  sectionsSpace: 3,
                  sections: expenseData.entries.map((entry) {
                    return PieChartSectionData(
                      color: Colors
                          .primaries[
                              expenseData.keys.toList().indexOf(entry.key) %
                                  Colors.accents.length]
                          .shade500,
                      value: entry.value, // Now it works with double values
                      title: '${entry.key}\n₹${(entry.value).round()}',
                      titleStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                      radius: 30,
                      titlePositionPercentageOffset: 1.9,
                    );
                  }).toList(),
                ),
              );
      },
    );
  }
}
