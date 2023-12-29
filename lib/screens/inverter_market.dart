import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'login_screen.dart';

class InverterMarket extends StatefulWidget {
  final String? selectedCategory;
  const InverterMarket({super.key,   this.selectedCategory});

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

          // Sort the fetchedData based on 'Price' field
          fetchedData.sort((a, b) {
            var priceA = double.tryParse(a['Price'] ?? '0');
            var priceB = double.tryParse(b['Price'] ?? '0');

            // Check if prices are equal to 45.0
            bool isPriceAEqualTo45 = (priceA != null && priceA == 45.0);
            bool isPriceBEqualTo45 = (priceB != null && priceB == 45.0);

            if (isPriceAEqualTo45 && !isPriceBEqualTo45) {
              return -1; // Put 'Price' equal to 45.0 above others
            } else if (!isPriceAEqualTo45 && isPriceBEqualTo45) {
              return 1; // Put 'Price' equal to 45.0 above others
            } else if (priceA != null && priceB != null) {
              return priceA.compareTo(priceB);
            }
            return 0; // If parsing fails or prices are equal, maintain the current order
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
          // Sort the fetchedData based on 'Price' field
          fetchedData.sort((a, b) {
            var priceA = double.tryParse(a['Price'] ?? '0');
            var priceB = double.tryParse(b['Price'] ?? '0');

            // Check if prices are equal to 45.0
            bool isPriceAEqualTo45 = (priceA != null && priceA == 45.0);
            bool isPriceBEqualTo45 = (priceB != null && priceB == 45.0);

            if (isPriceAEqualTo45 && !isPriceBEqualTo45) {
              return -1; // Put 'Price' equal to 45.0 above others
            } else if (!isPriceAEqualTo45 && isPriceBEqualTo45) {
              return 1; // Put 'Price' equal to 45.0 above others
            } else if (priceA != null && priceB != null) {
              return priceA.compareTo(priceB);
            }
            return 0; // If parsing fails or prices are equal, maintain the current order
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

          // Sort the fetchedData based on 'Price' field
          fetchedData.sort((a, b) {
            var priceA = double.tryParse(a['Price'] ?? '0');
            var priceB = double.tryParse(b['Price'] ?? '0');

            // Check if prices are equal to 45.0
            bool isPriceAEqualTo45 = (priceA != null && priceA == 45.0);
            bool isPriceBEqualTo45 = (priceB != null && priceB == 45.0);

            if (isPriceAEqualTo45 && !isPriceBEqualTo45) {
              return -1; // Put 'Price' equal to 45.0 above others
            } else if (!isPriceAEqualTo45 && isPriceBEqualTo45) {
              return 1; // Put 'Price' equal to 45.0 above others
            } else if (priceA != null && priceB != null) {
              return priceA.compareTo(priceB);
            }
            return 0; // If parsing fails or prices are equal, maintain the current order
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

          // Sort the fetchedData based on 'Price' field
          fetchedData.sort((a, b) {
            var priceA = double.tryParse(a['Price'] ?? '0');
            var priceB = double.tryParse(b['Price'] ?? '0');

            // Check if prices are equal to 45.0
            bool isPriceAEqualTo45 = (priceA != null && priceA == 45.0);
            bool isPriceBEqualTo45 = (priceB != null && priceB == 45.0);

            if (isPriceAEqualTo45 && !isPriceBEqualTo45) {
              return -1; // Put 'Price' equal to 45.0 above others
            } else if (!isPriceAEqualTo45 && isPriceBEqualTo45) {
              return 1; // Put 'Price' equal to 45.0 above others
            } else if (priceA != null && priceB != null) {
              return priceA.compareTo(priceB);
            }
            return 0; // If parsing fails or prices are equal, maintain the current order
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
    //  getAllUserData();
    _fetchData();

    _tabController = TabController(length: 4, vsync: this);

    // Listen to changes on _tabController to set the initial index
    _tabController.addListener(_handleTabSelection);

    // Check if selectedCategory has a value and set the initial index accordingly
    if (widget.selectedCategory != null) {
      print("THis is working");
      _setInitialIndex(widget.selectedCategory!);
    }
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      // Tab index is changing, handle the selection change
      switch (_tabController.index) {
        case 0:
        // Logic or actions when the 'Longi' tab is selected
          break;
        case 1:
        // Logic or actions when the 'Jinko' tab is selected
          break;
        case 2:
        // Logic or actions when the 'JA' tab is selected
          break;
        case 3:
        // Logic or actions when the 'Canadian' tab is selected
          break;
        default:
          break;
      }
    }
  }





  // Set initial index based on the selectedCategory value
  void _setInitialIndex(String selectedCategory) {
    switch (selectedCategory) {
      case "Longi":
        _tabController.index = 0;

        break;
      case "Jinko":
        _tabController.index = 1;
        break;
      case "JA":
        _tabController.index = 2;
        break;
      case "Canadian":
        _tabController.index = 3;
        break;
      default:
        _tabController.index = 0; // Default tab
        break;
    }
  }


  // Future<void> getAllUserData() async {
  //   DatabaseReference _userRef =
  //       FirebaseDatabase.instance.reference().child('users');
  //
  //   DatabaseEvent dataSnapshot = await _userRef.once();
  //
  //   if (dataSnapshot.snapshot.value != null) {
  //     Map<dynamic, dynamic> users = dataSnapshot.snapshot.value as Map;
  //
  //     users.forEach((key, value) {
  //       var fullName = value['fullName'];
  //
  //     });
  //   } else {
  //     print('No data found');
  //   }
  // }

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
                  width: screenWidth! * .5,
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
                            'RS ${price!}',
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
                    buildCategoryList(userData, context),
                    buildCategoryList2(userData2, context),
                    buildCategoryList3(userData3, context),
                    buildCategoryList4(userData4, context)
                  ],
                ))
          ],
        ),
      ),
    );
  }

  buildCategoryList(List<dynamic> categories, BuildContext context) {
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
              Map<String, dynamic> longiData = categories[index];

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  height: screenHeight * 0.12,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(screenWidth * 0.020),
                          child: Column(
                            children: [
                              Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  Container(
                                    width: screenWidth * 0.11,
                                    height: screenWidth * 0.11,
                                    decoration: BoxDecoration(
                                      color: Colors.pinkAccent,
                                      borderRadius:
                                      BorderRadius.circular(50),
                                    ),
                                    child: Icon(
                                      Icons.person,
                                      size: screenHeight * 0.04,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Container(
                                    child: Icon(
                                      Icons.verified_rounded,
                                      color: Colors.blue,
                                      size: screenWidth * 0.05,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: screenHeight * 0.01),
                              InkWell(
                                onTap: () {
                                  dialogeBox(context, longiData["phone"]);
                                },
                                child: Text(
                                  longiData['fullName'] ??
                                      longiData['fullName'],
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: screenHeight * 0.018,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Text(
                                longiData['SubCategories'] ?? 'NA',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Text(
                                longiData['Location'] ?? 'NA',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 11,
                                ),
                              ),
                              Text(
                                longiData['Type'] ?? 'N/A',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "  ${longiData['Number']} ${longiData['Size'] ?? 'NA'}",
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 12),
                              ),
                              Text(
                                longiData['Available'] ?? 'NA',
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8, right: 10),
                          child: Column(
                            children: [
                              Text(
                                "RS",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                longiData['Price'] ?? 'NA',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => Divider(),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    )
        : Center(child: CircularProgressIndicator());
  }

  buildCategoryList2(List<dynamic> categories, BuildContext context) {
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
              Map<String, dynamic> jinkoData = categories[index];

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  height: screenHeight * 0.12,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(screenWidth * 0.020),
                          child: Column(
                            children: [
                              Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  Container(
                                    width: screenWidth * 0.11,
                                    height: screenWidth * 0.11,
                                    decoration: BoxDecoration(
                                      color: Colors.pinkAccent,
                                      borderRadius:
                                      BorderRadius.circular(50),
                                    ),
                                    child: Icon(
                                      Icons.person,
                                      size: screenHeight * 0.04,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Container(
                                    child: Icon(
                                      Icons.verified_rounded,
                                      color: Colors.blue,
                                      size: screenWidth * 0.05,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: screenHeight * 0.01),
                              InkWell(
                                onTap: () {
                                  dialogeBox(context, jinkoData['phone']);
                                },
                                child: Text(
                                  jinkoData['fullName'],
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: screenHeight * 0.018,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Text(
                                jinkoData['SubCategories'] ?? 'NA',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Text(
                                jinkoData['Location'] ?? 'NA',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 11,
                                ),
                              ),
                              Text(
                                jinkoData['Type'] ?? 'N/A',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "  ${jinkoData['Number']} ${jinkoData['Size'] ?? 'NA'}",
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 12),
                              ),
                              Text(
                                jinkoData['Available'] ?? 'NA',
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8, right: 10),
                          child: Column(
                            children: [
                              Text(
                                "RS",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                jinkoData['Price'] ?? 'NA',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => Divider(),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    )
        : Center(child: CircularProgressIndicator());
  }

  buildCategoryList3(List<dynamic> categories, BuildContext context) {
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
              Map<String, dynamic> JaData = categories[index];

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  height: screenHeight * 0.12,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(screenWidth * 0.020),
                          child: Column(
                            children: [
                              Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  Container(
                                    width: screenWidth * 0.11,
                                    height: screenWidth * 0.11,
                                    decoration: BoxDecoration(
                                      color: Colors.pinkAccent,
                                      borderRadius:
                                      BorderRadius.circular(50),
                                    ),
                                    child: Icon(
                                      Icons.person,
                                      size: screenHeight * 0.04,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Container(
                                    child: Icon(
                                      Icons.verified_rounded,
                                      color: Colors.blue,
                                      size: screenWidth * 0.05,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: screenHeight * 0.01),
                              InkWell(
                                onTap: () {
                                  dialogeBox(context, JaData['phone']);
                                },
                                child: Text(
                                  JaData['fullName'],
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: screenHeight * 0.018,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Text(
                                JaData['SubCategories'] ?? 'NA',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Text(
                                JaData['Location'] ?? 'NA',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 11,
                                ),
                              ),
                              Text(
                                JaData['Type'] ?? 'N/A',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "  ${JaData['Number']} ${JaData['Size'] ?? 'NA'}",
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 12),
                              ),
                              Text(
                                JaData['Available'] ?? 'NA',
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8, right: 10),
                          child: Column(
                            children: [
                              Text(
                                "RS",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                JaData['Price'] ?? 'NA',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => Divider(),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    )
        : Center(child: CircularProgressIndicator());
  }

  buildCategoryList4(List<dynamic> categories, BuildContext context) {
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
              Map<String, dynamic> CaData = categories[index];

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  height: screenHeight * 0.12,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(screenWidth * 0.020),
                          child: Column(
                            children: [
                              Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  Container(
                                    width: screenWidth * 0.11,
                                    height: screenWidth * 0.11,
                                    decoration: BoxDecoration(
                                      color: Colors.pinkAccent,
                                      borderRadius:
                                      BorderRadius.circular(50),
                                    ),
                                    child: Icon(
                                      Icons.person,
                                      size: screenHeight * 0.04,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Container(
                                    child: Icon(
                                      Icons.verified_rounded,
                                      color: Colors.blue,
                                      size: screenWidth * 0.05,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: screenHeight * 0.01),
                              InkWell(
                                onTap: () {
                                  dialogeBox(context, CaData['phone']);
                                },
                                child: Text(
                                  CaData['fullName'],
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: screenHeight * 0.018,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Text(
                                CaData['SubCategories'] ?? 'NA',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Text(
                                CaData['Location'] ?? 'NA',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 11,
                                ),
                              ),
                              Text(
                                CaData['Type'] ?? 'N/A',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "  ${CaData['Number']} ${CaData['Size'] ?? 'NA'}",
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 12),
                              ),
                              Text(
                                CaData['Available'] ?? 'NA',
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8, right: 10),
                          child: Column(
                            children: [
                              Text(
                                "RS",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                CaData['Price'] ?? 'NA',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => Divider(),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    )
        : Center(child: CircularProgressIndicator());
  }

  void dialogeBox(BuildContext context, String data) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.white60,
        title: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              data.toString(),
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
