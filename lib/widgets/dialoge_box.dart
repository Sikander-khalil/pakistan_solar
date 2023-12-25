import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pakistan_solar_market/widgets/signup_screen.dart';

class Dialogue {
  static User? user = FirebaseAuth.instance.currentUser;

  static void dialogeBox(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              backgroundColor: Colors.white60,
              title: Center(
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "03226155609",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      ))),
              content: DecoratedBox(
                decoration: BoxDecoration(
                    color: Color(0xff18be88),
                    border: Border.all(color: Colors.black38, width: 3),
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: <BoxShadow>[
                      //apply shadow on Dropdown button
                      BoxShadow(
                          color:
                              Color.fromRGBO(0, 0, 0, 0.57), //shadow for button
                          blurRadius: 5) //blur radius of shadow
                    ]),
                child: MaterialButton(
                  onPressed: () {
                    if (user != null) {
                      Fluttertoast.showToast(
                          msg: 'okay Then minutes after call it');
                    } else {
                      Fluttertoast.showToast(msg: 'Please Sign Up');
                      Future.delayed(Duration(seconds: 3), () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpScreen()));
                      });
                    }
                  },
                  child: Text(
                    "Call Now",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ));
  }
}
