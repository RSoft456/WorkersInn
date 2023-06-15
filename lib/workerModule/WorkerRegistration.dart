import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workers_inn/variables.dart';

class WorkerRegistration extends StatefulWidget {
  const WorkerRegistration({super.key});

  @override
  State<WorkerRegistration> createState() => _WorkerRegistrationState();
}

class _WorkerRegistrationState extends State<WorkerRegistration> {
  final _formKey = GlobalKey<FormState>();
  bool plumber = true;
  bool cleaner = true;
  bool electrician = true;
  TextEditingController nameController = TextEditingController();
  TextEditingController cnicController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController numberController = TextEditingController();

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
                    topRight: Radius.circular(45),
                  ),
                ),
                height: MediaQuery.of(context).size.height * 0.8,
                width: MediaQuery.of(context).size.width,
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Register as Worker",
                              style: GoogleFonts.merriweather(
                                  fontSize: 25,
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter a valid name";
                              }
                              return null;
                            },
                            controller: nameController,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.person),
                              label: Text("Your Name",
                                  style: GoogleFonts.merriweather()),
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter a valid cnic";
                              }
                              return null;
                            },
                            controller: cnicController,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.credit_card),
                              label: Text("Cnic",
                                  style: GoogleFonts.merriweather()),
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter country";
                              }
                              return null;
                            },
                            controller: countryController,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.flag),
                              label: Text("Country",
                                  style: GoogleFonts.merriweather()),
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter city";
                              }
                              return null;
                            },
                            controller: cityController,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.flag_outlined),
                              label: Text("City",
                                  style: GoogleFonts.merriweather()),
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter your address";
                              }
                              return null;
                            },
                            controller: addressController,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.home),
                              label: Text("Address",
                                  style: GoogleFonts.merriweather()),
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter your contact number";
                              }
                              return null;
                            },
                            controller: numberController,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.phone),
                              label: Text("Contact Number",
                                  style: GoogleFonts.merriweather()),
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: TextFormField(
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.settings),
                              label: Text("Experience:",
                                  style: GoogleFonts.merriweather()),
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          padding: const EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.grey,
                            ),
                          ),
                          child: Column(children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.03,
                              child: const Text(
                                  'Select services you will be giving: '),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: CheckboxListTile(
                                //checkbox positioned at right
                                activeColor: orange,

                                value: plumber,
                                onChanged: (value) {
                                  setState(() {
                                    plumber = value!;
                                  });
                                },
                                title: const Text("Plumbing"),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: CheckboxListTile(
                                //checkbox positioned at right
                                activeColor: orange,
                                value: cleaner,
                                onChanged: (value) {
                                  setState(() {
                                    cleaner = value!;
                                  });
                                },
                                title: const Text("Cleaning"),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: CheckboxListTile(
                                //checkbox positioned at right
                                activeColor: orange,

                                value: electrician,
                                onChanged: (value) {
                                  setState(() {
                                    electrician = value!;
                                  });
                                },
                                title: const Text("Electrician"),
                              ),
                            ),
                          ]),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: orange,
                                padding: EdgeInsets.all(
                                    MediaQuery.of(context).size.width * 0.03)),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                List<String> service = [];
                                if (plumber) service.add("plumber");
                                if (cleaner) service.add("cleaner");
                                if (electrician) service.add("electrician");

                                FirebaseFirestore.instance
                                    .collection("Customers")
                                    .doc(
                                        "${FirebaseAuth.instance.currentUser?.email}")
                                    .update({
                                  "isWorker": true,
                                  "number": numberController.text,
                                  "service": service,
                                });
                              }

                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (context) => const Verification()));
                            },
                            child: const Text('submit'),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
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
