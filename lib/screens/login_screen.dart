import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:fluttertoast/fluttertoast.dart';

import 'package:ndialog/ndialog.dart';
import 'package:pakistan_solar_market/constant/colors.dart';
import 'package:pakistan_solar_market/screens/bottom_nav.dart';
import 'package:pakistan_solar_market/screens/register_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phonecontroller = TextEditingController(text: '+92');
  TextEditingController otpController = TextEditingController();
  String verificationId = '';
  final TextEditingController fullNameController = TextEditingController();

  final DatabaseReference _userRef =
      FirebaseDatabase.instance.reference().child('users');

  Future<void> login() async {
    try {
      String fullName = fullNameController.text.trim();
      String phone = phonecontroller.text.trim();

      DatabaseEvent snapshot =
          await _userRef.orderByChild('phone').equalTo(phone).once();

      if (snapshot.snapshot.value != null) {
        // User already exists, navigate to BottomNavScreen
        Fluttertoast.showToast(msg: 'Login SuccessFull');
        Future.delayed(Duration(seconds: 2), () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BottomNavScreen(initialIndex: 0)));
        });
      } else {
        Fluttertoast.showToast(
            msg: 'Phone Number does not exists, Please Register');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => RegisterScreen()));
      }
    } catch (e) {
      print('Error during sign up: $e');
      Fluttertoast.showToast(msg: 'Register Failed');
    }
  }

  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> verifyPhone(BuildContext context) async {
    ProgressDialog progressDialog = ProgressDialog(
      context,
      title: const Text(
        'Sending OTP',
        style: TextStyle(color: Colors.black),
      ),
      message: const Text(
        'Please wait',
        style: TextStyle(color: Colors.black),
      ),
      backgroundColor: Colors.white,
    );

    try {
      progressDialog.show();

      await Future.delayed(Duration(seconds: 5));

      progressDialog.dismiss();

      await _auth.verifyPhoneNumber(
        phoneNumber: phonecontroller.text,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Your existing code here
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String verificationId, int? resendToken) {
          setState(() {
            this.verificationId = verificationId;
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      print('Error during phone verification: $e');
      progressDialog.dismiss(); // Dismiss the dialog in case of an error
    }
  }

  void signInWithPhoneAuthCredential(BuildContext context) async {
    ProgressDialog progressDialog = ProgressDialog(
      context,
      title: const Text(
        'Login',
        style: TextStyle(color: Colors.black),
      ),
      message: const Text(
        'Please wait',
        style: TextStyle(color: Colors.black),
      ),
      backgroundColor: Colors.white,
    );

    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: otpController.text,
    );

    try {
      progressDialog.show();
      await _auth.signInWithCredential(credential);
      progressDialog.dismiss();
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            width: double.infinity,
            height: MediaQuery.sizeOf(context).height,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      "assets/images/psm.png",
                    ),
                    fit: BoxFit.cover)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 30, bottom: 100),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        BottomNavScreen(initialIndex: 0)));
                          },
                          child: Text(
                            "Skip",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              decoration: TextDecoration.underline,
                            ),
                          ))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: Text(
                    "Login",
                    style: TextStyle(
                        color: black,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, right: 15, bottom: 50),
                  child: Container(
                    height: 55,
                    child: TextFormField(
                      controller: phonecontroller,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          hintText: 'Enter your phone number',
                          border: OutlineInputBorder(),
                          suffixIcon: TextButton(
                            onPressed: () => verifyPhone(context),
                            child: Text(
                              "Send OTP",
                              style: TextStyle(color: primaryColor),
                            ),
                          )),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, right: 15, bottom: 40),
                  child: Container(
                    height: 55,
                    child: TextFormField(
                      controller: otpController,
                      decoration: InputDecoration(
                        hintText: "Enter Your OTP",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 330,
                  height: 40,
                  child: MaterialButton(
                    color: primaryColor,
                    onPressed: () {
                      signInWithPhoneAuthCredential(context);
                      login();
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "OR",
                  style: TextStyle(
                      color: black, fontWeight: FontWeight.bold, fontSize: 25),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterScreen()));
                    },
                    child: Text(
                      "Register",
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
