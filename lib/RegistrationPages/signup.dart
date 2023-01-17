import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  FocusNode node = FocusNode();
  GlobalKey key = GlobalKey();
  final _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController userName = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  customDialog(String message) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(message),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (message == "Signed up Successfully") {
                  Navigator.pop(context);
                  Navigator.of(context).pop(email.text);
                } else {
                  Navigator.pop(context);
                }
              },
              child: const Text("ok"),
            ),
          ],
        );
      },
    );
  }

  RegisterUser() async {
    try {
      UserCredential user =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      await FirebaseAuth.instance.signOut();
      customDialog("Signed up Successfully");
      log("${user.user!.email}");
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-email") {
        customDialog("Invalid Email. Please Enter a Correct Email");
      } else if (e.code == "email-already-in-use") {
        customDialog("Email is Already Registered");
      } else if (e.code == "weak-password") {
        customDialog("Enter a Strong Password");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(242, 245, 119, 35),
      body: Container(
        color: const Color.fromARGB(255, 255, 255, 255),
        height: MediaQuery.of(context).size.height * 1,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            SizedBox(
              //height: MediaQuery.of(context).size.height * 0.183,
              child: Image.asset(
                "assets/banner.jpg",
                height: MediaQuery.of(context).size.height * 0.3,
                fit: BoxFit.fill,
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.2,
              child: Container(
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(35),
                        topRight: Radius.circular(35))),

                //height: MediaQuery.of(context).size.height * 0.95,
                width: MediaQuery.of(context).size.width,
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                        Text(
                          "Sign Up",
                          style: GoogleFonts.merriweather(
                              fontSize: 25,
                              color: Colors.orange,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: TextFormField(
                              validator: ((value) {
                                if (value!.isEmpty) {
                                  return "Username field cannot be empty";
                                }
                                return null;
                              }),
                              controller: userName,
                              focusNode: node,
                              decoration: InputDecoration(
                                  labelStyle: TextStyle(
                                    color: node.hasFocus
                                        ? Colors.orange
                                        : Colors.black,
                                  ),
                                  label: Text(
                                    "Username",
                                    style: GoogleFonts.merriweather(),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.orange),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))))),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: TextFormField(
                              validator: ((value) {
                                if (value!.isEmpty) {
                                  return "Username field cannot be empty";
                                }
                                return null;
                              }),
                              controller: email,
                              decoration: InputDecoration(
                                  label: Text(
                                    "Email",
                                    style: GoogleFonts.merriweather(),
                                  ),
                                  border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))))),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: TextFormField(
                              validator: ((value) {
                                if (value!.isEmpty) {
                                  return "Email field cannot be empty";
                                }
                                return null;
                              }),
                              controller: password,
                              decoration: InputDecoration(
                                  label: Text(
                                    "Password",
                                    style: GoogleFonts.merriweather(),
                                  ),
                                  border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))))),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: TextFormField(
                              validator: ((value) {
                                if (value!.isEmpty) {
                                  return "Password field cannot be empty";
                                }
                                return null;
                              }),
                              decoration: InputDecoration(
                                  label: Text(
                                    "Confirm Password",
                                    style: GoogleFonts.merriweather(),
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
                              if (_formKey.currentState!.validate()) {
                                RegisterUser();
                              }

                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (context) => const SignIn()));
                            },
                            child: Text(
                              "Signup",
                              style: GoogleFonts.merriweather(fontSize: 18),
                            )),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account?",
                              style: GoogleFonts.merriweather(fontSize: 12),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.02,
                            ),
                            GestureDetector(
                              onTap: () => Navigator.of(context).pop(),
                              child: Text(
                                "Sign In here.",
                                style: GoogleFonts.merriweather(fontSize: 13),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
