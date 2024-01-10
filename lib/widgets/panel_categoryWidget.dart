import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pakistan_solar_market/constant/colors.dart';
import 'package:http/http.dart' as http;
import '../main.dart';
import '../screens/register_screen.dart';

class PanelCategoryWidget {
  static TextEditingController bidController = TextEditingController();
  static Widget buildPriceWidget(String price) {
    double parsedPrice = double.tryParse(price) ?? 0.0;
    String priceText = parsedPrice.toString();
    bool hasDecimal = priceText.contains('.');

    if (hasDecimal) {
      int decimalIndex = priceText.indexOf('.');
      String integerPart = priceText.substring(0, decimalIndex);
      String decimalPart = priceText.substring(decimalIndex + 1);

      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            integerPart,
            style: TextStyle(
              color: Color(0xff05bc64),
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '.$decimalPart',
            style: TextStyle(
              color: Color(0xff05bc64),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
    }

    return Text(
      price,
      style: TextStyle(
        color: Color(0xff05bc64),
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    );
  }
  static buildCategoryList(List<dynamic> categories, BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double screenHeight = screenSize.height;
    double screenWidth = screenSize.width;
    return categories.isNotEmpty
        ? SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> categoriesData = categories[index];

                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: screenWidth * 0.13,
                              height: screenWidth * 0.11,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                              child: ClipOval(
                                child: CachedNetworkImage(
                                  width: 35,
                                  fit: BoxFit.cover,
                                  
                                  imageUrl: categoriesData['image'],
                                  progressIndicatorBuilder: (context,
                                      url, downloadProgress) =>
                                      CircularProgressIndicator(
                                          value: downloadProgress
                                              .progress),
                                  errorWidget:
                                      (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              )
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 0),
                                    child: Text(categoriesData["SubCategories"], style: TextStyle(color: black, fontWeight: FontWeight.bold,fontSize: 15),),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Color(0xff05bc64),
                                              borderRadius:
                                               BorderRadius.circular(5)
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 2, right: 10),
                                            child: Text(
                                                  "  ${categoriesData['Number']} ${categoriesData['Size'] ?? 'NA'}",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 13),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Color(0xff05bc64),
                                              borderRadius:   BorderRadius.circular(5)
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            child: Text(
                                              categoriesData['Location'],
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 13),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Color(0xff05bc64),
                                              borderRadius:   BorderRadius.circular(5)

                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            child: Text(
                                              categoriesData['Available'],
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 13),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5,right: 20),
                              child: buildPriceWidget(
                                "${categoriesData['Price']}",
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                categoriesData['fullName'],
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 0, right: 20, top: 0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Color(0xff05bc64),
                                    borderRadius:   BorderRadius.circular(5)

                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15),
                                  child: Text(
                                    categoriesData['Type'],
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    );
                  },
                  separatorBuilder: (context, index) =>
                      Divider(thickness: 1, color: Colors.black),

                ),

              ],
            ),
          )
        : Center(child: CircularProgressIndicator());
  }

  static dialogeBox(BuildContext context, String data) async {
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    print(fcmToken);
    showDialog(
      context: context,
      builder: (_) => Container(
        width: 700,
        child: AlertDialog(
          backgroundColor: Colors.white,
          title: Center(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 17),
                            child: Container(
                              width: 120,
                              height: 60,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: bidController,
                                decoration: InputDecoration(
                                  hintText: 'Enter Bid',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                          ),
                          MaterialButton(
                            color: primaryColor,
                            onPressed: () {
                              sendBid();
                            },
                            child: Text(
                              "BID",
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      data.toString(),
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                )),
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
                  Fluttertoast.showToast(
                      msg: 'okay Then minutes after call it');
                } else {
                  Fluttertoast.showToast(msg: 'Please Sign Up');
                  Future.delayed(Duration(seconds: 3), () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterScreen(),
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
      ),
    );
  }

  static Future<void> sendBid() async {
    final DatabaseReference _bidRef =
        FirebaseDatabase.instance.reference().child('bidrequest');
    final id = DateTime.now().millisecondsSinceEpoch.toString();

    await _bidRef.child(id).set({'price': bidController.text.trim()});

    try {
      String? fcmToken = await FirebaseMessaging.instance.getToken();
      if (fcmToken != null) {
        print("FCM Token: $fcmToken");

        Map<String, dynamic> notificationData = {
          'notification': {
            'title': 'Bid Request',
            'body': bidController.text.trim(),
          },
          'data': {
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          },
          'to': fcmToken,
        };

        var response = await http.post(
          Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization':
                'key=AAAAUw3t43w:APA91bFwllgOqcjTVr8KGmgoQfLqBFxvgGbIRyvw4uTzNGneF9RmwY0PoutlaNCBPBQAbGVKVjzGurdwIkEDZv82FJP4gd0DT7aYaBOEasogt99DuK06IbbUPN8LZNbYj1i_wGfC5Sq1',
            // Replace with your server key from Firebase Console
          },
          body: jsonEncode(notificationData),
        );

        FirebaseMessaging.onMessage.listen((RemoteMessage message) {});
        print("Notification sent! Response: ${response.body}");
      } else {
        print("FCM Token is null");
        // Handle the case when FCM token is null
      }
    } catch (e) {
      print("Error sending message: $e");
      // Handle any error that occurred while sending the message
    }
  }
}
