import 'package:flutter/material.dart';
import 'package:workers_inn/variables.dart';

class RequestsPage extends StatefulWidget {
  const RequestsPage({super.key});

  @override
  State<RequestsPage> createState() => _RequestsPageState();
}

class _RequestsPageState extends State<RequestsPage> {
  @override
  Widget build(BuildContext context) {
    //default backpress manipulation
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
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

                                  Navigator.pop(context);
                                },
                                child: const Text("ok")),
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("cancel")),
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
        body: Stack(
          children: const [
            CircularProgressIndicator(
              value: 0.8,
              strokeWidth: 7,
            ),
          ],
        ),
      ),
    );
  }
}
