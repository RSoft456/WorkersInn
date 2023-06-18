import 'package:flutter/material.dart';

Color orange = Colors.orange;

Color white = const Color.fromARGB(241, 255, 255, 255);
Color green = const Color.fromARGB(240, 8, 164, 44);
Color grey = const Color.fromARGB(255, 231, 231, 231);
int selectedJob = 0;

dialogBox(ctxx, message, positive, negative, popContext) {
  showDialog(
      barrierDismissible: false,
      context: ctxx,
      builder: (ctx) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            content: Text(message),
            actions: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: orange,
                  ),
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  child: Text(negative, style: TextStyle(color: white))),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: orange,
                  ),
                  onPressed: () {
                    Navigator.pop(ctx);
                    if (popContext) {
                      Navigator.pop(ctxx);
                    }
                  },
                  child: Text(
                    positive,
                    style: TextStyle(color: white),
                  )),
            ],
          ),
        );
      });
}

ShowToast(message, ctx) {
  SnackBar snackBar = SnackBar(
    content: Text(message),
  );
  ScaffoldMessenger.of(ctx).showSnackBar(snackBar);
}

showLoader(BuildContext context) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) {
        return const Center(child: CircularProgressIndicator());
      });
}

int t = 1;
