import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
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
      String fullName = fullNameController.text.trim();
      String phone = phonecontroller.text.trim();

      DatabaseEvent snapshot =
          await _userRef.orderByChild('phone').equalTo(phone).once();

      if (snapshot.snapshot.value != null) {
        // User already exists, navigate to BottomNavScreen
        Fluttertoast.showToast(
            msg: 'Phone Number is already exists, Use a different Phone no');
      } else {
        // User doesn't exist, proceed with adding to the database
        String id = DateTime.now().millisecondsSinceEpoch.toString();

        String? imageUrl;
        if (_image != null) {
          imageUrl = await uploadImage(_image!);
        } else {
          // Handle if no image is uploaded
          imageUrl =
              ''; // You might want to set a default or handle this case accordingly
        }

        await _userRef.child(id).set({
          'fullName': fullName,
          'phone': phone,
          'image': imageUrl, // Storing image URL in the database
        });

        await _inverteruserRef.child(id).set({
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
        'Register',
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
                Stack(
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
                              color: Colors.black,
                            ),
                            child: Center(
                                child: Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.white,
                            )),
                          ),
                        )),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
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
                SizedBox(height: 15.0),
                Padding(
                  padding: const EdgeInsets.all(15.0),
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
                SizedBox(height: 15.0),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    controller: otpController,
                    decoration: InputDecoration(
                      hintText: "Enter Your OTP",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                MaterialButton(
                  color: primaryColor,
                  onPressed: () {
                    signInWithPhoneAuthCredential(context);
                    signUp();
                  },
                  child: Text(
                    'Register',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
