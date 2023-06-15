import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:workers_inn/Screens/RequestInProcess.dart';
import 'package:workers_inn/Screens/chat.dart';
import 'package:workers_inn/Screens/map_provider.dart';
import 'package:workers_inn/workerModule/RequestInProcessWorker.dart';

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
  Map<String, dynamic>? data;
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
        .collection("order")
        .doc(widget.orderId)
        .snapshots()
        .listen((event) {
      var data = event.data()!;
      if (data["status"] == "cancelled") {
        showCancelledPopUp();
      }
      if (data["price"] != "00" && !context.read<AppMap>().isWorker) {
        pricePopUp();
      }
    });
  }

  pricePopUp() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Price"),
            content: Text(
                "Price by worker Rs: $finalPrice \n Press yes if you agree!!"),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("ok"))
            ],
          );
        });
  }

  showCancelledPopUp() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Request cancelled"),
            content: Text(
                "Request cancelled by ${context.read<AppMap>().isWorker ? 'worker' : 'customer'}"),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Navigator.of(widget.mContext).pop();
                  },
                  child: const Text("ok"))
            ],
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
            .where("uid", isEqualTo: FirebaseAuth.instance.currentUser?.uid)
            .get()
            .then((value) {
          var d = value.docs[0].data();
          number = d['number'].toString();
        });
      } else {
        FirebaseFirestore.instance
            .collection("Customers")
            .doc(value['worker'])
            .get()
            .then((value) {
          var d = value.data()!;
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
                                    return AlertDialog(
                                      content: TextField(
                                        controller: price,
                                        decoration: InputDecoration(
                                            focusColor: orange,
                                            focusedBorder: OutlineInputBorder(
                                              borderSide:
                                                  BorderSide(color: orange),
                                            ),
                                            hintText: "Enter Price",
                                            label: const Text("Enter Price"),
                                            border: const OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20)))),
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
                                                  .collection("order")
                                                  .doc(widget.orderId)
                                                  .update({
                                                "price": finalPrice.toString()
                                              });
                                              setState(() {});
                                              Navigator.pop(ctx);
                                            },
                                            child: const Text(
                                              "ok",
                                            )),
                                      ],
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
                                return AlertDialog(
                                  content: const Text("Cancel Request ?"),
                                  actions: [
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(ctx);
                                        },
                                        child: const Text("no")),
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(ctx);

                                          Navigator.pop(context);
                                          FirebaseFirestore.instance
                                              .collection("orders")
                                              .doc(widget.orderId)
                                              .update({"status": "cancelled"});
                                        },
                                        child: const Text(
                                          "yes",
                                        )),
                                  ],
                                );
                              });
                        },
                        child: const Icon(Icons.cancel_outlined)),
                  ),
                  if (!isWorker)
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange),
                        onPressed: finalPrice == 0
                            ? null
                            : () {
                                // if (finalPrice != 0) {
                                //   Future.delayed(const Duration(seconds: 5), () {
                                //     showDialog(
                                //       context: context,
                                //       builder: ((context) {
                                //         return AlertDialog(
                                //           content: const Text("Request accepted !!"),
                                //           actions: [
                                //             ElevatedButton(
                                //                 style: ElevatedButton.styleFrom(
                                //                     backgroundColor: orange),
                                //                 onPressed: () {
                                //                   Navigator.of(context).pop();

                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => isWorker
                                        ? const RequestInProcessWorker()
                                        : const RequestInProgress(),
                                  ),
                                );
                                //                 },
                                //                 child: const Text("Ok")),
                                //           ],
                                //         );
                                //       }),
                                //     );
                                //   });
                                // } else {
                                //   ShowToast("Enter Price !!", context);
                                // }
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
  Uri url = Uri(scheme: "tel", path: phoneNumber);
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    print("Can't open dial pad.");
  }
}
