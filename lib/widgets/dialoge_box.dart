import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../screens/login_screen.dart';

class Dialogue {
  static User? user = FirebaseAuth.instance.currentUser;
  static String phone = '';

  Future<void> getAllUserData() async {
    DatabaseReference _userRef =
        FirebaseDatabase.instance.reference().child('users');

    DatabaseEvent dataSnapshot = await _userRef.once();

    if (dataSnapshot.snapshot.value != null) {
      Map<dynamic, dynamic> users = dataSnapshot.snapshot.value as Map;

      users.forEach((key, value) {
        var fullName = value['fullName'];
        phone = value['phone'];
        print("This is phone no $phone");
      });
    } else {
      print('No data found');
    }
  }

  static void dialogeBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.white60,
        title: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              phone,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ),
        ),
        content: DecoratedBox(
          decoration: BoxDecoration(
            color: Color(0xff18be88),
            border: Border.all(color: Colors.black38, width: 3),
            borderRadius: BorderRadius.circular(50),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.57),
                blurRadius: 5,
              ),
            ],
          ),
          child: MaterialButton(
            onPressed: () {
              if (user != null) {
                Fluttertoast.showToast(msg: 'okay Then minutes after call it');
              } else {
                Fluttertoast.showToast(msg: 'Please Sign Up');
                Future.delayed(Duration(seconds: 3), () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                  );
                });
              }
            },
            child: Text(
              "Call Now",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
