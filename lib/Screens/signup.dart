import 'dart:ffi';

import 'package:adicine/Screens/homepage.dart';
import 'package:adicine/Screens/login.dart';
import 'package:adicine/Services/auth.dart';
import 'package:adicine/Services/validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _auth = FirebaseAuth.instance;
  String email = "";
  String password = "";
  bool showSpinner = false;
  final _registerFormKey = GlobalKey<FormState>();
  final _nameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Form(
        key: _registerFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 250,
              margin: EdgeInsets.symmetric(horizontal: 50),
              child: Image.asset("assets/logo/Adhicine.png"),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Sign Up",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextFormField(
                controller: _nameTextController,
                cursorColor: Colors.deepPurple,
                validator: (value) => Validator.validateName(name: value),
                cursorHeight: 23,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple),
                  ),
                  hintText: "User Name",
                  prefixIcon: Icon(
                    Icons.person,
                    color: Colors.deepPurple,
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextFormField(
                controller: _emailTextController,
                cursorColor: Colors.deepPurple,
                cursorHeight: 23,
                keyboardType: TextInputType.emailAddress,
                validator: (value) => Validator.validateEmail(email: value),
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple),
                  ),
                  hintText: "User Email",
                  prefixIcon: Icon(
                    Icons.mail,
                    color: Colors.deepPurple,
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextFormField(
                controller: _passwordTextController,
                cursorColor: Colors.deepPurple,
                cursorHeight: 23,
                obscureText: true,
                validator: (value) =>
                    Validator.validatePassword(password: value),
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple)),
                  hintText: "User Password",
                  prefixIcon: Icon(
                    Icons.key,
                    color: Colors.deepPurple,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            showSpinner
                ? Container(
                    margin: EdgeInsets.symmetric(horizontal: 160),
                    child: CircularProgressIndicator(
                      color: Colors.deepPurple,
                    ),
                  )
                : Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    height: 45,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          backgroundColor: Colors.deepPurple.shade400),
                      onPressed: () async {
                        setState(() {
                          showSpinner = true;
                        });
                        if (_registerFormKey.currentState!.validate()) {
                          User? user = await FirebaseAuthHelper
                              .registerUsingEmailandPassword(
                            name: _nameTextController.text,
                            email: _emailTextController.text,
                            password: _passwordTextController.text,
                          );
                          setState(() {
                            showSpinner = false;
                          });
                          if (user != null) {
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) => MyHomePage(),
                              ),
                              (route) => false,
                            );
                          }
                        } else {
                          setState(() {
                            showSpinner = false;
                          });
                        }
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Divider(
                thickness: 2,
              ),
            ),
            InkWell(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Text(
                      "Continue with Google",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an Account ?"),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ));
                      },
                      child: Text(
                        "Sign In",
                        style: TextStyle(color: Colors.deepPurple),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
