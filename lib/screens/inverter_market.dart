import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:pakistan_solar_market/constant/colors.dart';

import 'register_screen.dart';

class InverterMarket extends StatefulWidget {
  final String? selectedCategory;

  InverterMarket({super.key, this.selectedCategory});

  @override
  State<InverterMarket> createState() => _InverterMarketState();
}

class _InverterMarketState extends State<InverterMarket>
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
      FirebaseDatabase.instance.reference().child('usersinverter');

  List<Map<String, dynamic>> userData = [];
  List<Map<String, dynamic>> userData2 = [];
  List<Map<String, dynamic>> userData3 = [];
  List<Map<String, dynamic>> userData4 = [];
  List<Map<String, dynamic>> userData5 = [];

  void fetchDataForHomeScreen() async {
    try {
      DatabaseEvent snapshot = await _userRef2.once();

      if (snapshot.snapshot.value != null) {
        Map<dynamic, dynamic>? usersData =
            snapshot.snapshot.value as Map<dynamic, dynamic>?;

        if (usersData != null) {
          List<Map<String, dynamic>> fetchedData = [];

          usersData.forEach((key, value) {
            if (value['GROWATT'] != null &&
                value['GROWATT'] is Map<dynamic, dynamic>) {
              String fullName = value['fullName'] ?? '';
              String phone = value['phone'] ?? '';
              String image = value['image'] ?? '';

              (value['GROWATT'] as Map<dynamic, dynamic>)
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
            if (value['KNOX'] != null &&
                value['KNOX'] is Map<dynamic, dynamic>) {
              String fullName = value['fullName'] ?? '';
              String phone = value['phone'] ?? '';
              String image = value['image'] ?? '';
              (value['KNOX'] as Map<dynamic, dynamic>)
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
            if (value['LEVOLTEC'] != null &&
                value['LEVOLTEC'] is Map<dynamic, dynamic>) {
              String fullName = value['fullName'] ?? '';
              String phone = value['phone'] ?? '';
              String image = value['image'] ?? '';
              (value['LEVOLTEC'] as Map<dynamic, dynamic>)
                  .forEach((jAKey, jAValue) {
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
            if (value['SOLIS'] != null &&
                value['SOLIS'] is Map<dynamic, dynamic>) {
              String fullName = value['fullName'] ?? '';
              String phone = value['phone'] ?? '';
              String image = value['image'] ?? '';
              (value['SOLIS'] as Map<dynamic, dynamic>)
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

  void fetchDataForHomeScreen5() async {
    try {
      DatabaseEvent snapshot = await _userRef2.once();

      if (snapshot.snapshot.value != null) {
        Map<dynamic, dynamic>? usersData =
            snapshot.snapshot.value as Map<dynamic, dynamic>?;

        if (usersData != null) {
          List<Map<String, dynamic>> fetchedData = [];

          usersData.forEach((key, value) {
            if (value['TESLA'] != null &&
                value['TESLA'] is Map<dynamic, dynamic>) {
              String fullName = value['fullName'] ?? '';
              String phone = value['phone'] ?? '';
              String image = value['image'] ?? '';
              (value['TESLA'] as Map<dynamic, dynamic>)
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
            userData5 = fetchedData;
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
    fetchDataForHomeScreen5();

    updateTime();
    getMarketRate();
    _tabController = TabController(length: 5, vsync: this);

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
        case 4:
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
      case "GROWATT":
        _tabController.index = 0;

        break;
      case "KNOX":
        _tabController.index = 1;
        break;
      case "LEVOLTEC":
        _tabController.index = 2;
        break;
      case "SOLIS":
        _tabController.index = 3;
        break;
      case "TESLA":
        _tabController.index = 4;
        break;

      default:
        _tabController.index = 0; // Default tab
        break;
    }
  }

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
                SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Tab(text: 'GROWATT')),
                SingleChildScrollView(
                    scrollDirection: Axis.horizontal, child: Tab(text: 'KNOX')),
                SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Tab(text: 'LEVOLTEC')),
                SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Tab(text: 'SOLIS')),
                SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Tab(text: 'TESLA')),
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
                buildCategoryList4(userData4, context),
                buildCategoryList5(userData5, context),
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
                    Map<String, dynamic> growatt = categories[index];

                    return InkWell(
                      onTap: () {
                        dialogeBox(context, growatt["phone"]);
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
                                              shape: BoxShape
                                                  .circle, // Define the container shape as a circle
                                            ),
                                            child: ClipOval(
                                              child: CachedNetworkImage(
                                                imageUrl: growatt['image'],
                                                progressIndicatorBuilder:
                                                    (context, url,
                                                            downloadProgress) =>
                                                        CircularProgressIndicator(
                                                            value:
                                                                downloadProgress
                                                                    .progress),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: screenHeight * 0.01),
                                      Text(
                                        growatt['fullName'] ??
                                            growatt['fullName'],
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: screenHeight * 0.017,
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
                                        growatt['SubCategories'],
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Text(
                                        growatt['Location'] ?? 'NA',
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 11,
                                        ),
                                      ),
                                      Text(
                                        growatt['Type'] ?? 'N/A',
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 11,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        "  ${growatt['Number']} ${growatt['Size'] ?? 'NA'}",
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 12),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        growatt['Available'] ?? 'NA',
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: growatt['Price'].length > 4
                                      ? EdgeInsets.only(top: 8, right: 50)
                                      : EdgeInsets.only(top: 8, left: 10),
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
                                        growatt['Price'] ?? 'NA',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: growatt['Price'].length > 4
                                              ? 16
                                              : 16,
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
                    Map<String, dynamic> kNOX = categories[index];

                    return InkWell(
                      onTap: () {
                        dialogeBox(context, kNOX["phone"]);
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
                                              shape: BoxShape
                                                  .circle, // Define the container shape as a circle
                                            ),
                                            child: ClipOval(
                                              child: CachedNetworkImage(
                                                imageUrl: kNOX['image'],
                                                progressIndicatorBuilder:
                                                    (context, url,
                                                            downloadProgress) =>
                                                        CircularProgressIndicator(
                                                            value:
                                                                downloadProgress
                                                                    .progress),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: screenHeight * 0.01),
                                      Text(
                                        kNOX['fullName'] ?? kNOX['fullName'],
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: screenHeight * 0.017,
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
                                        kNOX['SubCategories'],
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Text(
                                        kNOX['Location'] ?? 'NA',
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 11,
                                        ),
                                      ),
                                      Text(
                                        kNOX['Type'] ?? 'N/A',
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 11,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        "  ${kNOX['Number']} ${kNOX['Size'] ?? 'NA'}",
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 12),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        kNOX['Available'] ?? 'NA',
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: kNOX['Price'].length > 4
                                      ? EdgeInsets.only(top: 8, right: 50)
                                      : EdgeInsets.only(top: 8, left: 10),
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
                                        kNOX['Price'] ?? 'NA',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: kNOX['Price'].length > 4
                                              ? 16
                                              : 16,
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
                    Map<String, dynamic> lEVOLTEC = categories[index];

                    return InkWell(
                      onTap: () {
                        dialogeBox(context, lEVOLTEC["phone"]);
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
                                              shape: BoxShape
                                                  .circle, // Define the container shape as a circle
                                            ),
                                            child: ClipOval(
                                              child: CachedNetworkImage(
                                                imageUrl: lEVOLTEC['image'],
                                                progressIndicatorBuilder:
                                                    (context, url,
                                                            downloadProgress) =>
                                                        CircularProgressIndicator(
                                                            value:
                                                                downloadProgress
                                                                    .progress),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: screenHeight * 0.01),
                                      Text(
                                        lEVOLTEC['fullName'] ??
                                            lEVOLTEC['fullName'],
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: screenHeight * 0.017,
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
                                        lEVOLTEC['SubCategories'],
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Text(
                                        lEVOLTEC['Location'] ?? 'NA',
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 11,
                                        ),
                                      ),
                                      Text(
                                        lEVOLTEC['Type'] ?? 'N/A',
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 11,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        "  ${lEVOLTEC['Number']} ${lEVOLTEC['Size'] ?? 'NA'}",
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 12),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        lEVOLTEC['Available'] ?? 'NA',
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: lEVOLTEC['Price'].length > 4
                                      ? EdgeInsets.only(top: 8, right: 50)
                                      : EdgeInsets.only(top: 8, left: 10),
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
                                        lEVOLTEC['Price'] ?? 'NA',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: lEVOLTEC['Price'].length > 4
                                              ? 16
                                              : 16,
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
                    Map<String, dynamic> solis = categories[index];

                    return InkWell(
                      onTap: () {
                        dialogeBox(context, solis["phone"]);
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
                                              shape: BoxShape
                                                  .circle, // Define the container shape as a circle
                                            ),
                                            child: ClipOval(
                                              child: CachedNetworkImage(
                                                imageUrl: solis['image'],
                                                progressIndicatorBuilder:
                                                    (context, url,
                                                            downloadProgress) =>
                                                        CircularProgressIndicator(
                                                            value:
                                                                downloadProgress
                                                                    .progress),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: screenHeight * 0.01),
                                      Text(
                                        solis['fullName'] ?? solis['fullName'],
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: screenHeight * 0.017,
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
                                        solis['SubCategories'],
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Text(
                                        solis['Location'] ?? 'NA',
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 11,
                                        ),
                                      ),
                                      Text(
                                        solis['Type'] ?? 'N/A',
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 11,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        "  ${solis['Number']} ${solis['Size'] ?? 'NA'}",
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 12),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        solis['Available'] ?? 'NA',
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: solis['Price'].length > 4
                                      ? EdgeInsets.only(top: 8, right: 50)
                                      : EdgeInsets.only(top: 8, left: 10),
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
                                        solis['Price'] ?? 'NA',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: solis['Price'].length > 4
                                              ? 16
                                              : 16,
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

  buildCategoryList5(List<dynamic> categories, BuildContext context) {
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
                    Map<String, dynamic> tesla = categories[index];

                    return InkWell(
                      onTap: () {
                        dialogeBox(context, tesla["phone"]);
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
                                              shape: BoxShape
                                                  .circle, // Define the container shape as a circle
                                            ),
                                            child: ClipOval(
                                              child: CachedNetworkImage(
                                                imageUrl: tesla['image'],
                                                progressIndicatorBuilder:
                                                    (context, url,
                                                            downloadProgress) =>
                                                        CircularProgressIndicator(
                                                            value:
                                                                downloadProgress
                                                                    .progress),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: screenHeight * 0.01),
                                      Text(
                                        tesla['fullName'] ?? tesla['fullName'],
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: screenHeight * 0.017,
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
                                        tesla['SubCategories'],
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Text(
                                        tesla['Location'] ?? 'NA',
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 11,
                                        ),
                                      ),
                                      Text(
                                        tesla['Type'] ?? 'N/A',
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 11,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        "  ${tesla['Number']} ${tesla['Size'] ?? 'NA'}",
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 12),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        tesla['Available'] ?? 'NA',
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: tesla['Price'].length > 4
                                      ? EdgeInsets.only(top: 8, right: 50)
                                      : EdgeInsets.only(top: 8, left: 10),
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
                                        tesla['Price'] ?? 'NA',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: tesla['Price'].length > 4
                                              ? 16
                                              : 16,
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
                            onPressed: () {},
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
}
