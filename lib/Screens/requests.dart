import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workers_inn/Screens/worker_request_listview.dart';
import 'package:workers_inn/variables.dart';
import 'package:workers_inn/workerModule/AppProvider.dart';

class RequestsPage extends StatefulWidget {
  const RequestsPage({super.key, required this.docId});
  final String docId;

  @override
  State<RequestsPage> createState() => _RequestsPageState();
}

class _RequestsPageState extends State<RequestsPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      loadSnapshot();
    });
  }

  loadSnapshot() {
    log(widget.docId);
    context.read<AppProvider>().attachClientsnapshot(FirebaseFirestore.instance
        .collection("orders")
        .doc(widget.docId)
        .snapshots());
    context.read<AppProvider>().clientSnaphot?.listen((event) {
      var data = event.data()!;
      var list = data['ListOfWorkerId'] ?? [];
      for (var element in list) {
        if (!context.read<AppProvider>().workersList.contains(element)) {
          context.read<AppProvider>().addWorkers(element);
          setState(() {});
        }
      }
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
          backgroundColor: orange,
          title: const Text('Worker Requests'),
          automaticallyImplyLeading: false,
          actions: [
            TextButton(
                onPressed: () {
                  bool popIt =
                      dialogBox(context, "Cancel Request ?", "yes", "no", true);
                  if (popIt) Navigator.pop(context);
                },
                child: Text(
                  'cancel',
                  style: TextStyle(color: white),
                )),
          ],
        ),
        body: Consumer<AppProvider>(
          builder: (context, value, child) {
            return context.read<AppProvider>().workersList.isEmpty
                ? Center(
                    child: CircularProgressIndicator(
                    color: orange,
                  ))
                : ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: context.read<AppProvider>().workersList.length,
                    itemBuilder: (context, index) {
                      return WorkerRequestList(
                          id: context.read<AppProvider>().workersList[index],
                          orderId: widget.docId);
                    },
                  );
          },
        ),
      ),
    );
  }
}
