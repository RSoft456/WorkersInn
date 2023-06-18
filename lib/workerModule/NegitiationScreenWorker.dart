import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:workers_inn/Screens/RequestInProcess.dart';
import 'package:workers_inn/Screens/chat.dart';
import 'package:workers_inn/Screens/map_provider.dart';
import 'package:workers_inn/workerModule/AppProvider.dart';

import '../Screens/home.dart';
import '../variables.dart';

class NegotiationWorker extends StatefulWidget {
  const NegotiationWorker(
      {super.key, required this.orderId, required this.mContext});
  final String orderId;
  final BuildContext mContext;
  @override
  State<NegotiationWorker> createState() => _NegotiationWorkerState();
}

class _NegotiationWorkerState extends State<NegotiationWorker> {
  TextEditingController price = TextEditingController();
  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? listner;
  int finalPrice = 00;
  Map<String, dynamic> data = {};
  String number = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadData();
    loadListener();
  }

  loadListener() {
    listner = FirebaseFirestore.instance
        .collection("orders")
        .doc(widget.orderId)
        .snapshots()
        .listen((event) {
      var data = event.data()!;
      if (data["status"] == "cancelled") {
        showCancelledPopUp();
      }
      if (data["price"] != "00" && !context.read<AppMap>().isWorker) {
        finalPrice = int.parse(data["price"]);
        setState(() {});
        pricePopUp();
      }
      if (data["status"] == "processing" && context.read<AppMap>().isWorker) {
        Navigator.of(context).pop();
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const RequestInProgress(),
          ),
        );
      }
    });
  }

  pricePopUp() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              title: const Text("Price"),
              content: Text(
                  "Price by worker Rs: $finalPrice \n Press yes if you agree!!"),
              actions: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: orange,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("ok"))
              ],
            ),
          );
        });
  }

  showCancelledPopUp() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              title: const Text("Request cancelled"),
              actions: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: orange,
                    ),
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => const Home()),
                          (route) => false);
                    },
                    child: const Text("ok"))
              ],
            ),
          );
        });
  }

  //save resources
  @override
  dispose() {
    listner?.cancel();
    super.dispose();
  }

  loadData() {
    context.read<AppProvider>().assignOrderId(widget.orderId);
    //context.read<AppMap>().isWorker
    FirebaseFirestore.instance
        .collection("orders")
        .doc(widget.orderId)
        .get()
        .then((value) {
      data = value.data()!;
      setState(() {});
      if (context.read<AppMap>().isWorker) {
        FirebaseFirestore.instance
            .collection("Customers")
            .where("uid", isEqualTo: data['ClientId'])
            .get()
            .then((value) {
          var d = value.docs[0].data();
          number = d['number'].toString();
        });
      } else {
        FirebaseFirestore.instance
            .collection("Customers")
            .where("uid", isEqualTo: data['worker'])
            .get()
            .then((value) {
          var d = value.docs[0].data();
          number = d['number'].toString();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isWorker = context.read<AppMap>().isWorker;

    Size screenSize = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.orange,
            actions: [
              IconButton(
                  onPressed: () {
                    openDialPad(number);
                  },
                  icon: const Icon(Icons.call))
            ],
            title: const Text("Negotiate"),
            //leading: BackButton(onPressed: () => Navigator.of(context).pop()),
          ),
          body: Column(
            children: [
              ChatScreen(docId: widget.orderId),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: screenSize.width * 0.02,
                        right: screenSize.width * 0.02),
                    child: SizedBox(
                      width: screenSize.width * 0.5,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange),
                        onPressed: () {
                          isWorker
                              ? showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (ctx) {
                                    return WillPopScope(
                                      onWillPop: () async => false,
                                      child: AlertDialog(
                                        content: TextField(
                                          controller: price,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                              focusColor: orange,
                                              focusedBorder: OutlineInputBorder(
                                                borderSide:
                                                    BorderSide(color: orange),
                                              ),
                                              hintText: "Enter Price",
                                              label: const Text("Enter Price"),
                                              border: const OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              20)))),
                                        ),
                                        actions: [
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: orange,
                                              ),
                                              onPressed: () {
                                                Navigator.pop(ctx);
                                              },
                                              child: const Text("cancel")),
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: orange,
                                              ),
                                              onPressed: () {
                                                finalPrice =
                                                    int.parse(price.text);
                                                FirebaseFirestore.instance
                                                    .collection("orders")
                                                    .doc(widget.orderId)
                                                    .update({
                                                  "price": finalPrice.toString()
                                                }).then((value) {
                                                  setState(() {});
                                                  Navigator.pop(ctx);
                                                });
                                              },
                                              child: const Text(
                                                "ok",
                                              )),
                                        ],
                                      ),
                                    );
                                  })
                              : null;
                        },
                        child: isWorker
                            ? Text(finalPrice == 0
                                ? "Enter Price"
                                : "Rs.$finalPrice")
                            : Text("Rs.$finalPrice"),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: screenSize.width * 0.09,
                        right: screenSize.width * 0.01),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange),
                        onPressed: () {
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (ctx) {
                                return WillPopScope(
                                  onWillPop: () async => false,
                                  child: AlertDialog(
                                    content: const Text("Cancel Request ?"),
                                    actions: [
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: orange,
                                          ),
                                          onPressed: () {
                                            Navigator.pop(ctx);
                                          },
                                          child: const Text("no")),
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: orange,
                                          ),
                                          onPressed: () {
                                            Navigator.pop(ctx);
                                            FirebaseFirestore.instance
                                                .collection("orders")
                                                .doc(widget.orderId)
                                                .update(
                                                    {"status": "cancelled"});
                                          },
                                          child: const Text(
                                            "yes",
                                          )),
                                    ],
                                  ),
                                );
                              });
                        },
                        child: const Icon(Icons.cancel_outlined)),
                  ),
                  if (!isWorker)
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: orange,
                            disabledBackgroundColor: orange),
                        onPressed: finalPrice == 0
                            ? null
                            : () {
                                FirebaseFirestore.instance
                                    .collection("orders")
                                    .doc(widget.orderId)
                                    .update({
                                  "status": "processing",
                                }).then((value) {
                                  Navigator.of(context).pop();
                                  listner?.cancel();
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const RequestInProgress(),
                                    ),
                                  );
                                });
                              },
                        child: const Icon(Icons.check_box))
                ],
              )
            ],
          )),
    );
  }
}

openDialPad(String phoneNumber) async {
  log(phoneNumber);
  Uri url = Uri.parse("tel:$phoneNumber");
  try {
    await launchUrl(url);
  } catch (e) {
    log("$e");
  }
}
