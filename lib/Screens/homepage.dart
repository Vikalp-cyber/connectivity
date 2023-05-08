import 'dart:async';

import 'package:adicine/Screens/addMedicine.dart';
import 'package:adicine/Screens/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;

  @override
  void initState() {
    getConnectivity();
    super.initState();
  }

  getConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen(
        (ConnectivityResult result) async {
          isDeviceConnected = await InternetConnectionChecker().hasConnection;
          if (!isDeviceConnected && isAlertSet == false) {
            showDialogBox();
            setState(() => isAlertSet = true);
          }
        },
      );
  showDialogBox() => showCupertinoDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('No Connection'),
          content: const Text('Please check your internet connectivity'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.pop(context, 'Cancel');
                setState(() => isAlertSet = false);
                isDeviceConnected =
                    await InternetConnectionChecker().hasConnection;
                if (!isDeviceConnected && isAlertSet == false) {
                  showDialogBox();
                  setState(() => isAlertSet = true);
                }
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  String name = "Adhicine";
  String proUrl = "Url";
  Future<void> getUserScore() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? current_user = _auth.currentUser;

    await FirebaseFirestore.instance
        .collection("users")
        .doc(_auth.currentUser!.uid)
        .get()
        .then((value) async {
      name = value['name'];
      proUrl = value['photoUrl'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddMedicine(),
              ));
        },
        backgroundColor: Colors.deepPurple,
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "$name",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Text("5 Medicine Left")
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 40),
                  child: Container(
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(proUrl),
                      backgroundColor: Colors.deepPurple,
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(
                thickness: 2,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 60),
              height: 300,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/logo/empty.png"))),
            ),
            Container(
              margin: EdgeInsets.only(top: 30),
              child: Text(
                "Nothing is here. Add a Medicine",
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
