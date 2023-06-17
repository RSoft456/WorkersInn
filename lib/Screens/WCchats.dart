import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workers_inn/Screens/chat.dart';
import 'package:workers_inn/variables.dart';

import '../workerModule/AppProvider.dart';

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
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            ChatScreen(docId: context.read<AppProvider>().orderId),
          ],
        ),
      ),
    );
  }
}
