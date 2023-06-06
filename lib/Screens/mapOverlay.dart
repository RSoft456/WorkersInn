import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:workers_inn/Screens/address_search.dart';
import 'package:workers_inn/Screens/map_provider.dart';
import 'package:workers_inn/Screens/place_service.dart';
import 'package:workers_inn/Screens/requests.dart';
import 'package:workers_inn/variables.dart';

class MapOverlay extends StatefulWidget {
  const MapOverlay({super.key});

  @override
  State<MapOverlay> createState() => _MapOverlayState();
}

class _MapOverlayState extends State<MapOverlay> {
  String job = "";
  Color cardColor = green;
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
          top: MediaQuery.of(context).size.height * 0.55,
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
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.02),
              child: Text("Select a service",
                  style: TextStyle(
                      fontSize: 20,
                      color: orange,
                      fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.01),
              child: Container(
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.01,
                ),
                //color: Colors.amber,
                height: MediaQuery.of(context).size.height * 0.112,
                width: MediaQuery.of(context).size.width * 0.79,
                child: Row(mainAxisAlignment: MainAxisAlignment.center,
                    //scrollDirection: Axis.horizontal,
                    children: [
                      InkWell(
                        onTap: () {
                          selectedJob = 1;
                          job = "electrician";
                          setState(() {});
                        },
                        child: Card(
                          color: selectedJob == 1 ? green : grey,
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Image.asset(
                              "assets/electrician.png",
                              height: MediaQuery.of(context).size.height * 0.1,
                              width: MediaQuery.of(context).size.height * 0.1,
                              color: selectedJob == 1 ? Colors.white : null,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          selectedJob = 2;
                          job = "cleaner";
                          setState(() {});
                        },
                        child: Card(
                          color: selectedJob == 2 ? green : grey,
                          child: Padding(
                            padding: const EdgeInsets.all(4),
                            child: Image.asset(
                              "assets/cleaner.png",
                              height: MediaQuery.of(context).size.height * 0.1,
                              width: MediaQuery.of(context).size.height * 0.1,
                              color: selectedJob == 2 ? Colors.white : null,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          selectedJob = 3;
                          job = "plumber";
                          setState(() {});
                        },
                        child: Card(
                          color: selectedJob == 3 ? green : grey,
                          child: Padding(
                            padding: const EdgeInsets.all(4),
                            child: Image.asset(
                              "assets/plumber.png",
                              height: MediaQuery.of(context).size.height * 0.1,
                              width: MediaQuery.of(context).size.height * 0.1,
                              color: selectedJob == 3 ? Colors.white : null,
                            ),
                          ),
                        ),
                      ),
                    ]),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.01),
              child: Text(job, style: const TextStyle(fontSize: 17)),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width * 0.02),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextField(
                  onTap: () async {
                    final sessionToken = const Uuid().v4();
                    Suggestion? result = await showSearch(
                      context: context,
                      delegate: AddressSearch(sessionToken: sessionToken),
                    );
                    log("hhhhhhh");
                    if (result == null) {
                      log("null result");
                      return;
                    }
                    var latlong = await PlaceApiProvider(sessionToken)
                        .getPlaceDetailFromId(result.placeId);
                    // var latlongg = await PlaceApiProvider(sessionToken)
                    //     .getPlaceDetailFromId(result.description);
                    //int l = result.description.length;
                    log("hiiiii $latlong");
                    final marker = Marker(
                      markerId: const MarkerId("current"),
                      infoWindow: const InfoWindow(
                        title: "Pickup Location",
                      ),
                      position: LatLng(latlong["lat"], latlong['lng']),
                    );
                    // if (!mounted) {
                    //   log("not Mounted");
                    //   return;
                    // }
                    context.read<AppMap>().moveMap(
                          latlong["lat"],
                          latlong['lng'],
                        );
                    // ignore: use_build_context_synchronously
                    context.read<AppMap>().addMarker(marker);
                  },
                  keyboardType: TextInputType.none,
                  controller: locationController,
                  decoration: textFieldDecoration,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: ElevatedButton(
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.all(
                            MediaQuery.of(context).size.width * 0.07)),
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
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: orange),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        "ok",
                                        style: TextStyle(color: white),
                                      )),
                                ],
                              );
                            });
                      } else {
                        selectedJob = 0;
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
