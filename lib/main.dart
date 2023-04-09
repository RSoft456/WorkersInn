import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:workers_inn/Screens/chats_class_provider.dart';
import 'package:workers_inn/firebase_options.dart';

import 'RegistrationPages/signin.dart';
import 'Screens/home.dart';

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
  initstate() {
    log("$user");
  }

  @override
  Widget build(BuildContext context) {
    //super.initState;
    // Future.delayed(
    //     const Duration(seconds: 3),
    //     () => Navigator.pushReplacement(context,
    //             MaterialPageRoute(builder: (context) {
    //           try {
    //             user != null
    //                 ? Navigator.of(context).push(
    //                     MaterialPageRoute(builder: (context) => const Home()))
    //                 : Navigator.of(context).push(MaterialPageRoute(
    //                     builder: (context) => const SignIn()));
    //           } catch (ex) {
    //             print(ex);
    //           }
    //           throw (exx) {
    //             print(exx);
    //           };
    //         })));

    return MaterialApp(
      title: 'WorkersInn',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: user != null ? const Home() : const SignIn(),
      //home: const Splash(),
    );
  }
}

// class Splash extends StatefulWidget {
//   const Splash({super.key});

//   @override
//   State<Splash> createState() => _SplashState();
// }

// class _SplashState extends State<Splash> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         //     gradient: LinearGradient(
//         //   colors: [
//         //     Color.fromARGB(255, 127, 31, 182),
//         //     Color.fromARGB(255, 127, 31, 182),
//         //     Color.fromARGB(255, 74, 72, 64),
//         //     Color.fromARGB(255, 74, 72, 64),
//         //   ],
//         //   begin: Alignment.topCenter,
//         //   end: Alignment.bottomCenter,
//         // ),
//         color: Colors.black,
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           SizedBox(
//               width: MediaQuery.of(context).size.height * 0.4,
//               child: Image.asset('assets/banner.jpg')),
//           // if (!isConnected)
//           //   SizedBox(
//           //     height: MediaQuery.of(context).size.height * 0.02,
//           //   ),
//           // isConnected
//           //     ? Container()
//           //     : Image.asset(
//           //         'assets/connection.png',
//           //         scale: 15,
//           //       ),
//           // SizedBox(
//           //   height: MediaQuery.of(context).size.height * 0.02,
//           // ),
//           // isConnected
//           //     ? const Text('')
//           //     : const Text(
//           //         'Connection Error!... Please check Your Internet'),
//         ],
//       ),
//     );
//   }
// }
