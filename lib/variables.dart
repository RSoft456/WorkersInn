import 'package:flutter/material.dart';

Color orange = const Color.fromARGB(242, 245, 119, 35);
Color white = const Color.fromARGB(241, 255, 255, 255);
Color green = const Color.fromARGB(240, 8, 164, 44);
Color grey = const Color.fromARGB(255, 231, 231, 231);
int selectedJob = 0;
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
