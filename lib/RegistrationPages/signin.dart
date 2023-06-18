import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:workers_inn/RegistrationPages/forgotpassword.dart';
import 'package:workers_inn/RegistrationPages/signup.dart';
import 'package:workers_inn/Screens/home.dart';
import 'package:workers_inn/variables.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  bool noException = true;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  UserSignIn() async {
    try {
      log("hi1");
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: email.text, password: password.text);
      log("${user.user!.email}");
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const Home(),
      ));
    } on FirebaseAuthException catch (e) {
      noException = false;
      log("$e");
      log("hi2");
      String message = "";
      if (e.code == "invalid-email" || e.code == "wrong-password") {
        message = "Invalid username or password";
      } else if (e.code == "user-disabled") {
        message = "User is disabled";
      } else if (e.code == "user-not-found") {
        message = "User not registered, Sign Up";
      } else {
        message = "Some error occured, please try again";
      }
      Navigator.pop(context);
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
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
                        Navigator.pop(context);
                      },
                      child: const Text("ok")),
                ],
              ),
            );
          });
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  void loadingIndicator(BuildContext ctx) {
    showDialog(
        barrierDismissible: false,
        context: ctx,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
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
                "assets/banner2.png",
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
                        topLeft: Radius.circular(45),
                        topRight: Radius.circular(45))),

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
                          "Sign In",
                          style: GoogleFonts.merriweather(
                              fontSize: 25,
                              color: orange,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter a valid email";
                                }
                                return null;
                              },
                              controller: email,
                              decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.email),
                                  label: Text("Email",
                                      style: GoogleFonts.merriweather()),
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
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter a valid password";
                                }
                                return null;
                              },
                              controller: password,
                              decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.key),
                                  label: Text("Password",
                                      style: GoogleFonts.merriweather()),
                                  border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))))),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.6),
                          child: GestureDetector(
                              onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const FrogotPassword())),
                              child: Text("Forgot Password?",
                                  style: GoogleFonts.merriweather())),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, top: 10, bottom: 10),
                                backgroundColor: orange,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            onPressed: () {
                              showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (ctx) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  });
                              if (_formKey.currentState!.validate()) {
                                UserSignIn();
                              }
                            },
                            child: Text(
                              "SignIn",
                              style: GoogleFonts.merriweather(
                                  fontSize: 18, color: white),
                            )),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account?",
                              style: GoogleFonts.merriweather(fontSize: 12),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.02,
                            ),
                            GestureDetector(
                              onTap: () => Navigator.of(context)
                                  .push(
                                MaterialPageRoute(
                                  builder: (context) => const SignUp(),
                                ),
                              )
                                  .then((value) {
                                log("value returned: $value");
                                email.text = value;
                                setState(() {});
                              }),
                              child: Text(
                                "Sign Up here.",
                                style: GoogleFonts.merriweather(fontSize: 13),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.14,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(240, 245, 73, 61),
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 10, bottom: 10),
                              // shape: RoundedRectangleBorder(
                              //     borderRadius: BorderRadius.circular(20))
                            ),
                            onPressed: () async {
                              loadingIndicator(context);
                              await signInWithGoogle().then((value) {
                                Navigator.of(context).pop();
                                log("${value.user!.displayName}");
                                log("length: ${value.user!.providerData.length}");
                                try {
                                  FirebaseFirestore.instance
                                      .collection("Customers")
                                      .doc(value.user!.email)
                                      .set({
                                    "uid": value.user?.uid,
                                    "email": value.user?.email,
                                    "displayName": value.user?.displayName,
                                  }).then(
                                    (value) {
                                      Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                          builder: (context) => const Home(),
                                        ),
                                        (route) => false,
                                      );
                                    },
                                  );
                                } on FirebaseException catch (e) {
                                  log("${e.code} ${e.message}");
                                  Navigator.of(context).pop();
                                  showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (ctx) {
                                        return AlertDialog(
                                          title: const Text("Error"),
                                          content: const Text(
                                              "Play Try Again Later"),
                                          actions: [
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text("OK"),
                                            ),
                                          ],
                                        );
                                      });
                                }
                              });
                            },
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Row(
                                children: [
                                  FaIcon(FontAwesomeIcons.google, color: white),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.03,
                                  ),
                                  Text(
                                    "SignIn with google",
                                    style: GoogleFonts.merriweather(
                                        fontSize: 15, color: white),
                                  ),
                                ],
                              ),
                            )),
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
