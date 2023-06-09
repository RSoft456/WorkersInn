import 'package:flutter/material.dart';
import 'package:workers_inn/Screens/negotiationScreenCustomer.dart';
import 'package:workers_inn/features/countDown.dart';

class WorkerRequestList extends StatefulWidget {
  const WorkerRequestList({super.key});

  @override
  State<WorkerRequestList> createState() => _WorkerRequestListState();
}

class _WorkerRequestListState extends State<WorkerRequestList> {
  int totalOrders = 0;
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
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: Screensize.width * 0.03,
                          right: Screensize.width * 0.03,
                          left: Screensize.width * 0.03),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "John Doe",
                            style: TextStyle(fontSize: 22),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Text(
                              "Rating: 4.5",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              "Orders: $totalOrders",
                              style: const TextStyle(fontSize: 16),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    InkWell(
                      onTap: () => dialog(),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        child: SizedBox(
                          width: Screensize.width * 0.09,
                          height: Screensize.width * 0.09,
                          child: const Icon(
                            Icons.info_outline,
                            color: Colors.orange,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.09,
                        // child: ElevatedButton(
                        //   style: ElevatedButton.styleFrom(
                        //       //alignment: const Alignment(-6, 0),
                        //       backgroundColor:
                        //           const Color.fromARGB(255, 255, 255, 255),
                        //       shape: RoundedRectangleBorder(
                        //           borderRadius: BorderRadius.circular(50))),
                        //   onPressed: () {},
                        child: const CountDown(),

                        // const Text(
                        //   "4",
                        //   style: TextStyle(color: Colors.black),
                        // ),
                        //),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(
              width: Screensize.width * 0.87,
              child: Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  width: Screensize.width * 0.34,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: Screensize.width * 0.001,
                        bottom: Screensize.width * 0.001,
                        right: Screensize.width * 0.001),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  const NegotiationCustomer()));
                        },
                        child: const Text(
                          "Accept",
                          style: TextStyle(fontSize: 18),
                        )),
                  ),
                ),
              )),
        ],
      ),
    );
  }

  dialog() {
    Size screen = MediaQuery.of(context).size;
    showDialog(
        barrierColor: const Color.fromARGB(174, 0, 0, 0),
        barrierDismissible: false,
        context: (context),
        builder: (context) {
          return AlertDialog(
              insetPadding: EdgeInsets.symmetric(
                  vertical: screen.height * 0.2,
                  horizontal: screen.width * 0.09),
              clipBehavior: Clip.hardEdge,
              content: Column(
                children: [
                  Container(
                    height: screen.height * 0.15,
                    width: screen.height * 0.15,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      border: Border.all(color: Colors.orange, width: 4),
                      borderRadius: BorderRadius.circular(100),
                      image: const DecorationImage(
                        image: AssetImage("assets/profile.png"),
                        //fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("John Doe"),
                  ),
                  const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.all(4),
                        child: Text("Age: 34"),
                      )),
                  const Wrap(
                    children: [
                      Chip(
                        label: Text("Plumber"),
                      ),
                      Chip(
                        label: Text("Electrician"),
                      ),
                      Chip(
                        label: Text("Cleaner"),
                      ),
                    ],
                  ),
                  const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.all(4),
                        child: Text(
                          "Description: ",
                        ),
                      )),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 5, top: 5, bottom: 5),
                        child: Card(
                          // color: const Color.fromARGB(255, 228, 216, 177),
                          child: SingleChildScrollView(
                            child: SizedBox(
                              height: screen.height * 0.04,
                              child: const Text(
                                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("OK"),
                    ),
                  ),
                ],
              ));
        });
  }
}
