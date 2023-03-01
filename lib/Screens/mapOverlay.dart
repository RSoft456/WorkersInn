import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';
import 'package:workers_inn/Screens/address_search.dart';
import 'package:workers_inn/Screens/place_service.dart';
import 'package:workers_inn/Screens/requests.dart';
import 'package:workers_inn/variables.dart';

class MapOverlay extends StatefulWidget {
  const MapOverlay({super.key});

  @override
  State<MapOverlay> createState() => _MapOverlayState();
}

class _MapOverlayState extends State<MapOverlay> {
  Color cardColor = green;
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
          top: MediaQuery.of(context).size.height * 0.6,
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
              child: Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.01),
                //color: Colors.amber,
                height: MediaQuery.of(context).size.height * 0.112,
                width: MediaQuery.of(context).size.width * 0.78,
                child: ListView(scrollDirection: Axis.horizontal, children: [
                  InkWell(
                    onTap: () {
                      selectedJob = 1;
                      setState(() {});
                    },
                    child: Card(
                      color: selectedJob == 1 ? green : grey,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Image.asset(
                          "assets/electrician.jpg",
                          height: MediaQuery.of(context).size.height * 0.1,
                          width: MediaQuery.of(context).size.height * 0.1,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      selectedJob = 2;
                      setState(() {});
                    },
                    child: Card(
                      color: selectedJob == 2 ? green : grey,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Image.asset(
                          "assets/electrician.jpg",
                          height: MediaQuery.of(context).size.height * 0.1,
                          width: MediaQuery.of(context).size.height * 0.1,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      selectedJob = 3;
                      setState(() {});
                    },
                    child: Card(
                      color: selectedJob == 3 ? green : grey,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Image.asset(
                          "assets/electrician.jpg",
                          height: MediaQuery.of(context).size.height * 0.1,
                          width: MediaQuery.of(context).size.height * 0.1,
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextField(
                    onTap: () async {
                      final sessionToken = const Uuid().v4();
                      Suggestion? result = await showSearch(
                        context: context,
                        delegate: AddressSearch(sessionToken: sessionToken),
                      );
                      var latlong = await PlaceApiProvider(sessionToken)
                          .getPlaceDetailFromId(result!.placeId);
                      //print(latlong);
                      // showModalBottomSheet(
                      //     shape: const RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.only(
                      //             topLeft: Radius.circular(45),
                      //             topRight: Radius.circular(45))),
                      //     isScrollControlled: true,
                      //     context: context,
                      //     builder: (context) {
                      //       return Wrap(
                      //         children: [
                      //           SizedBox(
                      //             height:
                      //                 MediaQuery.of(context).size.height * 0.9,
                      //             child:
                      //                 Container(), //const locationSearcher(),
                      //           )
                      //         ],
                      //       );
                      //     });
                    },
                    keyboardType: TextInputType.none,
                    controller: locationController,
                    decoration: textFieldDecoration),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
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
                      if (selectedJob == 0) {
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: const Text("please select a job"),
                                actions: [
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text("ok")),
                                ],
                              );
                            });
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RequestsPage()));
                      }
                    },
                    child: const Text(
                      'Request Worker',
                      style:
                          TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                    )),
              ),
            )
          ],
        ));
  }
}
