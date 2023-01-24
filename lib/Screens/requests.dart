import 'package:flutter/material.dart';
import 'package:workers_inn/Screens/worker_request_listview.dart';
import 'package:workers_inn/variables.dart';

class RequestsPage extends StatefulWidget {
  const RequestsPage({super.key});

  @override
  State<RequestsPage> createState() => _RequestsPageState();
}

class _RequestsPageState extends State<RequestsPage> {
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
          title: const Text('Worker Requests'),
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
        body: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: 8,
          itemBuilder: (context, index) {
            return const WorkerRequestList();
          },
        ),
      ),
    );
  }
}
