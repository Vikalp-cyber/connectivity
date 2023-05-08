import 'package:adicine/Screens/addMedicine.dart';
import 'package:adicine/Screens/login.dart';
import 'package:adicine/Screens/signup.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Screens/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLogin = false;

  Future<void> getUser() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? current_user = _auth.currentUser;
    String user = "";
    await FirebaseFirestore.instance
        .collection("users")
        .doc(_auth.currentUser!.uid)
        .get()
        .then((value) {
      setState(() {
        isLogin = value.id != "null";
      });
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: isLogin ? MyHomePage() : LoginPage(),
    );
  }
}
