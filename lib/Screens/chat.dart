import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Expanded(
      child: Container(
        color: const Color.fromARGB(66, 189, 143, 143),
        height: screenSize.height * 0.85,
        child: const Align(
            alignment: Alignment.bottomCenter,
            child: TextField(
              decoration: InputDecoration(
                  suffixIcon: Icon(Icons.send),
                  label: Text("Type message"),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)))),
            )),
      ),
    );
  }
}
