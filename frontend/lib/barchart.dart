import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class _BarChart extends StatelessWidget {
  const _BarChart();

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        borderData: FlBorderData(show: false),
        barGroups: barGroups(),
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(show: false),
        alignment: BarChartAlignment.spaceAround,
      ),
    );
  }

  LinearGradient get _barsGradient => LinearGradient(
        colors: [
          Colors.green,
          Colors.lightGreenAccent,
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );

  List<BarChartGroupData> barGroups() {
    var rng = Random();
    List<BarChartGroupData> data = [];
    for (int i = 0; i < 100; i++) {
      data.add(BarChartGroupData(
        x: 0,
        barRods: [
          BarChartRodData(
            toY: rng.nextDouble() * 20,
            gradient: _barsGradient,
          )
        ],
      ));
    }
    return data;
  }
}

class BarChartSample3 extends StatefulWidget {
  const BarChartSample3({super.key});

  @override
  State<StatefulWidget> createState() => BarChartSample3State();
}

class BarChartSample3State extends State<BarChartSample3> {
  @override
  Widget build(BuildContext context) {
    return _BarChart();
  }
}
