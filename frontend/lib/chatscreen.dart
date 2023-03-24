import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.title});
  final String title;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/background.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            height: screenSize.height,
            width: screenSize.width,
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: new InputDecoration(
                    hintText: "username",
                    hintStyle: TextStyle(color: Colors.grey),
                    enabledBorder: const OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.white, width: 1.0),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.white, width: 1.0),
                    ),
                  ),
                  controller: usernameController,
                ),
                SizedBox(
                  height: 16,
                ),
                TextField(
                  style: TextStyle(color: Colors.white),
                  minLines: 10,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: new InputDecoration(
                    hintText: "message",
                    hintStyle: TextStyle(color: Colors.grey),
                    enabledBorder: const OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.white, width: 1.0),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.white, width: 1.0),
                    ),
                  ),
                  controller: messageController,
                ),
                SizedBox(
                  height: 16,
                ),
                Spacer(),
                TextButton(
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all<Size>(
                        Size(screenSize.width * 0.9, 50.0)),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.lightGreenAccent.withOpacity(0.4)),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  onPressed: () {
                    print("ghere");
                    _sendMessage(
                        usernameController.text, messageController.text);
                  },
                  child: Text(
                    'Send',
                    style: TextStyle(fontSize: 18),
                  ),
                )
              ],
            ),
          )),
    );
  }
}

_sendMessage(String username, String message) async {
  print(username + " " + message);
  if (username.isNotEmpty && message.isNotEmpty) {
    return http.post(
      Uri.parse('https://starthack2023-do2kz2npza-uc.a.run.app/messages/'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
          <String, String>{'message': message, "username": username}),
    );
  }
}
