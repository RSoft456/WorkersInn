import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Color orange = Colors.orange;
Color white = const Color.fromARGB(241, 255, 255, 255);
Color green = const Color.fromARGB(240, 8, 164, 44);
Color grey = const Color.fromARGB(255, 231, 231, 231);
int selectedJob = 0;

openDialPad(String phoneNumber) async {
  Uri url = Uri(scheme: "tel", path: phoneNumber);
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    print("Can't open dial pad.");
  }
}

dialogBox(ctxx, message, positive, negative, popContext) {
  showDialog(
      barrierDismissible: false,
      context: ctxx,
      builder: (ctx) {
        return AlertDialog(
          content: Text(message),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: Text(negative)),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(ctx);
                  if (popContext) {
                    Navigator.pop(ctxx);
                  }
                },
                child: Text(
                  positive,
                )),
          ],
        );
      });
}

ShowToast(message, ctx) {
  SnackBar snackBar = SnackBar(
    content: Text(message),
  );
  ScaffoldMessenger.of(ctx).showSnackBar(snackBar);
}
