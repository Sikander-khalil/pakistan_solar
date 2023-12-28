import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ndialog/ndialog.dart';
import 'package:pakistan_solar_market/screens/bottom_nav.dart';

import '../widgets/add_post.dart';

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

      String id = DateTime.now().millisecondsSinceEpoch.toString();

      await _userRef.child(id).set({
        'fullName': fullName,
        'phone': phone,
      });

      Fluttertoast.showToast(msg: 'Sign Up Successful');
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => BottomNavScreen()));
      // Navigate to another screen after successful signup
      // Example: Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
    } catch (e) {
      print('Error during sign up: $e');
      Fluttertoast.showToast(msg: 'Sign Up Failed');
    }
  }

  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> verifyPhone(BuildContext context) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phonecontroller.text,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);

        print("Yes done");
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
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => BottomNavScreen()));
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
                  padding: const EdgeInsets.all(8.0),
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
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: phonecontroller,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        hintText: 'Enter your phone number',
                        border: OutlineInputBorder(),
                        suffixIcon: TextButton(
                          onPressed: () => verifyPhone(context),
                          child: Text("Send OTP"),
                        )),
                    validator: phoneValidator,
                  ),
                ),
                SizedBox(height: 15.0),
                Padding(
                  padding: const EdgeInsets.all(8.0),
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
                  color: Colors.red,
                  onPressed: () {
                    signInWithPhoneAuthCredential(context);
                    signUp();
                  },
                  child: Text(
                    'Log In',
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
