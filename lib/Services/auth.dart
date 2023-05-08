import 'package:adicine/Services/fireDb.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthHelper {
  static Future<User?> registerUsingEmailandPassword(
      {required String name,
      required String email,
      required String password}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
      await user!.updateDisplayName(name);
      await user.reload();
      user = auth.currentUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    return user;
  }

  static Future<User?> signInUsingEmailPassword({
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided.');
      }
    }

    return user;
  }
}

final GoogleSignIn googleSignIn = GoogleSignIn();

Future<User?> signInWithGoogle() async {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  try {
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);
    final usercredential = await _auth.signInWithCredential(credential);
    final User? user = usercredential.user;

    assert(!user!.isAnonymous);
    assert(await user!.getIdToken() != null);
    final User? currentUser = await _auth.currentUser;
    assert(currentUser!.uid == user!.uid);
    print(user);
    await FireDb().createNewUser(user!.displayName.toString(),
        user.email.toString(), user.photoURL.toString());
  } catch (e) {
    print("ERROR OCCURED IN SIGNIN");
    print(e);
  }
}
