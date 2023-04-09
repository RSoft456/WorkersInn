import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workers_inn/Screens/WCchats.dart';
import 'package:workers_inn/Screens/home.dart';

import '../variables.dart';

class RequestInProcesOverlay extends StatefulWidget {
  const RequestInProcesOverlay({super.key});

  @override
  State<RequestInProcesOverlay> createState() => _RequestInProcesOverlayState();
}

class _RequestInProcesOverlayState extends State<RequestInProcesOverlay> {
  String job = "cleaner";
  Color cardColor = green;
  int amount = 200;
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 5), () {
      showDialog(
        context: context,
        builder: ((context) {
          return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: AlertDialog(
              content: const Text("Request completed !!"),
              actions: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: orange),
                    onPressed: () {
                      Showrating(context);
                    },
                    child: Text(
                      "Ok",
                      style: TextStyle(color: white),
                    )),
              ],
            ),
          );
        }),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    InputDecoration textFieldDecoration = InputDecoration(
        prefixIcon: const Icon(Icons.location_on_outlined),
        label: Text("Location", style: GoogleFonts.merriweather()),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))));
    TextEditingController locationController = TextEditingController();
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Container(
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
              child: Text("Request In Process",
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
                width: MediaQuery.of(context).size.width * 0.78,
                child: Row(
                    //scrollDirection: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(
                        color: selectedJob == 1 ? green : grey,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Image.asset(
                            "assets/electrician.png",
                            height: MediaQuery.of(context).size.height * 0.1,
                            width: MediaQuery.of(context).size.height * 0.1,
                            color: selectedJob == 1 ? Colors.white : null,
                          ),
                        ),
                      ),
                      Card(
                        color: selectedJob == 2 ? green : grey,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Image.asset(
                            "assets/cleaner.png",
                            height: MediaQuery.of(context).size.height * 0.1,
                            width: MediaQuery.of(context).size.height * 0.1,
                            color: selectedJob == 2 ? Colors.white : null,
                          ),
                        ),
                      ),
                      Card(
                        color: selectedJob == 3 ? green : grey,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Image.asset(
                            "assets/plumber.png",
                            height: MediaQuery.of(context).size.height * 0.1,
                            width: MediaQuery.of(context).size.height * 0.1,
                            color: selectedJob == 3 ? Colors.white : null,
                          ),
                        ),
                      ),
                    ]),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
              child: Text("$job John Doe is on it's way"),
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.14,
                      top: MediaQuery.of(context).size.height * 0.01),
                  child: Row(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.15,
                        width: MediaQuery.of(context).size.height * 0.15,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.orange, width: 4),
                            borderRadius: BorderRadius.circular(70),
                            image: const DecorationImage(
                              image: AssetImage("assets/profile.png"),
                              fit: BoxFit.fill,
                            )),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.04),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.width *
                                          0.02),
                                  child: const Text("John Doe "),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.08),
                                  child: InkWell(
                                    onTap: () => openDialPad("03456478564"),
                                    child: const Icon(
                                      Icons.call,
                                      color: Colors.orange,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.03),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const WCchats()),
                                      );
                                    },
                                    child: const Icon(
                                      Icons.message,
                                      color: Colors.orange,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top:
                                      MediaQuery.of(context).size.width * 0.01),
                              child: Text("To Pay: Rs.$amount"),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),

            // Padding(
            //   padding: const EdgeInsets.only(top: 20),
            //   child: SizedBox(
            //     width: MediaQuery.of(context).size.width * 0.8,
            //     child: TextField(
            //         onTap: () async {
            // final sessionToken = const Uuid().v4();
            // Suggestion? result = await showSearch(
            //   context: context,
            //   delegate: AddressSearch(sessionToken: sessionToken),
            // );
            // var latlong = await PlaceApiProvider(sessionToken)
            //     .getPlaceDetailFromId(result!.placeId);
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
            //         },
            //         keyboardType: TextInputType.none,
            //         controller: locationController,
            //         decoration: textFieldDecoration),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(10.0),
            //   child: SizedBox(
            //     width: MediaQuery.of(context).size.width * 0.8,
            //     child: ElevatedButton(
            //         style: ButtonStyle(
            //             padding:
            //                 MaterialStateProperty.all(const EdgeInsets.all(25)),
            //             shape: MaterialStateProperty.all(
            //                 const RoundedRectangleBorder(
            //                     borderRadius:
            //                         BorderRadius.all(Radius.circular(20)))),
            //             backgroundColor: MaterialStateProperty.all(orange)),
            //         onPressed: () {
            //           if (selectedJob == 0) {
            //             showDialog(
            //                 barrierDismissible: false,
            //                 context: context,
            //                 builder: (context) {
            //                   return AlertDialog(
            //                     content: const Text("please select a job"),
            //                     actions: [
            //                       ElevatedButton(
            //                           onPressed: () {
            //                             Navigator.pop(context);
            //                           },
            //                           child: const Text("ok")),
            //                     ],
            //                   );
            //                 });
            //           } else {
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => const RequestsPage()));
            //   }
            // },
            // child: const Text(
            //   'Request Worker',
            //   style:
            //       TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
            // )),
            //),
            //)
          ],
        ),
      ),
    );
  }

  Showrating(ctx) {
    int rating = 0;
    bool visibility = false;
    IconData star1 = Icons.star_border_rounded;
    IconData star2 = Icons.star_border_rounded;
    IconData star3 = Icons.star_border_rounded;
    IconData star4 = Icons.star_border_rounded;
    IconData star5 = Icons.star_border_rounded;
    IconData starFilled = Icons.star_rounded;
    IconData starHollow = Icons.star_border_rounded;
    showDialog(
        barrierDismissible: false,
        context: ctx,
        builder: (ctxx) {
          return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  title: const Text("Rate Worker !"),
                  titleTextStyle: TextStyle(
                      color: orange, fontSize: 19, fontWeight: FontWeight.bold),
                  titlePadding: EdgeInsets.only(
                      left: MediaQuery.of(ctx).size.width * 0.23,
                      top: MediaQuery.of(ctx).size.width * 0.03),
                  content: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          visibility = true;
                          rating = 1;
                          star1 = starFilled;
                          star2 = starHollow;
                          star3 = starHollow;
                          star4 = starHollow;
                          star5 = starHollow;
                          setState(() {});
                        },
                        child: Icon(
                          star1,
                          size: 45,
                          color: const Color.fromARGB(255, 255, 222, 59),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          visibility = true;
                          rating = 2;
                          star1 = starFilled;
                          star2 = starFilled;
                          star3 = starHollow;
                          star4 = starHollow;
                          star5 = starHollow;
                          setState(() {});
                        },
                        child: Icon(
                          star2,
                          size: 45,
                          color: const Color.fromARGB(255, 255, 222, 59),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          visibility = true;
                          rating = 3;
                          star1 = starFilled;
                          star2 = starFilled;
                          star3 = starFilled;
                          star4 = starHollow;
                          star5 = starHollow;
                          setState(() {});
                        },
                        child: Icon(
                          star3,
                          size: 45,
                          color: const Color.fromARGB(255, 255, 222, 59),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          visibility = true;
                          rating = 4;
                          star1 = starFilled;
                          star2 = starFilled;
                          star3 = starFilled;
                          star4 = starFilled;
                          star5 = starHollow;
                          setState(() {});
                        },
                        child: Icon(
                          star4,
                          size: 45,
                          color: const Color.fromARGB(255, 255, 222, 59),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          visibility = true;
                          rating = 5;
                          star1 = starFilled;
                          star2 = starFilled;
                          star3 = starFilled;
                          star4 = starFilled;
                          star5 = starFilled;
                          setState(() {});
                        },
                        child: Icon(
                          star5,
                          size: 45,
                          color: const Color.fromARGB(255, 255, 222, 59),
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    ElevatedButton(
                        style:
                            ElevatedButton.styleFrom(backgroundColor: orange),
                        onPressed: () {
                          Navigator.pop(ctxx);

                          Navigator.of(ctxx).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => const Home()),
                              (route) => false);
                        },
                        child: Text(
                          "Later",
                          style: TextStyle(color: white),
                        )),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: orange),
                      onPressed: visibility
                          ? () {
                              Navigator.pop(ctxx);
                              Navigator.of(ctxx).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => const Home()),
                                  (route) => false);
                            }
                          : null,
                      child: Text(
                        "Submit",
                        style: TextStyle(color: white),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        });
  }
}
