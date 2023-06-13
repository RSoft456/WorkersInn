import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workers_inn/variables.dart';
import 'package:workers_inn/workerModule/AppProvider.dart';

import 'NegitiationScreenWorker.dart';

class WorkerRequestList extends StatefulWidget {
  const WorkerRequestList({super.key, required this.data, required this.docId});
  final Map<String, dynamic> data;
  final String docId;
  @override
  State<WorkerRequestList> createState() => _WorkerRequestListState();
}

class _WorkerRequestListState extends State<WorkerRequestList> {
  var ClientReqData;
  String name = "";
  int time = 10;
  Timer? timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    log("${widget.data}");
    loadData();
    startTimer(context);
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Card(
      color: const Color.fromARGB(255, 255, 255, 255),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.009),
            child: Row(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.08,
                  width: MediaQuery.of(context).size.height * 0.08,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.orange, width: 4),
                    borderRadius: BorderRadius.circular(50),
                    image: const DecorationImage(
                      image: AssetImage("assets/profile.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(
                  width: screenSize.width * 0.65,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: screenSize.width * 0.05,
                          left: screenSize.width * 0.05,
                          right: screenSize.width * 0.1),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: const TextStyle(fontSize: 22),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Text(
                              "Rating: 4.5",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Text(
                              "4km",
                              style: TextStyle(fontSize: 16),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration:
                          BoxDecoration(shape: BoxShape.circle, color: orange),
                      child: Text(
                        time.toString(),
                        style: TextStyle(color: white),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            width: screenSize.width * 0.87,
            child: Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: screenSize.width * 0.34,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: screenSize.width * 0.001,
                      bottom: screenSize.width * 0.001,
                      right: screenSize.width * 0.001),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange),
                    onPressed: () async {
                      timer?.cancel();
                      // showDialog(
                      //     context: context,
                      //     barrierDismissible: false,
                      //     builder: (context) {
                      //       return const Center(
                      //         child: CircularProgressIndicator(),
                      //       );
                      //     });
                      FirebaseFirestore.instance
                          .collection("orders")
                          .doc(widget.docId)
                          .get()
                          .then((value) {
                        var data = value.data()!;
                        List<dynamic> ids = data["ListOfWorkerId"] ?? [];
                        ids.add(FirebaseAuth.instance.currentUser?.uid);
                        FirebaseFirestore.instance
                            .collection("orders")
                            .doc(widget.docId)
                            .update({
                          "ListOfWorkerId": ids,
                        });
                        FirebaseFirestore.instance
                            .collection("orders")
                            .doc(widget.docId)
                            .snapshots()
                            .listen((event) {
                          var data = event.data()!;

                          if (data["status"] == "negotiating") {
                            context.read<AppProvider>().documents.clear();
                            // Navigator.of(context).pop();
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    NegotiationWorker(orderId: widget.docId)));
                          }
                        });
                      });
                    },
                    child: const Text(
                      "Accept",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void loadData() {
    FirebaseFirestore.instance
        .collection("Customers")
        .where("uid", isEqualTo: widget.data["ClientId"])
        .get()
        .then((value) {
      name = value.docs[0].data()["displayName"];
      setState(() {});
    });
  }

  void startTimer(BuildContext context) {
    timer ??= Timer.periodic(const Duration(seconds: 1), (timer) {
      if (time == 0) {
        timer.cancel();
        log("removing + ${widget.docId}");
        if (!mounted) {
          log("not mounted: ${widget.docId}");
          return;
        }
        context.read<AppProvider>().removeDocument(widget.docId);
        return;
      }
      time--;
      setState(() {});
    });
  }
}
