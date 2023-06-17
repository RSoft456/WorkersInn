import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:workers_inn/Screens/drawer.dart';
import 'package:workers_inn/Screens/mapOverlay.dart';
import 'package:workers_inn/Screens/map_provider.dart';
import 'package:workers_inn/workerModule/WorkerMapOverlay.dart';

import 'location_provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(31.5204, 74.3587),
    zoom: 14.4746,
  );

  // static const CameraPosition _kLake = CameraPosition(
  //     bearing: 192.8334901395799,
  //     target: LatLng(37.43296265331129, -122.08832357078792),
  //     tilt: 59.440717697143555,
  //     zoom: 19.151926040649414);

  @override
  void initState() {
    requestPermission();
    super.initState();
  }

  requestPermission() async {
    log("requesting permission");
    final permission = await [
      Permission.location,
    ].request().then((value) async {
      Location location = Location();
      var loc = await location.getLocation();
      final marker = Marker(
        markerId: const MarkerId("current"),
        infoWindow: const InfoWindow(
          title: "Pickup Location",
        ),
        position: LatLng(loc.latitude!, loc.longitude!),
      );
      if (!mounted) return;
      context.read<AppMap>().moveMap(loc.latitude!, loc.longitude!);
      context.read<AppMap>().addMarker(marker);
      if (context.read<AppMap>().isWorker) {
        context
            .read<LocationProvider>()
            .setDataforWorker("Worker", loc.latitude!, loc.longitude!);
      } else {
        context
            .read<LocationProvider>()
            .setDataforClient("Worker", loc.latitude!, loc.longitude!);
      }
      context.read<LocationProvider>().setControllerText("Your Location");
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController locationController = TextEditingController();
    GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        key: scaffoldState,
        body: Stack(
          children: [
            Consumer<AppMap>(builder: (context, appMap, _) {
              return GoogleMap(
                scrollGesturesEnabled: true,
                zoomControlsEnabled: false,
                mapType: MapType.normal,
                initialCameraPosition: _kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  if (context.read<AppMap>().controller.isCompleted) return;
                  context.read<AppMap>().controller.complete(controller);
                  //log("map created");

                  // _controller.complete(controller);
                },
                // onTap: (argument) {
                //   final marker = Marker(
                //     markerId: const MarkerId("current"),
                //     infoWindow: const InfoWindow(
                //       title: "Pickup Location",
                //     ),
                //     position: LatLng(argument.latitude, argument.longitude),
                //   );
                //   // if (!mounted) {
                //   //   log("not Mounted");
                //   //   return;
                //   // }
                //   context.read<AppMap>().addMarker(marker);
                //   //log("${context.read<AppMap>().markers}");
                //   //setState(() {});
                // },
                markers: context.read<AppMap>().markers.values.toSet(),
              );
            }),
            Consumer<AppMap>(
              builder: (context, value, _) {
                return context.read<AppMap>().isWorker
                    ? const WorkerMapOverlay()
                    : const MapOverlay();
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            scaffoldState.currentState!.openDrawer();
          },
          backgroundColor: const Color.fromARGB(242, 245, 119, 35),
          child: const Icon(Icons.menu),
        ),
        drawer: const drawer(),
      ),
    );
  }

  // Future<void> _goToTheLake() async {
  //   final GoogleMapController controller = await _controller.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  // }
}
