import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ndialog/ndialog.dart';
import 'package:pakistan_solar_market/constant/colors.dart';
import 'package:pakistan_solar_market/screens/verify_profile_screens.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final phoneAuth = FirebaseAuth.instance.currentUser?.phoneNumber ?? '0';
  String id = '';
  TextEditingController nameController = TextEditingController();
  Map<dynamic, dynamic>? userData; // Variable to store user data
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

  Future<void> fetchUserData() async {
    try {
      DatabaseEvent dataSnapshot = await _userRef.child(id).once();

      if (dataSnapshot.snapshot.value != null &&
          dataSnapshot.snapshot.value is Map<dynamic, dynamic>) {
        Map<dynamic, dynamic> fetchedData =
            dataSnapshot.snapshot.value as Map<dynamic, dynamic>;

        Map<dynamic, dynamic> userDataFound = {};

        fetchedData.forEach((key, value) {
          if (value is Map<dynamic, dynamic>) {
            dynamic userInfo = value;
            id = key;
            if (userInfo['phone'] == phoneAuth) {
              userDataFound = Map<dynamic, dynamic>.from(userInfo);
            }
          }
        });

        // Update the state outside of the loop
        setState(() {
          userData = userDataFound.isNotEmpty ? userDataFound : null;
        });
      } else {
        print('Data is null or not in the expected format');
      }
    } catch (error) {
      print('Error fetching data: $error');
      rethrow; // Rethrow the error for better debugging
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

  Future<void> updateProfile() async {
    ProgressDialog progressDialog = ProgressDialog(
      context,
      title: const Text(
        'Profile image is Updating',
        style: TextStyle(color: Colors.black),
      ),
      message: const Text(
        'Please wait',
        style: TextStyle(color: Colors.black),
      ),
      backgroundColor: Colors.white,
    );
    if (_image != null) {
      // Upload the image to Firebase Storage
      String? imageUrl = await uploadImage(_image!);
      if (imageUrl != null) {
        progressDialog.show();
        // If the image upload was successful, update the user's image URL in the database
        await _userRef.child(id).update(
            {'image': imageUrl, 'fullName': nameController.text.trim()});
        setState(() {
          userData?['image'] =
              imageUrl; // Update the local userData with the new image URL
          userData?['fullName'] = nameController.text.trim();
        });
        progressDialog.dismiss();
        Fluttertoast.showToast(msg: 'Profile image updated successfully!');
        // Show a message or perform actions after successful update
      } else {
        print('Failed to upload image.');
        // Show an error message or handle the error accordingly
      }
    } else {
      print('No image selected.');
      // Show a message to select an image or handle it as needed
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(fontSize: 18),
        ),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => VerifyProfile()));
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Text("Verify Your Profile"),
            ),
          )
        ],
      ),
      body: userData != null
          ? Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 65,
                        child: ClipOval(
                          child: userData != null && _image == null
                              ? Image.network(

                                  userData?['image'],
                                  fit: BoxFit.cover,
                            width: 150.0,
                                )
                              : _image != null
                                  ? Image.file(
                                      _image!,
                                      fit: BoxFit.cover,
                                    )
                                  : SizedBox(), // Placeholder if no image selected or available
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
                                Icons.edit,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: userData?['fullName'],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 330,
                    height: 40,
                    child: MaterialButton(
                        color: primaryColor,
                        onPressed: () {
                          updateProfile();
                        },
                        child: Text(
                          "Update",
                          style: TextStyle(color: white),
                        )),
                  )
                ],
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
