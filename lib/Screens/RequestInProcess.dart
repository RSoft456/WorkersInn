import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:workers_inn/Screens/AppMapProcess.dart';
import 'package:workers_inn/Screens/map_provider.dart';
import 'package:workers_inn/workerModule/RequestInProcessOverlayWorker.dart';

import 'RequestInProcesOverlay.dart';

class RequestInProgress extends StatefulWidget {
  const RequestInProgress({super.key});

  @override
  State<RequestInProgress> createState() => _RequestInProgressState();
}

class _RequestInProgressState extends State<RequestInProgress> {
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
  Widget build(BuildContext context) {
    TextEditingController locationController = TextEditingController();
    // GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        //  floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        //  key: scaffoldState,
        body: Stack(
          children: [
            Consumer<AppMapProcess>(builder: (context, appMap, _) {
              return GoogleMap(
                scrollGesturesEnabled: true,
                zoomControlsEnabled: false,
                mapType: MapType.normal,
                initialCameraPosition: _kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  if (context.read<AppMapProcess>().controller.isCompleted)
                    return;
                  context.read<AppMapProcess>().controller.complete(controller);
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
                markers: context.read<AppMapProcess>().markers.values.toSet(),
              );
            }),
            Consumer<AppMapProcess>(
              builder: (context, value, _) {
                return context.read<AppMap>().isWorker
                    ? const RequestInProcessOverlayWorker()
                    : const RequestInProcesOverlay();
              },
            ),
          ],
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     openDialPad("03456478564");
        //   },
        //   backgroundColor: const Color.fromARGB(242, 245, 119, 35),
        //   child: const Icon(Icons.call),
        // ),
        //drawer: const drawer(),
      ),
    );
  }
}
