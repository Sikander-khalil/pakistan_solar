import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constant/colors.dart';
import 'login_screen.dart';


class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _logout(BuildContext context) async {
    try {
      await _auth.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                LoginScreen()), // Navigate to your login screen
      );
    } catch (e) {
      print('Error during logout: $e');
      // Handle logout failure, if necessary
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 100,),
              Text(
                "Logout Screen",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 100,
              ),
              Container(
                width: double.infinity,
                height: 100,
                child: Card(

                  color: primaryColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Logout",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: InkWell(
                          onTap: () {
                            _logout(context);
                          },
                          child: Icon(
                            Icons.logout,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
