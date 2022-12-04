import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workers_inn/RegistrationPages/forgotpassword.dart';
import 'package:workers_inn/RegistrationPages/signup.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
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
            Text("Sign In",
                style: GoogleFonts.merriweather(
                    color: Colors.white, fontSize: 30)),
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
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      Text(
                        "Welcome to WorkersInn",
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
                        child: TextField(
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
                        child: TextField(
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
                              backgroundColor:
                                  const Color.fromARGB(242, 245, 119, 35),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          onPressed: () {},
                          child: Text(
                            "SignIn",
                            style: GoogleFonts.merriweather(fontSize: 18),
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
                            onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => const SignUp())),
                            child: Text(
                              "Sign Up here.",
                              style: GoogleFonts.merriweather(fontSize: 13),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.2,
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
                          onPressed: () {},
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.47,
                            child: Row(
                              children: [
                                const FaIcon(FontAwesomeIcons.google),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.03,
                                ),
                                Text(
                                  "SignIn with google",
                                  style: GoogleFonts.merriweather(fontSize: 15),
                                ),
                              ],
                            ),
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
