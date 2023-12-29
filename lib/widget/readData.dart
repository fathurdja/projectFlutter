import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _document = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _document.collection("lapangan");
final CollectionReference requestCollection =
    _document.collection("requestlist");
    final CollectionReference nameCollection =
    _document.collection("account");

class Database {
  static Stream<QuerySnapshot> readData() {
    CollectionReference datalapangan = _mainCollection;
    return datalapangan.snapshots();
  }

  static Stream<QuerySnapshot> readDataRequest() {
    CollectionReference dataRequest = requestCollection;
    return dataRequest.snapshots();
  }
    static Stream<QuerySnapshot> fetchdata() {
    CollectionReference dataRequest = nameCollection;
    return dataRequest.snapshots();
  }
}
