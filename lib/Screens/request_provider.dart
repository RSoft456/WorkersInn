import 'package:flutter/cupertino.dart';

class Request {
  String name;
  String? profileUrl;
  double rating;

  Request(this.name, this.rating, {this.profileUrl = ''});
}

class RequestsList with ChangeNotifier {
  List<Request> requests = [];
  add(Request r) {
    requests.add(r);
    notifyListeners();
  }
}
