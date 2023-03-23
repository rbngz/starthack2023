import 'dart:html';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatBox extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new ChatBoxState();
  }
}

class ChatBoxState extends State<ChatBox> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width * 0.22;
    double height = screenSize.height * 0.5;
    List<Tweet> tweets = [Tweet()];

    final channel = WebSocketChannel.connect(
      Uri.parse('wss://echo.websocket.events'),
    );
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
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                    width: width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(color: Colors.white54),
                      gradient: LinearGradient(
                        begin: const Alignment(-0.05, -1),
                        end: const Alignment(0.05, 1),
                        colors: <Color>[
                          const Color.fromARGB(255, 23, 67, 143)
                              .withOpacity(0.1),
                          const Color.fromARGB(255, 176, 205, 255)
                              .withOpacity(0.1),
                        ],
                      ),
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Twitter Feed",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          Container(
                              width: width - 16,
                              height: height - 32,
                              child: StreamBuilder(
                                  stream: channel.stream,
                                  initialData: tweets,
                                  builder: (ctx, snapshot) {
                                    print(snapshot.data);
                                    tweets.add(Tweet());
                                    print(tweets.length);
                                    return ListView.separated(
                                        separatorBuilder: (context, index) =>
                                            SizedBox(
                                              height: 5,
                                            ),
                                        itemCount: tweets.length,
                                        itemBuilder:
                                            (BuildContext ctx, int index) {
                                          final element =
                                              tweets[tweets.length - 1 - index];
                                          return element;
                                        });
                                  }))
                        ])))));
  }
}

class Tweet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6),
      height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.white70)),
      child: Text(
        'Entry A',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
