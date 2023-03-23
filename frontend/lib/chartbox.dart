import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:frontend/barchart.dart';

import 'linechart.dart';

class ChartBox extends StatefulWidget {
  const ChartBox({super.key});

  @override
  State<StatefulWidget> createState() {
    return ChartBoxState();
  }
}

class ChartBoxState extends State<ChartBox> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width - 40;
    double height = screenSize.height * 0.3;
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: -1,
              blurRadius: 16,
              offset: const Offset(0, 4), // changes position of shadow
            ),
          ],
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  width: width,
                  height: height,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(color: Colors.white54),
                    gradient: LinearGradient(
                      begin: const Alignment(-0.05, -1),
                      end: const Alignment(0.05, 1),
                      colors: <Color>[
                        const Color.fromARGB(255, 23, 67, 143).withOpacity(0.1),
                        const Color.fromARGB(255, 176, 205, 255)
                            .withOpacity(0.1),
                      ],
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 28.0),
                        child: SizedBox(
                          height: height / 3,
                          child: LineChartSample2(),
                        ),
                      ),
                      SizedBox(height: height / 3, child: BarChartSample3()),
                      SizedBox(
                        height: 2,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: width / 5,
                          ),
                          Image(
                            image: AssetImage('assets/red-yellow-cards.png'),
                            width: 18,
                            height: 18,
                          ),
                          SizedBox(
                            width: width / 12,
                          ),
                          Image(
                            image: AssetImage('assets/football.png'),
                            width: 18,
                            height: 18,
                          ),
                          SizedBox(
                            width: width / 2,
                          ),
                          Image(
                            image: AssetImage('assets/red-yellow-cards.png'),
                            width: 18,
                            height: 18,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 3,
                            width: (width - 24) / 7 * 3 - 1,
                            color: Colors.white,
                          ),
                          Container(
                            height: 3,
                            width: (width - 24) / 7,
                            color: Colors.orangeAccent,
                          ),
                          Container(
                            height: 3,
                            width: (width - 24) / 7 * 3 - 1,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "0'",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            "15'",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            "30'",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            "45'",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            "45'",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            "60'",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            "75'",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            "90'",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      )
                    ],
                  ),
                ))));
  }
}
