import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FrogotPassword extends StatefulWidget {
  const FrogotPassword({super.key});

  @override
  State<FrogotPassword> createState() => _FrogotPasswordState();
}

class _FrogotPasswordState extends State<FrogotPassword> {
  bool visibility = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(242, 245, 119, 35),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            const Text("Reset Password",
                style: (TextStyle(color: Colors.white, fontSize: 30))),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(35),
                        topRight: Radius.circular(35))),

                //height: MediaQuery.of(context).size.height * 0.95,
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.2,
                      ),
                      if (!visibility)
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: TextField(
                              decoration: InputDecoration(
                                  label: Text(
                                    "Email",
                                    style: GoogleFonts.ptSerif(fontSize: 18),
                                  ),
                                  border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))))),
                        ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      if (visibility)
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: TextField(
                              decoration: InputDecoration(
                                  label: Text(
                                    "New Password",
                                    style: GoogleFonts.ptSerif(fontSize: 18),
                                  ),
                                  border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))))),
                        ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      if (visibility)
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: TextField(
                              decoration: InputDecoration(
                                  label: Text(
                                    "Confirm Password",
                                    style: GoogleFonts.ptSerif(fontSize: 18),
                                  ),
                                  border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))))),
                        ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 10, bottom: 10),
                              backgroundColor:
                                  const Color.fromARGB(242, 245, 119, 35),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          onPressed: () {
                            Navigator.of(context).pop();
                            setState(() {
                              visibility = true;
                            });
                          },
                          child: const Text(
                            "Reset",
                            style: TextStyle(fontSize: 18),
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
