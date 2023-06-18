import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workers_inn/variables.dart';
import 'package:workers_inn/workerModule/workerRequestPage.dart';

class WorkerMapOverlay extends StatefulWidget {
  const WorkerMapOverlay({super.key});

  @override
  State<WorkerMapOverlay> createState() => _WorkerMapOverlayState();
}

class _WorkerMapOverlayState extends State<WorkerMapOverlay> {
  @override
  Widget build(BuildContext context) {
    InputDecoration textFieldDecoration = InputDecoration(
        prefixIcon: const Icon(Icons.location_on_outlined),
        label: Text("Location", style: GoogleFonts.merriweather()),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))));
    TextEditingController locationController = TextEditingController();
    return Container(
        margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.7,
        ),
        decoration: const BoxDecoration(
            //color: Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(45), topRight: Radius.circular(45))),

        //height: MediaQuery.of(context).size.height * 0.95,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Expanded(child: Container()),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: ElevatedButton(
                    style: ButtonStyle(
                        padding:
                            MaterialStateProperty.all(const EdgeInsets.all(25)),
                        shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)))),
                        backgroundColor: MaterialStateProperty.all(orange)),
                    onPressed: () {
                      BuildContext ctx = context;
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            ctx = context;
                            return WillPopScope(
                              onWillPop: () async => false,
                              child: Center(
                                  child: CircularProgressIndicator(
                                color: orange,
                              )),
                            );
                          });

                      FirebaseFirestore.instance
                          .collection("Customers")
                          .doc(FirebaseAuth.instance.currentUser?.email)
                          .get()
                          .then((value) {
                        Navigator.of(ctx).pop();
                        var Workerdata = value.data()!;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WorkRequestPage(
                                      services: Workerdata["service"],
                                    )));
                      });
                    },
                    child: const Text(
                      'Check Requests',
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    )),
              ),
            ),
            const SizedBox(
              height: 40,
            )
          ],
        ));
  }
}
