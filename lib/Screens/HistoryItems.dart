import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HistoryList extends StatefulWidget {
  const HistoryList({super.key, required this.service, required this.id});
  final String service, id;

  @override
  State<HistoryList> createState() => _HistoryListState();
}

class _HistoryListState extends State<HistoryList> {
  String mnumber = "", mname = "";
  @override
  void initState() {
    FirebaseFirestore.instance
        .collection("Customers")
        .where("uid", isEqualTo: widget.id)
        .get()
        .then((value2) {
      log("${value2.docs.first["number"]}");
      mnumber = value2.docs.first["number"];
      mname = value2.docs.first["displayName"];
      setState(() {});
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size Screensize = MediaQuery.of(context).size;
    return Card(
      color: const Color.fromARGB(255, 255, 255, 255),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.009),
            child: Row(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.08,
                  width: MediaQuery.of(context).size.height * 0.08,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.orange, width: 4),
                      borderRadius: BorderRadius.circular(50),
                      image: const DecorationImage(
                        image: AssetImage("assets/profile.png"),
                        fit: BoxFit.fill,
                      )),
                ),
                SizedBox(
                  width: Screensize.width * 0.65,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.width * 0.04),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            mname,
                            style: const TextStyle(fontSize: 18),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              "Service: ${widget.service}",
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: SelectableText.rich(
                              TextSpan(
                                style: const TextStyle(fontSize: 16),
                                children: [
                                  TextSpan(text: "Contact: $mnumber"),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Column(
                //   children: [
                //     InkWell(
                //       //onTap: () => dialog(),
                //       child: Card(
                //         shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(30)),
                //         child: SizedBox(
                //           width: Screensize.width * 0.09,
                //           height: Screensize.width * 0.09,
                //           child: const Icon(
                //             Icons.info_outline,
                //             color: Colors.orange,
                //           ),
                //         ),
                //       ),
                //     ),
                // Container(
                //   child: SizedBox(
                //     width: MediaQuery.of(context).size.width * 0.09,
                // child: ElevatedButton(
                //   style: ElevatedButton.styleFrom(
                //       //alignment: const Alignment(-6, 0),
                //       backgroundColor:
                //           const Color.fromARGB(255, 255, 255, 255),
                //       shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(50))),
                //   onPressed: () {},
                //child: const CountDown(),

                // const Text(
                //   "4",
                //   style: TextStyle(color: Colors.black),
                // ),
                //),
                // ),
                //),
                //   ],
                // )
              ],
            ),
          ),
          // SizedBox(
          //     width: Screensize.width * 0.87,
          //     child: Align(
          //       alignment: Alignment.centerRight,
          //       child: SizedBox(
          //         width: Screensize.width * 0.34,
          //         child: Padding(
          //           padding: EdgeInsets.all(Screensize.width * 0.001),
          //           child: ElevatedButton(
          //               style: ElevatedButton.styleFrom(
          //                   backgroundColor: Colors.orange),
          //               onPressed: () {
          //                 // Navigator.of(context).push(MaterialPageRoute(
          //                 //     builder: (context) =>
          //                 //         const NegotiationCustomer()));
          //               },
          //               child: const Text(
          //                 "Accept",
          //                 style: TextStyle(fontSize: 18),
          //               ),),
          //         ),
          //      ),
          //     ),
          //     ),
        ],
      ),
    );
  }
}
