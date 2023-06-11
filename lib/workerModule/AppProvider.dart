import 'package:flutter/cupertino.dart';

class AppProvider with ChangeNotifier {
  List<String> removeIds = [];
  void removeIs(String id) {
    removeIds.add(id);
    notifyListeners();
  }
}
