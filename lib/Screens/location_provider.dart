import 'package:flutter/material.dart';

class Address {
  String? name;
  double? lat;
  double? lng;
}

class LocationProvider with ChangeNotifier {
  TextEditingController controller = TextEditingController();
  Address workerAddess = Address();
  Address clientAddress = Address();
  void setControllerText(String text) {
    controller.text = text;
    notifyListeners();
  }

  void setDataforWorker(String name, double lat, double lng) {
    workerAddess.name = name;
    workerAddess.lat = lat;
    workerAddess.lng = lng;
    notifyListeners();
  }

  void setDataforClient(String name, double lat, double lng) {
    clientAddress.name = name;
    clientAddress.lat = lat;
    clientAddress.lng = lng;
    notifyListeners();
  }
}
