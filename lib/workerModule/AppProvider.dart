import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class AppProvider with ChangeNotifier {
  //List<String> removeIds = [];
  Stream<QuerySnapshot<Map<String, dynamic>>>? snapShot;
  Stream<DocumentSnapshot<Map<String, dynamic>>>? clientSnaphot;
  List<DocumentSnapshot<Map<String, dynamic>>> documents = [];
  List<String> workersList = [];
  String orderId = "";
  // void removeIs(String id) {
  //   removeIds.add(id);
  //   notifyListeners();
  // }

  assignOrderId(String orderId) {
    this.orderId = orderId;
  }

  attachSnapshot(Stream<QuerySnapshot<Map<String, dynamic>>> snap) {
    snapShot = snap;
    notifyListeners();
  }

  attachClientsnapshot(Stream<DocumentSnapshot<Map<String, dynamic>>> snap) {
    clientSnaphot = snap;
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

  addWorkers(String worker) {
    workersList.add(worker);
  }

  removeWorker(String id) {
    workersList.removeWhere((element) => element == id);
    notifyListeners();
  }
}
