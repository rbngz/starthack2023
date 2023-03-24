import 'dart:convert';
import 'dart:html';
import 'dart:math';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
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
    double width = screenSize.width * 0.32;
    double height = screenSize.height * 0.5;
    List<Tweet> tweets = [];

    final channel = WebSocketChannel.connect(
      Uri.parse('wss://starthack2023-do2kz2npza-uc.a.run.app/ws'),
    );
    channel.sink.add('Hello!');

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
                                    if (!snapshot.data.isEmpty) {
                                      tweets.add(Tweet(
                                        json.decode(snapshot.data)["message"]
                                            ["message"],
                                        json.decode(snapshot.data)["message"]
                                            ["username"],
                                        json.decode(snapshot.data)["message"]
                                            ["sentiment"],
                                        json.decode(
                                                snapshot.data)["aggregation"]
                                            ["volume"],
                                      ));
                                    }
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
  final String username;
  final String message;
  final double sentiment;
  final int volume;
  Tweet(this.message, this.username, this.sentiment, this.volume);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      height: 65,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: (() {
          if (sentiment > 0.3)
            return Colors.lightGreenAccent;
          else if (sentiment < -0.3)
            return Colors.redAccent;
          else
            return Colors.white;
        }())),
      ),
      child: Row(children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(
                width: 1, color: const Color.fromARGB(255, 226, 255, 254)),
            shape: BoxShape.circle,
            boxShadow: const [
              BoxShadow(
                color: Color(0xFFE43D7A),
                spreadRadius: 0,
                blurRadius: 4,
              ),
              BoxShadow(
                color: Color.fromARGB(255, 250, 132, 175),
                spreadRadius: 0,
                blurRadius: 1,
              ),
            ],
          ),
          child: CachedNetworkImage(
            imageUrl: _getImageUrl(volume),
            imageBuilder: (context, imageProvider) => Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover),
                )),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Flexible(
          child: RichText(
            text: TextSpan(
              style: TextStyle(color: Colors.white),
              children: <TextSpan>[
                TextSpan(
                    text: username + "\n",
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(
                  text: message,
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

int count = -1;
List<String> imageUrls = [
  "https://images.pexels.com/photos/4927361/pexels-photo-4927361.jpeg?auto=compress&cs=tinysrgb&w=600",
  "https://images.pexels.com/photos/2811087/pexels-photo-2811087.jpeg?auto=compress&cs=tinysrgb&w=600",
  "https://images.pexels.com/photos/5119214/pexels-photo-5119214.jpeg?auto=compress&cs=tinysrgb&w=600",
  "https://media.licdn.com/dms/image/C4D03AQGvURHp-VeoAw/profile-displayphoto-shrink_800_800/0/1564073491192?e=1684972800&v=beta&t=gerqPdc6ZBASfDlmMCI3t3LOZ68y_yr9IAgJxfaY0qA",
  "https://media.licdn.com/dms/image/C4D03AQFElK4qsTbhEQ/profile-displayphoto-shrink_800_800/0/1583432409121?e=1684972800&v=beta&t=nEnukHUW4we2ofFwb2f0T-zeh2U1E13K0jRJy8GNUBE",
  "https://media.licdn.com/dms/image/C5603AQGr13YeUgRfNA/profile-displayphoto-shrink_800_800/0/1554922016883?e=1684972800&v=beta&t=-s8dzmU5qNi_T2tOTk6p4fDUqX6-ymnoL0Eq3o2K-XY",
  "https://media.licdn.com/dms/image/C5603AQFQxIXwt_f3qg/profile-displayphoto-shrink_800_800/0/1583590633826?e=1684972800&v=beta&t=6XuaA_aY2vChrD3MfmTlNDRoZR990Z_vRVOdLJBEHEk",
  "https://media.licdn.com/dms/image/C4E03AQFdsVuiDJfUeA/profile-displayphoto-shrink_800_800/0/1652522935311?e=1684972800&v=beta&t=t0YvaFR2mxAg9UovfsqdfWZJLidhw3eqDdcFfAPBezE",
  "https://media.licdn.com/dms/image/D4E03AQG4fCPfF5xiCg/profile-displayphoto-shrink_800_800/0/1674569579560?e=1684972800&v=beta&t=IiQ60oqJPupCLDarrWPU9wEnNgND8oruglPrHVoMJ5o",
  "https://www.unisg.ch/fileadmin/_processed_/5/f/csm_berufung-simon-mayer-2000x1125w_2000_hash_7F9110CB9E416A4389FC71E5DABB926AB55546B5_2000w_e6bbf694e6.jpg",
];

_getImageUrl(volume) {
  count = (count + 1) % imageUrls.length;
  return imageUrls[volume % imageUrls.length];
}
