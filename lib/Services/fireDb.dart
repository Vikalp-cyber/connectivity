import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

class FireDb {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  createNewUser(String name, String email, String photoUrl) async {
    final User? current_user = _auth.currentUser;
    if (await getUser()) {
      print("User Already Exists");
    } else {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(current_user!.uid)
          .set({
        "name": name,
        "email": email,
        "photoUrl": photoUrl,
      }).then(
        (value) async {
          print("User Registered Successfully");
        },
      );
    }
  }
}

Future<bool> getUser() async {
  final User? current_user = _auth.currentUser;
  String user = "";
  await FirebaseFirestore.instance
      .collection("users")
      .doc(current_user!.uid)
      .get()
      .then((value) async {
    user = value.data().toString();
  });
  if (user.toString() == "null") {
    return false;
  } else {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(current_user.uid)
        .get()
        .then((value) async {
      user = value.toString();
    });
    return true;
  }
}
