import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:workers_inn/RegistrationPages/signin.dart';
import 'package:workers_inn/workerModule/WorkerRegistration.dart';

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
          ListTile(
            title: const Text('Worker Mode'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: ((context) => const WorkerRegistration())),
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
