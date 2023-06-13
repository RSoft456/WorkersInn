import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:workers_inn/Screens/chat.dart';
import 'package:workers_inn/variables.dart';

class WCchats extends StatefulWidget {
  const WCchats({super.key});

  @override
  State<WCchats> createState() => _WCchatsState();
}

class _WCchatsState extends State<WCchats> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat"),
        backgroundColor: orange,
      ),
      body: const Column(
        children: [
          //ChatScreen(),
        ],
      ),
    );
  }
}
