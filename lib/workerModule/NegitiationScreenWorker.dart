import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:workers_inn/Screens/chat.dart';

class NegotiationWorker extends StatefulWidget {
  const NegotiationWorker({super.key});

  @override
  State<NegotiationWorker> createState() => _NegotiationWorkerState();
}

class _NegotiationWorkerState extends State<NegotiationWorker> {
  @override
  Widget build(BuildContext context) {
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
                    openDialPad("03456478564");
                  },
                  icon: const Icon(Icons.call))
            ],
            title: const Text("Negotiate"),
            leading: BackButton(onPressed: () => Navigator.of(context).pop()),
          ),
          body: Column(
            children: [
              const ChatScreen(),
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
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (ctx) {
                                  return AlertDialog(
                                    content: const TextField(
                                      decoration: InputDecoration(
                                          hintText: "Enter Price",
                                          label: Text("Enter Price"),
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)))),
                                    ),
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
                                            Navigator.pop(context);
                                          },
                                          child: const Text(
                                            "yes",
                                          )),
                                    ],
                                  );
                                });
                          },
                          child: const Text("Enter Price")),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: screenSize.width * 0.12, right: 8),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange),
                        onPressed: () {},
                        child: const Icon(Icons.cancel_outlined)),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange),
                      onPressed: () {},
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
