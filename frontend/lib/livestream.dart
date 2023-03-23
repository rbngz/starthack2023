import 'dart:ui';

import 'package:flutter/material.dart';

class LiveStream extends StatefulWidget {
  const LiveStream({super.key});

  @override
  State<StatefulWidget> createState() {
    return LiveStreamState();
  }
}

class LiveStreamState extends State<LiveStream> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width * 0.72;
    double height = screenSize.height * 0.5;

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
                  width: width,
                  height: height,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(color: Colors.white54),
                    gradient: LinearGradient(
                      begin: const Alignment(-0.05, -1),
                      end: const Alignment(0.05, 1),
                      colors: <Color>[
                        const Color.fromARGB(255, 23, 67, 143).withOpacity(0.3),
                        const Color.fromARGB(255, 176, 205, 255)
                            .withOpacity(0.1),
                      ],
                    ),
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Live",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )
                      ]),
                ))));
  }
}
