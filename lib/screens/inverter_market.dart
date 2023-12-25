import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../services/market_service.dart';

class InverterMarket extends StatefulWidget {
  const InverterMarket({super.key});

  @override
  State<InverterMarket> createState() => _InverterMarketState();
}

class _InverterMarketState extends State<InverterMarket>
    with SingleTickerProviderStateMixin {
  User? user = FirebaseAuth.instance.currentUser;
  DatabaseReference _userRef =
      FirebaseDatabase.instance.reference().child('formatDate');
  String? date; // Nullable String
  String? price; // Nullable String
  String? avalaible; // Nullable String

  DatabaseReference _userRef2 =
      FirebaseDatabase.instance.reference().child('users');

  List<Map<String, dynamic>> userData = [];
  List<Map<String, dynamic>> userData2 = [];
  List<Map<String, dynamic>> userData3 = [];
  List<Map<String, dynamic>> userData4 = [];

  void fetchDataForHomeScreen() async {
    try {
      DatabaseEvent snapshot = await _userRef2.once();

      if (snapshot.snapshot.value != null) {
        Map<dynamic, dynamic>? usersData =
            snapshot.snapshot.value as Map<dynamic, dynamic>?;

        if (usersData != null) {
          List<Map<String, dynamic>> fetchedData = [];

          usersData.forEach((key, value) {
            if (value['Longi'] != null &&
                value['Longi'] is Map<dynamic, dynamic>) {
              String fullName = value['fullName'] ?? '';
              String phone = value['phone'] ?? '';

              (value['Longi'] as Map<dynamic, dynamic>)
                  .forEach((longiKey, longiValue) {
                if (longiValue is Map<dynamic, dynamic>) {
                  Map<String, dynamic> longiData = {
                    'fullName': fullName,
                    'phone': phone,
                    'Available': longiValue['Available'] ?? '',
                    'Location': longiValue['Location'] ?? '',
                    'Number': longiValue['Number'] ?? '',
                    'Price': longiValue['Price'] ?? '',
                    'Size': longiValue['Size'] ?? '',
                    'SubCategories': longiValue['SubCategories'] ?? '',
                    'Type': longiValue['Type'] ?? '',
                  };
                  fetchedData.add(longiData);
                }
              });
            }
          });

          setState(() {
            userData = fetchedData;
          });
        }
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void fetchDataForHomeScreen2() async {
    try {
      DatabaseEvent snapshot = await _userRef2.once();

      if (snapshot.snapshot.value != null) {
        Map<dynamic, dynamic>? usersData =
            snapshot.snapshot.value as Map<dynamic, dynamic>?;

        if (usersData != null) {
          List<Map<String, dynamic>> fetchedData = [];

          usersData.forEach((key, value) {
            if (value['Jinko'] != null &&
                value['Jinko'] is Map<dynamic, dynamic>) {
              String fullName = value['fullName'] ?? '';
              String phone = value['phone'] ?? '';

              (value['Jinko'] as Map<dynamic, dynamic>)
                  .forEach((jinkoKey, jinkoValue) {
                if (jinkoValue is Map<dynamic, dynamic>) {
                  Map<String, dynamic> jinkoData = {
                    'fullName': fullName,
                    'phone': phone,
                    'Available': jinkoValue['Available'] ?? '',
                    'Location': jinkoValue['Location'] ?? '',
                    'Number': jinkoValue['Number'] ?? '',
                    'Price': jinkoValue['Price'] ?? '',
                    'Size': jinkoValue['Size'] ?? '',
                    'SubCategories': jinkoValue['SubCategories'] ?? '',
                    'Type': jinkoValue['Type'] ?? '',
                  };
                  fetchedData.add(jinkoData);
                }
              });
            }
          });

          setState(() {
            userData2 = fetchedData;
          });
        }
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void fetchDataForHomeScreen3() async {
    try {
      DatabaseEvent snapshot = await _userRef2.once();

      if (snapshot.snapshot.value != null) {
        Map<dynamic, dynamic>? usersData =
            snapshot.snapshot.value as Map<dynamic, dynamic>?;

        if (usersData != null) {
          List<Map<String, dynamic>> fetchedData = [];

          usersData.forEach((key, value) {
            if (value['JA'] != null && value['JA'] is Map<dynamic, dynamic>) {
              String fullName = value['fullName'] ?? '';
              String phone = value['phone'] ?? '';

              (value['JA'] as Map<dynamic, dynamic>).forEach((jAKey, jAValue) {
                if (jAValue is Map<dynamic, dynamic>) {
                  Map<String, dynamic> jAData = {
                    'fullName': fullName,
                    'phone': phone,
                    'Available': jAValue['Available'] ?? '',
                    'Location': jAValue['Location'] ?? '',
                    'Number': jAValue['Number'] ?? '',
                    'Price': jAValue['Price'] ?? '',
                    'Size': jAValue['Size'] ?? '',
                    'SubCategories': jAValue['SubCategories'] ?? '',
                    'Type': jAValue['Type'] ?? '',
                  };
                  fetchedData.add(jAData);
                }
              });
            }
          });

          setState(() {
            userData3 = fetchedData;
          });
        }
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void fetchDataForHomeScreen4() async {
    try {
      DatabaseEvent snapshot = await _userRef2.once();

      if (snapshot.snapshot.value != null) {
        Map<dynamic, dynamic>? usersData =
            snapshot.snapshot.value as Map<dynamic, dynamic>?;

        if (usersData != null) {
          List<Map<String, dynamic>> fetchedData = [];

          usersData.forEach((key, value) {
            if (value['Canadian'] != null &&
                value['Canadian'] is Map<dynamic, dynamic>) {
              String fullName = value['fullName'] ?? '';
              String phone = value['phone'] ?? '';

              (value['Canadian'] as Map<dynamic, dynamic>)
                  .forEach((canKey, canValue) {
                if (canValue is Map<dynamic, dynamic>) {
                  Map<String, dynamic> canData = {
                    'fullName': fullName,
                    'phone': phone,
                    'Available': canValue['Available'] ?? '',
                    'Location': canValue['Location'] ?? '',
                    'Number': canValue['Number'] ?? '',
                    'Price': canValue['Price'] ?? '',
                    'Size': canValue['Size'] ?? '',
                    'SubCategories': canValue['SubCategories'] ?? '',
                    'Type': canValue['Type'] ?? '',
                  };
                  fetchedData.add(canData);
                }
              });
            }
          });

          setState(() {
            userData4 = fetchedData;
          });
        }
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Size? screenSize;
  double? screenHeight;
  double? screenWidth;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    fetchDataForHomeScreen();
    fetchDataForHomeScreen2();
    fetchDataForHomeScreen3();
    fetchDataForHomeScreen4();
    _fetchData();

    _tabController = TabController(length: 4, vsync: this);
  }

  Future<void> _fetchData() async {
    DatabaseEvent dataSnapshot = await _userRef.once();
    if (dataSnapshot.snapshot.value != null) {
      Map<dynamic, dynamic>? data =
          dataSnapshot.snapshot.value as Map<dynamic, dynamic>?;

      if (data != null) {
        setState(() {
          date = data['Date']?.toString(); // Null check for 'Home Cat' key
          price = data['Price']?.toString(); // Null check for 'Price' key
          avalaible =
              data['Available']?.toString(); // Null check for 'Price' key
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    screenHeight = screenSize!.height;
    screenWidth = screenSize!.width;
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/bismallah.png",
                  fit: BoxFit.cover,
                  height: screenHeight! * .1,
                  width: screenWidth! * .6,
                ),
              ],
            ),
            SizedBox(
              height: 1,
            ),
            Padding(
              padding: EdgeInsets.all(screenWidth! * 0.03),
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(0),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          avalaible != null
                              ? Text(
                                  avalaible!,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                )
                              : Text("available"),
                          date != null
                              ? Text(
                                  date!,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                )
                              : Text("date"),
                          price != null
                              ? Text(
                                  price!,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              : Text("price")
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            TabBar(
              indicatorColor: Color(0xff18be88),
              labelColor: Colors.black,
              dividerColor: Colors.grey,
              tabs: [
                Tab(text: 'Longi'),
                Tab(text: 'Jinko'),
                Tab(text: 'JA'),
                Tab(text: 'Canadian'),
              ],
              controller: _tabController,
            ),
            Expanded(
                child: TabBarView(
              controller: _tabController,
              children: [
                MarketServices.buildCategoryList(userData, context),
                MarketServices.buildCategoryList2(userData2, context),
                MarketServices.buildCategoryList3(userData3, context),
                MarketServices.buildCategoryList4(userData4, context)
              ],
            ))
          ],
        ),
      ),
    );
  }
}
