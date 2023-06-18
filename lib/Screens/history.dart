import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:workers_inn/Screens/HistoryItems.dart';
import 'package:workers_inn/variables.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<QueryDocumentSnapshot<Map<String, dynamic>>> historyData = [];

  @override
  void initState() {
    // TODO: implement initState
    FirebaseFirestore.instance
        .collection("orders")
        .where("ClientId", isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .where("status", isEqualTo: "complete")
        .get()
        .then((value) {
      historyData = value.docs;
      setState(() {});
    });
    super.initState();
  }

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
              child: historyData.isEmpty
                  ? Center(
                      child: CircularProgressIndicator(
                      color: orange,
                    ))
                  : ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: historyData.length,
                      itemBuilder: (context, index) {
                        String mservice = "";

                        mservice = historyData[index]["service"];

                        return HistoryList(
                            service: mservice,
                            id: historyData[index]["worker"]);
                      },
                    ),
            ),
          ],
        ));
  }
}
