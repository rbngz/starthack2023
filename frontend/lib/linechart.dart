import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartSample2 extends StatefulWidget {
  final Map<int, double> sentiments;
  const LineChartSample2({super.key, required this.sentiments});

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
          mainData(widget.sentiments),
        ),
      ],
    );
  }

  LineChartData mainData(sentiments) {
    return LineChartData(
      gridData: FlGridData(show: false),
      titlesData: FlTitlesData(show: false),
      borderData: FlBorderData(show: false),
      minY: 0,
      maxY: 1,
      lineBarsData: [
        LineChartBarData(
          spots: (() {
            List<FlSpot> data = [];
            for (int i = 0; i < 105; i++) {
              data.add(FlSpot(i.toDouble(), sentiments[i]));
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
