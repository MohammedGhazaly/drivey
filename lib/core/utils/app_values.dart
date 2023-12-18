import 'package:cloud_firestore/cloud_firestore.dart';

class AppValues {
  static CollectionReference<Map<String, dynamic>> userCollection =
      FirebaseFirestore.instance.collection("users");
}
