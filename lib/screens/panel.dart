import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:pakistan_solar_market/constant/colors.dart';

import 'register_screen.dart';

class PanelMarket extends StatefulWidget {
  final String? selectedCategory;

  const PanelMarket({super.key, this.selectedCategory});

  @override
  State<PanelMarket> createState() => _PanelMarketState();
}

class _PanelMarketState extends State<PanelMarket>
    with SingleTickerProviderStateMixin {
  User? user = FirebaseAuth.instance.currentUser;
  double? marketRatePrice;
  late Timer _timer;
  String currentTime = '';

  void updateTime() {
    setState(() {
      currentTime = _getCurrentTime();
    });

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        currentTime = _getCurrentTime();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer in dispose
    super.dispose();
  }

  String _getCurrentTime() {
    DateTime now = DateTime.now();
    String formattedTime = '${_formatTime(now.hour)}:'
        '${_formatTime(now.minute)}:'
        '${_formatTime(now.second)}';
    return formattedTime;
  }

  String _formatTime(int timeUnit) {
    return timeUnit < 10 ? '0$timeUnit' : '$timeUnit';
  }

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
              String image = value['image'] ?? '';

              (value['Longi'] as Map<dynamic, dynamic>)
                  .forEach((longiKey, longiValue) {
                if (longiValue is Map<dynamic, dynamic>) {
                  Map<String, dynamic> longiData = {
                    'fullName': fullName,
                    'phone': phone,
                    'image': image,
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
              // Compare prices that are not equal to 45.0
              if (!isPriceAEqualTo45 && !isPriceBEqualTo45) {
                return priceA.compareTo(priceB);
              }
            }

            // If parsing fails or prices are equal (including 45.0),
            // maintain the current order
            return 0;
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
              String image = value['image'] ?? '';
              (value['Jinko'] as Map<dynamic, dynamic>)
                  .forEach((jinkoKey, jinkoValue) {
                if (jinkoValue is Map<dynamic, dynamic>) {
                  Map<String, dynamic> jinkoData = {
                    'fullName': fullName,
                    'phone': phone,
                    'image': image,
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
              // Compare prices that are not equal to 45.0
              if (!isPriceAEqualTo45 && !isPriceBEqualTo45) {
                return priceA.compareTo(priceB);
              }
            }

            // If parsing fails or prices are equal (including 45.0),
            // maintain the current order
            return 0;
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
              String image = value['image'] ?? '';
              (value['JA'] as Map<dynamic, dynamic>).forEach((jAKey, jAValue) {
                if (jAValue is Map<dynamic, dynamic>) {
                  Map<String, dynamic> jAData = {
                    'fullName': fullName,
                    'phone': phone,
                    'image': image,
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
              // Compare prices that are not equal to 45.0
              if (!isPriceAEqualTo45 && !isPriceBEqualTo45) {
                return priceA.compareTo(priceB);
              }
            }

            // If parsing fails or prices are equal (including 45.0),
            // maintain the current order
            return 0;
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
              String image = value['image'] ?? '';
              (value['Canadian'] as Map<dynamic, dynamic>)
                  .forEach((canKey, canValue) {
                if (canValue is Map<dynamic, dynamic>) {
                  Map<String, dynamic> canData = {
                    'fullName': fullName,
                    'phone': phone,
                    'image': image,
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
              // Compare prices that are not equal to 45.0
              if (!isPriceAEqualTo45 && !isPriceBEqualTo45) {
                return priceA.compareTo(priceB);
              }
            }

            // If parsing fails or prices are equal (including 45.0),
            // maintain the current order
            return 0;
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

  Future<void> getMarketRate() async {
    DatabaseReference marketDataRef = FirebaseDatabase.instance
        .reference()
        .child('marketPrice')
        .child("Rate");
    DatabaseEvent snapshot = await marketDataRef.once();
    if (snapshot.snapshot.value != null) {
      Map<dynamic, dynamic> marketDtaa = snapshot.snapshot.value as Map;

      double marketDataPrice = marketDtaa['Price'];
      setState(() {
        marketRatePrice = marketDataPrice;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchDataForHomeScreen();
    fetchDataForHomeScreen2();
    fetchDataForHomeScreen3();
    fetchDataForHomeScreen4();

    updateTime();
    getMarketRate();
    _tabController = TabController(length: 4, vsync: this);

    // Listen to changes on _tabController to set the initial index
    _tabController.addListener(_handleTabSelection);

    // Check if selectedCategory has a value and set the initial index accordingly
    if (widget.selectedCategory != null) {

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

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    screenHeight = screenSize!.height;
    screenWidth = screenSize!.width;

    DateTime currentDate = DateTime.now();

    String formattedDate = DateFormat('dd MMMM yyyy').format(currentDate);
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
                  height: screenHeight! * .09,
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
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              currentTime,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              formattedDate,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                            marketRatePrice != null
                                ? Text(
                                    marketRatePrice.toString(),
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  )
                                : CircularProgressIndicator(),
                          ],
                        ),
                      ),
                    ],
                  ),
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

                    return InkWell(
                      onTap: () {
                        dialogeBox(context, longiData["phone"]);
                      },
                      child: Padding(
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
                                              shape: BoxShape.circle, // Define the container shape as a circle

                                            ),
                                            child: ClipOval(
                                              child: Image.network(
                                                longiData['image'],
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),

                                        ],
                                      ),
                                      SizedBox(height: screenHeight * 0.01),
                                      Text(
                                        longiData['fullName'] ??
                                            longiData['fullName'],
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: screenHeight * 0.018,
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
                                        longiData['SubCategories'].length > 8
                                            ? '${longiData['SubCategories'].substring(0, 15)}...'
                                            : longiData['SubCategories'],
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
                                  padding: longiData['Number'].length < 3  ? EdgeInsets.only(right: 20) : EdgeInsets.only(right: 10),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        "  ${longiData['Number']} ${longiData['Size'] ?? 'NA'}",
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 12),
                                      ),
                                      Text(
                                        longiData['Available'] ?? 'NA',
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 12),
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

                    return InkWell(
                      onTap: () {
                        dialogeBox(context, jinkoData["phone"]);
                      },
                      child: Padding(
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
                                              shape: BoxShape.circle, // Define the container shape as a circle

                                            ),
                                            child: ClipOval(
                                              child: Image.network(
                                                jinkoData['image'],
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: screenHeight * 0.01),
                                      Text(
                                        jinkoData['fullName'],
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: screenHeight * 0.018,
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
                                        jinkoData['SubCategories'].length > 8
                                            ? '${jinkoData['SubCategories'].substring(0, 16)}..'
                                            : jinkoData['SubCategories'],
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
                                            color: Colors.black87,
                                            fontSize: 12),
                                      ),
                                      Text(
                                        jinkoData['Available'] ?? 'NA',
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 12),
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

                    return InkWell(
                      onTap: () {
                        dialogeBox(context, JaData["phone"]);
                      },
                      child: Padding(
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
                                              shape: BoxShape.circle, // Define the container shape as a circle

                                            ),
                                            child: ClipOval(
                                              child: Image.network(
                                                JaData['image'],
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: screenHeight * 0.01),
                                      Text(
                                        JaData['fullName'],
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: screenHeight * 0.018,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: JaData['SubCategories'].length <= 10
                                      ? EdgeInsets.only(
                                          top: 10, bottom: 10, left: 30)
                                      : EdgeInsets.all(10.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        JaData['SubCategories'].length > 8
                                            ? '${JaData['SubCategories'].substring(0, 16)}..'
                                            : JaData['SubCategories'],
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize:
                                              JaData['SubCategories'].length <=
                                                      10
                                                  ? 18
                                                  : 16,
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
                                  padding: JaData['SubCategories'].length <= 10
                                      ? EdgeInsets.only(left: 30)
                                      : EdgeInsets.only(right: 20),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        "  ${JaData['Number']} ${JaData['Size'] ?? 'NA'}",
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 12),
                                      ),
                                      Text(
                                        JaData['Available'] ?? 'NA',
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: JaData['SubCategories'].length <= 10
                                      ? EdgeInsets.only(top: 8, left: 20)
                                      : EdgeInsets.only(top: 8, right: 10),
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

                    return InkWell(
                      onTap: () {
                        dialogeBox(context, CaData["phone"]);
                      },
                      child: Padding(
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
                                              shape: BoxShape.circle, // Define the container shape as a circle

                                            ),
                                            child: ClipOval(
                                              child: Image.network(
                                                CaData['image'],
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: screenHeight * 0.01),
                                      Text(
                                        CaData['fullName'],
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: screenHeight * 0.018,
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
                                        CaData['SubCategories'].length > 8
                                            ? '${CaData['SubCategories'].substring(0, 16)}..'
                                            : CaData['SubCategories'],
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
                                  padding: EdgeInsets.only(right: 15),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        "  ${CaData['Number']} ${CaData['Size'] ?? 'NA'}",
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 12),
                                      ),
                                      Text(
                                        CaData['Available'] ?? 'NA',
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 12),
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

                              decoration: InputDecoration(
                                hintText: 'Enter Bid',
                                border: OutlineInputBorder(),
                              ),

                            ),
                          ),
                        ),

                         MaterialButton(
                           color: primaryColor,
                           onPressed: (){

                         }, child: Text("BID", style: TextStyle(color: Colors.white),),)
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    data.toString(),
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              )
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
}
