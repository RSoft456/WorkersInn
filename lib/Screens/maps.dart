// import 'dart:async';
// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:permission_handler/permission_handler.dart';

// class MapSample extends StatefulWidget {
//   const MapSample({Key? key}) : super(key: key);

//   @override
//   State<MapSample> createState() => MapSampleState();
// }

// class MapSampleState extends State<MapSample> {
//   final Completer<GoogleMapController> _controller =
//       Completer<GoogleMapController>();

//   static const CameraPosition _kGooglePlex = CameraPosition(
//     target: LatLng(31.5204, 74.3587),
//     zoom: 14.4746,
//   );

//   static const CameraPosition _kLake = CameraPosition(
//       bearing: 192.8334901395799,
//       target: LatLng(37.43296265331129, -122.08832357078792),
//       tilt: 59.440717697143555,
//       zoom: 19.151926040649414);

//   @override
//   void initState() {
//     requestPermission();
//     super.initState();
//   }

//   requestPermission() async {
//     log("requesting permission");
//     final permission = await [
//       Permission.location,
//     ].request();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: MediaQuery.of(context).size.height * 0.7,
//       child: GoogleMap(
//         mapType: MapType.none,
//         initialCameraPosition: _kGooglePlex,
//         onMapCreated: (GoogleMapController controller) {
//           _controller.complete(controller);
//         },
//       ),
//     );
//   }

//   Future<void> _goToTheLake() async {
//     final GoogleMapController controller = await _controller.future;
//     controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
//   }
// }
