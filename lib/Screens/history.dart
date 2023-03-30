import 'package:flutter/material.dart';
import 'package:workers_inn/Screens/HistoryItems.dart';
import 'package:workers_inn/variables.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        color: white,
        child: Column(
          children: [
            AppBar(
              backgroundColor: Colors.orange,
              title: const Text('History'),
            ),
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: 8,
                itemBuilder: (context, index) {
                  return const HistoryList();
                },
              ),
            ),
          ],
        ));
  }
}
