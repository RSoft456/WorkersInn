import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workers_inn/workerModule/NegitiationScreenWorker.dart';

import '../variables.dart';
import '../workerModule/AppProvider.dart';

class WorkerRequestList extends StatefulWidget {
  const WorkerRequestList({super.key, required this.id, required this.orderId});
  final String id;
  final String orderId;

  @override
  State<WorkerRequestList> createState() => _WorkerRequestListState();
}

class _WorkerRequestListState extends State<WorkerRequestList> {
  int totalOrders = 0;
  Map<String, dynamic>? data;
  int time = 10;
  Timer? timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData() {
    log("in loaddata ${widget.id}");
    FirebaseFirestore.instance
        .collection("Customers")
        .where("uid", isEqualTo: widget.id)
        .get()
        .then((value) {
      //value.docs[0].data;
      log("data ${value.docs[0].data}");
      data = value.docs[0].data();
      log("$data");
      setState(() {});
      startTimer(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size Screensize = MediaQuery.of(context).size;
    return data == null
        ? Container()
        : Card(
            color: const Color.fromARGB(255, 255, 255, 255),
            elevation: 3,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(
                      MediaQuery.of(context).size.height * 0.009),
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
                            )),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: Screensize.width * 0.03,
                                right: Screensize.width * 0.03,
                                left: Screensize.width * 0.03),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data!['displayName'] ?? "John Doe",
                                  style: const TextStyle(fontSize: 22),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    "Rating: 4.5",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    "Orders: $totalOrders",
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          InkWell(
                            onTap: () => dialog(),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              child: SizedBox(
                                width: Screensize.width * 0.09,
                                height: Screensize.width * 0.09,
                                child: const Icon(
                                  Icons.info_outline,
                                  color: Colors.orange,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: orange),
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
                    width: Screensize.width * 0.87,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        width: Screensize.width * 0.34,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: Screensize.width * 0.001,
                              bottom: Screensize.width * 0.001,
                              right: Screensize.width * 0.001),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange),
                              onPressed: () {
                                FirebaseFirestore.instance
                                    .collection("orders")
                                    .doc(widget.orderId)
                                    .update({
                                  "status": "negotiating",
                                  "ListOfWorkerId": [],
                                  "worker": widget.id,
                                });
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => NegotiationWorker(
                                          orderId: widget.orderId,
                                          mContext: context,
                                        )));
                              },
                              child: const Text(
                                "Accept",
                                style: TextStyle(fontSize: 18),
                              )),
                        ),
                      ),
                    )),
              ],
            ),
          );
  }

  dialog() {
    Size screen = MediaQuery.of(context).size;
    showDialog(
        barrierColor: const Color.fromARGB(174, 0, 0, 0),
        barrierDismissible: false,
        context: (context),
        builder: (context) {
          return AlertDialog(
              insetPadding: EdgeInsets.symmetric(
                  vertical: screen.height * 0.2,
                  horizontal: screen.width * 0.09),
              clipBehavior: Clip.hardEdge,
              content: Column(
                children: [
                  Container(
                    height: screen.height * 0.15,
                    width: screen.height * 0.15,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      border: Border.all(color: Colors.orange, width: 4),
                      borderRadius: BorderRadius.circular(100),
                      image: const DecorationImage(
                        image: AssetImage("assets/profile.png"),
                        //fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(data!['displayName'] ?? "John Doe"),
                  ),
                  const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.all(4),
                        child: Text("Age: 34"),
                      )),
                  Wrap(
                    children: List.castFrom(data!['services'])
                        .map((e) => Chip(label: Text("$e")))
                        .toList(),
                  ),
                  const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.all(4),
                        child: Text(
                          "Description: ",
                        ),
                      )),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 5, top: 5, bottom: 5),
                        child: Card(
                          // color: const Color.fromARGB(255, 228, 216, 177),
                          child: SingleChildScrollView(
                            child: SizedBox(
                              height: screen.height * 0.04,
                              child: const Text(
                                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("OK"),
                    ),
                  ),
                ],
              ));
        });
  }

  void startTimer(BuildContext context) {
    timer ??= Timer.periodic(const Duration(seconds: 1), (timer) {
      if (time == 0) {
        timer.cancel();
        log("removing + ${widget.id}");
        if (!mounted) {
          log("not mounted: ${widget.id}");
          return;
        }
        context.read<AppProvider>().removeWorker(widget.id);
        return;
      }
      time--;
      setState(() {});
    });
  }
}
