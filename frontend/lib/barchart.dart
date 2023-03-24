import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class _BarChart extends StatelessWidget {
  final Map<int, int> volumes;

  const _BarChart(this.volumes);

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        borderData: FlBorderData(show: false),
        barGroups: barGroups(volumes),
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

  List<BarChartGroupData> barGroups(volumes) {
    var rng = Random();
    List<BarChartGroupData> data = [];
    for (int i = 0; i < 105; i++) {
      data.add(BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
            toY: volumes[i],
            gradient: _barsGradient,
          )
        ],
      ));
    }
    return data;
  }
}

class BarChartSample3 extends StatefulWidget {
  final Map<int, int> volumes;
  const BarChartSample3({super.key, required this.volumes});

  @override
  State<StatefulWidget> createState() => BarChartSample3State();
}

class BarChartSample3State extends State<BarChartSample3> {
  @override
  Widget build(BuildContext context) {
    return _BarChart(widget.volumes);
  }
}
