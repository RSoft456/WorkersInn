import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:workers_inn/Screens/chat.dart';

class NegotiationCustomer extends StatefulWidget {
  const NegotiationCustomer({super.key});

  @override
  State<NegotiationCustomer> createState() => _NegotiationCustomerState();
}

class _NegotiationCustomerState extends State<NegotiationCustomer> {
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
                          onPressed: () {},
                          child: const Text("Rs.00")),
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
