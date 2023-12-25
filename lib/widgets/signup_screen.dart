import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ndialog/ndialog.dart';
import 'package:pakistan_solar_market/screens/phone_auth_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var fullNameController = TextEditingController();

  var phoneController = TextEditingController();

  ImagePicker picker = ImagePicker();

  File? _image;

  String? image;

  Future<void> storeUserData(String fullName, String phone) async {
    try {
      DatabaseReference userRef =
          FirebaseDatabase.instance.reference().child('users');
      String userId = FirebaseAuth.instance.currentUser!.uid;

      await userRef.child(userId).set({
        'fullName': fullName,
        'phone': phone,
      });
    } catch (e) {
      print("Error storing user data: $e");
      throw e;
    }
  }

  Future<bool> checkIfPhoneNumberExists(String phoneNumber) async {
    try {
      DatabaseEvent snapshot = await FirebaseDatabase.instance
          .reference()
          .child('users')
          .orderByChild('phone')
          .equalTo(phoneNumber)
          .once();
      return snapshot.snapshot.value != null;
    } catch (e) {
      print("Error checking phone number existence: $e");
      return false;
    }
  }

  String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter your name';
    }
    return null;
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter your email';
    }
    return null;
  }

  String? passValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter your password';
    } else if (value.length < 6) {
      return 'Enter your 6 password length';
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: MediaQuery.sizeOf(context).height,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/psm.png"), fit: BoxFit.cover),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                    height: 20,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      controller: fullNameController,
                      decoration: const InputDecoration(
                        hintText: 'FullName',
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
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: phoneController,
                      decoration: const InputDecoration(
                        hintText: 'Phone Number',
                        border: OutlineInputBorder(),
                      ),
                      validator: phoneValidator,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MaterialButton(
                    color: Color(0xff18be88),
                    onPressed: () async {
                      var fullName = fullNameController.text.trim();
                      var phone = phoneController.text.trim();

                      if (fullName.isEmpty || phone.isEmpty) {
                        Fluttertoast.showToast(msg: 'Please fill all fields');
                        return;
                      }

                      bool phoneNumberExists =
                          await checkIfPhoneNumberExists(phone);

                      if (phoneNumberExists) {
                        Fluttertoast.showToast(
                            msg: 'Phone number already exists');
                        return;
                      }

                      ProgressDialog progressDialog = ProgressDialog(
                        context,
                        title: const Text('Signing Up'),
                        message: const Text('Please wait'),
                      );

                      progressDialog.show();

                      try {
                        await storeUserData(fullName, phone);
                        progressDialog.dismiss();
                        Fluttertoast.showToast(msg: 'Success');

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PhoneAuthScreen()));
                      } catch (e) {
                        progressDialog.dismiss();
                        Fluttertoast.showToast(msg: e.toString());
                      }
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
