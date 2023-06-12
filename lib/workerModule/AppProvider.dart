import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class AppProvider with ChangeNotifier {
  List<String> removeIds = [];
  Stream<QuerySnapshot<Map<String, dynamic>>>? snapShot;
  List<DocumentSnapshot<Map<String, dynamic>>> documents = [];

  void removeIs(String id) {
    removeIds.add(id);
    notifyListeners();
  }

  attachSnapshot(Stream<QuerySnapshot<Map<String, dynamic>>> snap) {
    snapShot = snap;
    notifyListeners();
  }

  addDocument(DocumentSnapshot<Map<String, dynamic>> doc) {
    documents.add(doc);
    notifyListeners();
  }

  removeDocument(String doc) {
    documents.removeWhere((element) => element.id == doc);
    notifyListeners();
  }
}
