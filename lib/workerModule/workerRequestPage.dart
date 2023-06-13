import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workers_inn/workerModule/AppProvider.dart';
import 'package:workers_inn/workerModule/customerRequestsList.dart';

import '../variables.dart';

class WorkRequestPage extends StatefulWidget {
  const WorkRequestPage({super.key, required this.services});
  final List<dynamic> services;
  @override
  State<WorkRequestPage> createState() => _WorkRequestPageState();
}

class _WorkRequestPageState extends State<WorkRequestPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    log("${widget.services}");
    // FirebaseFirestore.instance
    //     .collection("orders")
    //     .where("service", whereIn: widget.services)
    //     .get()
    //     .then((value) {
    //   for (var element in value.docs) {
    //     log("${element.data()}");
    //   }
    // });
    //LoadData(context);
    Future.delayed(const Duration(seconds: 1), () {
      LoadSnapShot(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size Screensize = MediaQuery.of(context).size;
    //default backpress manipulation
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: const Text('Customer Requests'),
          automaticallyImplyLeading: false,
          actions: [
            TextButton(
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
                                },
                                child: const Text(
                                  "yes",
                                )),
                          ],
                        );
                      });
                },
                child: Text(
                  'cancel',
                  style: TextStyle(color: white),
                )),
          ],
        ),
        body: Consumer<AppProvider>(
          builder: (context, value, child) {
            var list = context.read<AppProvider>().documents;
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: list.length,
              itemBuilder: (context, index) {
                int length = int.parse("${list.length}");
                // if (context
                //     .read<AppProvider>()
                //     .removeIds
                //     .contains(list[index].id)) {
                //   index++;
                // }
                // if (index >= length) {
                //   return Container();
                // }
                log("building: ${list[index].id}");
                return WorkerRequestList(
                  data: list[index].data()!,
                  docId: list[index].id,
                );
              },
            );
          },
        ),
      ),
    );
  }

  void LoadSnapShot(BuildContext context) {
    context.read<AppProvider>().attachSnapshot(FirebaseFirestore.instance
        .collection("orders")
        .where("service", whereIn: widget.services)
        .snapshots());
    context.read<AppProvider>().snapShot?.listen((event) {
      for (var element in event.docChanges) {
        if (element.type == DocumentChangeType.added) {
          context.read<AppProvider>().addDocument(element.doc);
        }
      }
    });
  }

  void LoadData(BuildContext context) {
    context.read<AppProvider>().documents.clear();
    FirebaseFirestore.instance
        .collection("orders")
        .where("service", whereIn: widget.services)
        .where("status", isEqualTo: "pending")
        .get()
        .then((value) {
      for (var element in value.docs) {
        context.read<AppProvider>().addDocument(element);
      }
      LoadSnapShot(context);
    });
  }
}

// StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
//             stream: FirebaseFirestore.instance
//                 .collection("orders")
//                 .where("service", whereIn: widget.services)
//                 .snapshots(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const CircularProgressIndicator();
//               }
//               return Consumer<AppProvider>(
//                 builder: (context, value, child) {
//                   return ListView.builder(
//                     physics: const BouncingScrollPhysics(),
//                     itemCount: snapshot.data?.docs.length,
//                     itemBuilder: (context, index) {
//                       int length = int.parse("${snapshot.data?.docs.length}");
//                       if (context
//                           .read<AppProvider>()
//                           .removeIds
//                           .contains(snapshot.data!.docs[index].id)) {
//                         index++;
//                       }
//                       if (index >= length) {
//                         return Container();
//                       }
//                       return WorkerRequestList(
//                         data: snapshot.data!.docs[index].data(),
//                         docId: snapshot.data!.docs[index].id,
//                       );
//                     },
//                   );
//                 },
//               );
//             }),
