import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ndialog/ndialog.dart';
import 'package:pakistan_solar_market/constant/colors.dart';
import 'package:pakistan_solar_market/screens/bottom_nav.dart';
import 'package:pakistan_solar_market/screens/login_screen.dart';


class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController phonecontroller = TextEditingController(text: '+92');
  TextEditingController otpController = TextEditingController();
  String verificationId = '';

  final TextEditingController fullNameController = TextEditingController();

  final DatabaseReference _userRef =
      FirebaseDatabase.instance.reference().child('users');

  final DatabaseReference _inverteruserRef =
      FirebaseDatabase.instance.reference().child('usersinverter');

  ImagePicker picker = ImagePicker();

  File? _image;

  String? image;

  Future<String?> uploadImage(var imageFile) async {
    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('images');
    Reference referenceImageToUpload =
        referenceDirImages.child('$uniqueFileName.jpg');
    UploadTask uploadTask = referenceImageToUpload.putFile(imageFile);
    try {
      await uploadTask.whenComplete(() async {
        image = await referenceImageToUpload.getDownloadURL();
        print(image);
      });
      return image.toString();
    } catch (onError) {
      print("Error: $onError");
      return null;
    }
  }

  Future pickImageGallery() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print("'no Image picked");
      }
    });
  }

  String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter your name';
    }
    return null;
  }

  String? phoneValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter your phone number';
    } else if (value.length != 11) {
      return 'Mobile Number must be 11 digits';
    }
    return null;
  }

  Future<void> signUp() async {
    try {

      String? fcmtoken = await FirebaseMessaging.instance.getToken();
      String fullName = fullNameController.text.trim();
      String phone = phonecontroller.text.trim();

      DatabaseEvent snapshot =
          await _userRef.orderByChild('phone').equalTo(phone).once();

      if (snapshot.snapshot.value != null) {

        Fluttertoast.showToast(
            msg: 'Phone Number is already exists, Use a different Phone no');
      } else {

        String date = DateTime.now().millisecondsSinceEpoch.toString();

        String? imageUrl;
        if (_image != null) {
          imageUrl = await uploadImage(_image!);
        } else {

          imageUrl =
              '';
        }

        await _userRef.child(date).set({

          'id': date,
           'token': fcmtoken,
          'fullName': fullName,
          'phone': phone,
          'image': imageUrl,
        });

        await _inverteruserRef.child(date).set({

          'id': date,
          'token': fcmtoken,
          'fullName': fullName,
          'phone': phone,
          'image': imageUrl, // Storing image URL in the database
        });

        Fluttertoast.showToast(msg: 'Register Successful');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
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
      title:  Text(
        'Sending OTP',
        style: TextStyle(color: black),
      ),
      message:  Text(
        'Please wait',
        style: TextStyle(color: black),
      ),
      backgroundColor: white,
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
      title:  Text(
        'Register',
        style: TextStyle(color: black),
      ),
      message:  Text(
        'Please wait',
        style: TextStyle(color: black),
      ),
      backgroundColor: white,
    );

    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: otpController.text,
    );

    try {
      progressDialog.show();
      await _auth.signInWithCredential(credential);
      progressDialog.dismiss();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
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
                              color: black,
                              fontSize: 18,
                              decoration: TextDecoration.underline,
                            ),
                          ))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 65,
                        child: ClipOval(
                          child: _image != null
                              ? Container(
                                  width: 150,
                                  height: 150,
                                  child: Image.file(
                                    _image!,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Image.asset("assets/images/logo.png",
                                  fit: BoxFit.cover),
                        ),
                      ),
                      Positioned(
                          right: 0,
                          bottom: 0,
                          child: InkWell(
                            onTap: () {
                              pickImageGallery();
                            },
                            child: Container(
                              height: 36,
                              width: 36,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: black,
                              ),
                              child: Center(
                                  child: Icon(
                                Icons.camera_alt_outlined,
                                color: white,
                              )),
                            ),
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    height: 50,
                    child: TextFormField(
                      controller: fullNameController,
                      decoration: InputDecoration(
                        hintText: 'Full Name',
                        border: OutlineInputBorder(),
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r"[a-zA-Z]+|\s"),
                        )
                      ],
                      validator: nameValidator,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    height: 50,
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
                      validator: phoneValidator,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    height: 50,
                    child: TextFormField(
                      controller: otpController,
                      decoration: InputDecoration(
                        hintText: "Enter Your OTP",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  width: 330,
                  height: 40,
                  child: MaterialButton(
                    color: primaryColor,
                    onPressed: () {
                      signInWithPhoneAuthCredential(context);
                      signUp();
                    },
                    child: Text(
                      'Register',
                      style: TextStyle(color: white, fontSize: 16),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "OR",
                  style: TextStyle(
                      color: black, fontWeight: FontWeight.bold, fontSize: 25),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
