import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workers_inn/RegistrationPages/signin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:workers_inn/Screens/chats_class_provider.dart';
import 'package:workers_inn/Screens/home.dart';
import 'package:workers_inn/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AllChats()),
      ],
      child: MyApp(),
    ),
  );
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
      title: 'WorkersInn',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: user != null ? const Home() : const SignIn(),
    );
  }
}
