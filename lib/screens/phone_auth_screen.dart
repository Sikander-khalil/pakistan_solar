import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';

import 'package:pakistan_solar_market/screens/bottom_nav.dart';

class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({super.key});

  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _otpController = TextEditingController();

  String verificationId = '';

  Future<void> verifyPhone() async {
    await _auth.verifyPhoneNumber(
      phoneNumber: _phoneNumberController.text,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
        print(
            'Phone number automatically verified: ${_auth.currentUser!.phoneNumber}');
      },
      verificationFailed: (FirebaseAuthException e) {
        print('Phone number verification failed: ${e.message}');
      },
      codeSent: (String verificationId, int? resendToken) {
        setState(() {
          this.verificationId = verificationId;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        setState(() {
          this.verificationId = verificationId;
        });
      },
    );
  }

  Future<void> verifyOTP() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: _otpController.text,
    );
    ProgressDialog progressDialog = ProgressDialog(
      context,
      title: const Text('Verify Otp'),
      message: const Text('Please wait'),
    );

    progressDialog.show();
    try {
      await _auth.signInWithCredential(credential);

      progressDialog.dismiss();

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Otp is sucessfull")));

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => BottomNavScreen()));

      print(
          'Phone number manually verified: ${_auth.currentUser!.phoneNumber}');
      print('OTP is valid');
    } catch (e) {
      progressDialog.dismiss();
      print('Invalid OTP: ${e.toString()}');
      // Handle invalid OTP
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Phone Auth Example')),
      body: Container(
        width: double.infinity,
        height: MediaQuery.sizeOf(context).height,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/psm.png"), fit: BoxFit.cover),
        ),
        child: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _phoneNumberController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: 'Enter your phone number',
                  ),
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: verifyPhone,
                  child: Text('Send OTP'),
                ),
                SizedBox(height: 20.0),
                TextField(
                  controller: _otpController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: 'Enter Otp',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: verifyOTP,
                  child: Text(
                    "Submit",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
