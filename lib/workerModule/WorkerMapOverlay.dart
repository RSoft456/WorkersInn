import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workers_inn/Screens/searchLocation.dart';
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
        label: Text("Destination", style: GoogleFonts.merriweather()),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))));
    TextEditingController locationController = TextEditingController();
    return Container(
        margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.7,
        ),
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(45), topRight: Radius.circular(45))),

        //height: MediaQuery.of(context).size.height * 0.95,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextField(
                      onTap: () {
                        showModalBottomSheet(
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(45),
                                    topRight: Radius.circular(45))),
                            isScrollControlled: true,
                            context: context,
                            builder: (context) {
                              return Wrap(
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.9,
                                    child: const locationSearcher(),
                                  )
                                ],
                              );
                            });
                      },
                      keyboardType: TextInputType.none,
                      controller: locationController,
                      decoration: textFieldDecoration),
                ),
              ),
            ),
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const WorkRequestPage()));
                      // if (selectedJob == 0) {
                      //   showDialog(
                      //       barrierDismissible: false,
                      //       context: context,
                      //       builder: (context) {
                      //         return AlertDialog(
                      //           content: const Text("please select a job"),
                      //           actions: [
                      //             ElevatedButton(
                      //                 onPressed: () {
                      //                   Navigator.pop(context);
                      //                 },
                      //                 child: const Text("ok")),
                      //           ],
                      //         );
                      //       });
                      // } else {
                      //   Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //           builder: (context) => const RequestsPage()));
                      // }
                    },
                    child: const Text(
                      'Start Accepting Requests',
                      style:
                          TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                    )),
              ),
            )
          ],
        ));
  }
}
