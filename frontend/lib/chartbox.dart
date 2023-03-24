import 'dart:convert';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:frontend/barchart.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'linechart.dart';

class ChartBox extends StatefulWidget {
  ChartBox({super.key});
  Map<int, int> volumes = Map();
  Map<int, double> sentiments = Map();
  final channel = WebSocketChannel.connect(
    Uri.parse('wss://starthack2023-do2kz2npza-uc.a.run.app/ws'),
  );
  bool listened = false;

  @override
  State<StatefulWidget> createState() {
    var rng = Random();
    for (int i = 0; i < 105; i++) {
      if (i < 25 && i > 18) {
        volumes[i] = rng.nextInt(50) + 50;
        sentiments[i] = -(rng.nextDouble() * 0.5) - 0.5;
      } else if (i < 78 + 15 && i > 72 + 15) {
        volumes[i] = rng.nextInt(50) + 50;
        sentiments[i] = rng.nextDouble() * 0.5 + 0.5;
      } else if (i < 37 && i > 31) {
        volumes[i] = rng.nextInt(50) + 50;
        sentiments[i] = rng.nextDouble() * 0.5 + 0.5;
      } else if (i > 80 + 15) {
        volumes[i] = 0;
        sentiments[i] = 0.0;
      } else {
        volumes[i] = rng.nextInt(50);
        sentiments[i] = rng.nextDouble() * 0.5 - 0.25;
      }
    }
    channel.sink.add('Hello!');

    return ChartBoxState();
  }
}

class ChartBoxState extends State<ChartBox> {
  @override
  Widget build(BuildContext context) {
    if (!widget.listened) {
      widget.channel.stream.listen((event) {
        setState(() {
          int minute = jsonDecode(event)["aggregation"]["min"];
          widget.sentiments[minute + 16] =
              jsonDecode(event)["aggregation"]["running_average_sentiment"];
          widget.volumes[minute + 16] =
              jsonDecode(event)["aggregation"]["volume"];
        });
      });
      widget.listened = true;
    }

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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Twitter Sentiment",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 48.0),
                        child: SizedBox(
                          height: height / 5,
                          child:
                              LineChartSample2(sentiments: widget.sentiments),
                        ),
                      ),
                      SizedBox(height: 12),
                      SizedBox(
                          height: height / 5,
                          child: BarChartSample3(
                            volumes: widget.volumes,
                          )),
                      SizedBox(
                        height: 6,
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
                        height: 6,
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
