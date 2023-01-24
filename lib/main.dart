import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:workers_inn/RegistrationPages/signin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:workers_inn/Screens/home.dart';
import 'package:workers_inn/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  // This widget is the root of your application.
  User? user = FirebaseAuth.instance.currentUser;
  initState() {
    log("$user");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: user != null ? const Home() : const SignIn(),
    );
  }
}
