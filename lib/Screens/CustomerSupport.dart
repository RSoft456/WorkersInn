import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:workers_inn/variables.dart';

class CustomerSupport extends StatefulWidget {
  const CustomerSupport({super.key});

  @override
  State<CustomerSupport> createState() => _CustomerSupportState();
}

class _CustomerSupportState extends State<CustomerSupport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('Support'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.1,
                left: MediaQuery.of(context).size.width * 0.05,
                right: MediaQuery.of(context).size.width * 0.05),
            child: Text(
              "Having trouble with something? or want to report an issue? Contact us on the email given below, we will try our best to get your querry resolved as soon as possible. \n\nThankyou.\nRegards,\nTeam WorkersInn.",
              style: TextStyle(
                color: orange,
                fontSize: 16,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              openGmail();
            },
            child: Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.05),
              child: Text("WorkersInn@gmail.com",
                  style: TextStyle(
                    color: green,
                    fontSize: 16,
                  )),
            ),
          )
        ],
      ),
    );
  }

  openGmail() async {
    String email = Uri.encodeComponent("WorkersInn@gmail.com");
    String subject = Uri.encodeComponent("Report");
    String body = Uri.encodeComponent("Write your querry here:");
    Uri mail = Uri.parse("mailto:$email?subject=$subject&body=$body");
    if (await launchUrl(mail)) {
      //email app opened
    } else {
      ShowToast("Some Error occured", context);
    }
  }
}
