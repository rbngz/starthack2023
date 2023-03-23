import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartSample2 extends StatefulWidget {
  const LineChartSample2({super.key});

  @override
  State<LineChartSample2> createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  List<Color> gradientColors = [
    Colors.blue,
    Colors.lightBlueAccent,
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        LineChart(
          mainData(),
        ),
      ],
    );
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(show: false),
      titlesData: FlTitlesData(show: false),
      borderData: FlBorderData(show: false),
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: (() {
            var rng = Random();

            List<FlSpot> data = [];
            for (int i = 0; i < 105; i++) {
              data.add(FlSpot(i.toDouble(), rng.nextDouble() * 6));
            }
            return data;
          }()),
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
