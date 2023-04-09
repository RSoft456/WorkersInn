import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:workers_inn/Screens/chat.dart';
import 'package:workers_inn/workerModule/RequestInProcessWorker.dart';

import '../variables.dart';

class NegotiationWorker extends StatefulWidget {
  const NegotiationWorker({super.key});

  @override
  State<NegotiationWorker> createState() => _NegotiationWorkerState();
}

class _NegotiationWorkerState extends State<NegotiationWorker> {
  TextEditingController price = TextEditingController();
  int finalPrice = 0;
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
                                            Navigator.pop(ctx);
                                            finalPrice = int.parse(price.text);
                                            setState(() {});
                                          },
                                          child: const Text(
                                            "ok",
                                          )),
                                    ],
                                  );
                                });
                          },
                          child: finalPrice == 0
                              ? const Text("Enter Price")
                              : Text("Rs.$finalPrice")),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: screenSize.width * 0.09,
                        right: screenSize.width * 0.01),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange),
                        onPressed: () {},
                        child: const Icon(Icons.cancel_outlined)),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange),
                      onPressed: () {
                        if (finalPrice != 0) {
                          ShowToast("Request sent !!", context);
                          Future.delayed(const Duration(seconds: 5), () {
                            showDialog(
                              context: context,
                              builder: ((context) {
                                return AlertDialog(
                                  content: const Text("Request accepted !!"),
                                  actions: [
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: orange),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const RequestInProcessWorker(),
                                            ),
                                          );
                                        },
                                        child: const Text("Ok")),
                                  ],
                                );
                              }),
                            );
                          });
                        } else {
                          ShowToast("Enter Price !!", context);
                        }
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
