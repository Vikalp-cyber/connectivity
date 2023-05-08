import 'package:adicine/Screens/homepage.dart';
import 'package:adicine/Screens/signup.dart';
import 'package:adicine/Services/auth.dart';
import 'package:adicine/Services/validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  bool showSpinner = false;
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    User? user = FirebaseAuth.instance.currentUser;

    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: _initializeFirebase(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return SingleChildScrollView(
                  child: Form(
                    key: _formKey,
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
                            "Sign In",
                            style: TextStyle(
                                fontSize: 40, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: TextFormField(
                            validator: (value) =>
                                Validator.validateEmail(email: value),
                            controller: _emailTextController,
                            cursorColor: Colors.deepPurple,
                            cursorHeight: 23,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.deepPurple),
                              ),
                              hintText: "User Email",
                              prefixIcon: Icon(
                                Icons.mail,
                                color: Colors.deepPurple,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: TextFormField(
                            controller: _passwordTextController,
                            validator: (value) =>
                                Validator.validatePassword(password: value),
                            cursorColor: Colors.deepPurple,
                            cursorHeight: 23,
                            obscureText: true,
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.deepPurple)),
                              hintText: "User Password",
                              prefixIcon: Icon(
                                Icons.key,
                                color: Colors.deepPurple,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 220),
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              "Forget Password ?",
                              style: TextStyle(color: Colors.deepPurple),
                            ),
                          ),
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
                                      backgroundColor:
                                          Colors.deepPurple.shade400),
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        showSpinner = true;
                                      });

                                      User? user = await FirebaseAuthHelper
                                          .signInUsingEmailPassword(
                                        email: _emailTextController.text,
                                        password: _passwordTextController.text,
                                      );

                                      setState(() {
                                        showSpinner = false;
                                      });

                                      if (user != null) {
                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                            builder: (context) => MyHomePage(),
                                          ),
                                        );
                                      }
                                    }
                                  },
                                  child: Text(
                                    "Sign In",
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
                          onTap: () async {
                            await signInWithGoogle();
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MyHomePage(),
                                ));
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
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
                              Text("New to Adhicine ?"),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushReplacement(MaterialPageRoute(
                                      builder: (context) => SignUpPage(),
                                    ));
                                  },
                                  child: Text(
                                    "Sign up",
                                    style: TextStyle(color: Colors.deepPurple),
                                  ))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }
              return Center(child: CircularProgressIndicator());
            }));
  }
}
