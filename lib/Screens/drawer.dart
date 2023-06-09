import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workers_inn/RegistrationPages/signin.dart';
import 'package:workers_inn/Screens/CustomerSupport.dart';
import 'package:workers_inn/Screens/history.dart';
import 'package:workers_inn/Screens/map_provider.dart';
import 'package:workers_inn/variables.dart';
import 'package:workers_inn/workerModule/WorkerRegistration.dart';

import 'package:workers_inn/Screens/home.dart';

class drawer extends StatelessWidget {
  const drawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(242, 245, 119, 35),
            ),
            child: Text(
              'WORKERS_INN',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          Consumer<AppMap>(
            builder: (context, value, _) {
              return ListTile(
                title: const Text('Worker Mode'),
                trailing: Switch(
                    value: context.read<AppMap>().isWorker,
                    onChanged: (mode) {
                      FirebaseFirestore.instance
                          .collection("Customers")
                          .doc(FirebaseAuth.instance.currentUser!.email)
                          .get()
                          .then((value) {
                        var data = value.data();
                        if (data!["isWorker"] ?? false) {
                          context.read<AppMap>().changeMode(mode);
                          FirebaseFirestore.instance
                              .collection("Customers")
                              .doc(FirebaseAuth.instance.currentUser!.email)
                              .update({
                            'active': mode,
                          });
                        } else {
                          showDialog(
                              context: context,
                              builder: (ctx) {
                                return AlertDialog(
                                  title: const Text("Error"),
                                  content: const Text(
                                      "You need to Register as Worker"),
                                  actions: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: orange,
                                      ),
                                      onPressed: () {
                                        Navigator.of(ctx).pop();
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (_) =>
                                                const WorkerRegistration(),
                                          ),
                                        );
                                      },
                                      child: const Text("Register Now"),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: orange,
                                      ),
                                      onPressed: () {
                                        Navigator.of(ctx).pop();
                                      },
                                      child: const Text("OK"),
                                    ),
                                  ],
                                );
                              });
                        }
                      });
                    }),
              );
            },
          ),
          ListTile(
            title: const Text('Customer Mode'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(
                MaterialPageRoute(builder: ((context) => const Home())),
              );
            },
          ),
          ListTile(
            title: const Text('History'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(
                MaterialPageRoute(builder: ((context) => const History())),
              );
            },
          ),
          ListTile(
            title: const Text('Support'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: ((context) => const CustomerSupport())),
              );
            },
          ),
          ListTile(
            title: const Text('Log Out'),
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.pop(context);
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: ((context) => const SignIn())),
                  (route) => false);
            },
          ),
        ],
      ),
    );
  }
}
