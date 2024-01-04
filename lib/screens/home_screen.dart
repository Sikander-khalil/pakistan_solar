import 'dart:async';
import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pakistan_solar_market/screens/bottom_nav.dart';
import '../services/firebase_serives.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  String currentTime = '';

  String CandianName = '';
  double Candianprice = 0.0;

  String CandianPName = '';
  double CandianPprice = 0.0;

  String JaName = '';
  double Japrice = 0.0;
  late Timer _timer;
  String JaBame = '';
  double JaBprice = 0.0;

  String jinkoName = '';
  double jinkoprice = 0.0;

  String jinkoPname = '';
  double jinkoPprice = 0.0;

  String longiName = '';
  double longiPrice = 0.0;

  String longi6Name = '';

  double longi6Price = 0.0;
  String newsTitle = '';
  String newsDesc = '';
  double? marketRatePrice;

  String? latestImageUrl = FirebaseService().latestImageUrl;
  List<dynamic> dataList = []; // Yahan aapki data store hogi

  List<dynamic> inverterdataList = []; // Yahan aapki data store hogi
  DatabaseReference _userRef2 =
      FirebaseDatabase.instance.reference().child('home');

  DatabaseReference _inverteruserRef2 =
      FirebaseDatabase.instance.reference().child('homeInverter');

  late TabController _tabController;

  Future<String?> getBlogList() async {
    DatabaseReference blogRef =
        FirebaseDatabase.instance.reference().child('Blog').child("news");

    DatabaseEvent snapshot = await blogRef.once();

    if (snapshot.snapshot.value != null) {
      Map<dynamic, dynamic> blogRateData = snapshot.snapshot.value as Map;
      String title = blogRateData['title'];

      newsTitle = title;
      String description = blogRateData['description'];

      newsDesc = description;

      return title;
    } else {
      return null;
    }
  }

  String selectedCategory = ""; // Default category

  String selectedCategory2 = ""; // Default category

  Future<String?> getChinaRate() async {
    DatabaseReference chinaRef = FirebaseDatabase.instance
        .reference()
        .child('chinaRate')
        .child("Canadian N");
    DatabaseEvent snapshot = await chinaRef.once();
    if (snapshot.snapshot.value != null) {
      Map<dynamic, dynamic> canadianData = snapshot.snapshot.value as Map;
      String canadianName = canadianData['Name'];

      CandianName = canadianName;
      double canadianPrice = canadianData['price'];

      Candianprice = canadianPrice;

      return CandianName;
    } else {
      return null;
    }
  }

  Future<String?> getChinaRate2() async {
    DatabaseReference canadianRef = FirebaseDatabase.instance
        .reference()
        .child('chinaRate')
        .child("Canadian P");
    DatabaseEvent snapshot = await canadianRef.once();
    if (snapshot.snapshot.value != null) {
      Map<dynamic, dynamic> canadianData2 = snapshot.snapshot.value as Map;
      String canadianName2 = canadianData2['Name'];

      CandianPName = canadianName2;
      double canadianPrice2 = canadianData2['Price'];

      CandianPprice = canadianPrice2;

      return CandianPName;
    } else {
      return null;
    }
  }

  Future<String?> getChinaRate3() async {
    DatabaseReference JaRef =
        FirebaseDatabase.instance.reference().child('chinaRate').child("JA");
    DatabaseEvent snapshot = await JaRef.once();
    if (snapshot.snapshot.value != null) {
      Map<dynamic, dynamic> JaData = snapshot.snapshot.value as Map;
      String JaNameData = JaData['Name'];

      JaName = JaNameData;
      double JaPriceData = JaData['Price'];

      Japrice = JaPriceData;

      return JaName;
    } else {
      return null;
    }
  }

  Future<String?> getChinaRate4() async {
    DatabaseReference Ja2Ref =
        FirebaseDatabase.instance.reference().child('chinaRate').child("JA Bi");
    DatabaseEvent snapshot = await Ja2Ref.once();
    if (snapshot.snapshot.value != null) {
      Map<dynamic, dynamic> Ja2Data = snapshot.snapshot.value as Map;
      String JaNameData2 = Ja2Data['Name'];

      JaBame = JaNameData2;
      double JaPriceData2 = Ja2Data['price'];

      JaBprice = JaPriceData2;

      return JaBame;
    } else {
      return null;
    }
  }

  Future<String?> getChinaRate5() async {
    DatabaseReference jinkoRef = FirebaseDatabase.instance
        .reference()
        .child('chinaRate')
        .child("Jinko N");
    DatabaseEvent snapshot = await jinkoRef.once();
    if (snapshot.snapshot.value != null) {
      Map<dynamic, dynamic> jinkoData = snapshot.snapshot.value as Map;
      String jinkonameData = jinkoData['Name'];

      jinkoName = jinkonameData;
      double jinkoPriceData = jinkoData['Price'];

      jinkoprice = jinkoPriceData;

      return jinkoName;
    } else {
      return null;
    }
  }

  Future<String?> getChinaRate6() async {
    DatabaseReference jinkoPRef = FirebaseDatabase.instance
        .reference()
        .child('chinaRate')
        .child("Jinko P");
    DatabaseEvent snapshot = await jinkoPRef.once();
    if (snapshot.snapshot.value != null) {
      Map<dynamic, dynamic> jinkoPData = snapshot.snapshot.value as Map;
      String jinkoPNameData = jinkoPData['Name'];

      jinkoPname = jinkoPNameData;
      double jinkoPPriceData = jinkoPData['Price'];

      jinkoPprice = jinkoPPriceData;

      return jinkoPname;
    } else {
      return null;
    }
  }

  Future<String?> getChinaRate7() async {
    DatabaseReference longiRef = FirebaseDatabase.instance
        .reference()
        .child('chinaRate')
        .child("Longi 5");
    DatabaseEvent snapshot = await longiRef.once();
    if (snapshot.snapshot.value != null) {
      Map<dynamic, dynamic> longiData = snapshot.snapshot.value as Map;
      String longiNameData = longiData['Name'];

      longiName = longiNameData;
      double longiPriceData = longiData['Price'];

      longiPrice = longiPriceData;

      return longiName;
    } else {
      return null;
    }
  }

  Future<String?> getChinaRate8() async {
    DatabaseReference longi6Ref = FirebaseDatabase.instance
        .reference()
        .child('chinaRate')
        .child("Longi 6");
    DatabaseEvent snapshot = await longi6Ref.once();
    if (snapshot.snapshot.value != null) {
      Map<dynamic, dynamic> longi6Data = snapshot.snapshot.value as Map;
      String longi6NameData = longi6Data['Name'];

      longi6Name = longi6NameData;
      double longi6PriceData = longi6Data['Price'];

      longi6Price = longi6PriceData;

      return longi6Name;
    } else {
      return null;
    }
  }

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
    _tabController = TabController(length: 3, vsync: this);
    getData();
    getBlogList();
    getChinaRate();
    getChinaRate2();
    getChinaRate3();
    getChinaRate4();
    getChinaRate5();
    getData2();
    getChinaRate6();
    getChinaRate7();
    getChinaRate8();
    getMarketRate();
    updateTime();
    downlaodUrlExample();
  }

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


  void getData() {
    _userRef2.once().then((snapshot) {
      if (snapshot != null && snapshot.snapshot.value != null) {
        Map<dynamic, dynamic>? values = snapshot.snapshot.value as Map<dynamic, dynamic>?;

        if (values != null) {
          List<Map<dynamic, dynamic>> unsortedList = [];

          values.forEach((key, value) {
            if (value is Map<dynamic, dynamic>) {
              unsortedList.add(value);
            }
          });

          // Sort the list based on price (descending order)
          unsortedList.sort((a, b) {
            double priceA = double.tryParse(a['Price']?.toString() ?? '0') ?? 0;
            double priceB = double.tryParse(b['Price']?.toString() ?? '0') ?? 0;

            // Custom sorting logic
            if (priceA >= 45.0 && priceB >= 45.0) {
              return priceA.compareTo(priceB);
            } else if (priceA <= 45.0 && priceB > 45.0) {
              return -1; // 'a' goes above 'b'
            } else if (priceA > 45.0 && priceB <= 45.0) {
              return 1; // 'b' goes above 'a'
            } else {
              return priceB.compareTo(priceA); // Sort higher prices in descending order
            }
          });

          setState(() {
            dataList = unsortedList;
          });
        }
      }
    }).catchError((error) {
      // Handle any potential errors that occurred during data retrieval
      print("Error fetching data: $error");
      // Add your error handling logic here
    });
  }

  void getData2() {
    _inverteruserRef2.once().then((DatabaseEvent snapshot) {
      if (snapshot != null && snapshot.snapshot.value != null) {
        setState(() {
          Map values = snapshot.snapshot.value as Map;

          if (values != null) {
            List<Map> sortedList = [];

            values.forEach((key, value) {
              sortedList.add(value as Map);
            });

            // Sort the list based on price (descending order)
            sortedList.sort((a, b) {
              double priceA = double.tryParse(a['Price'] ?? '0') ?? 0;
              double priceB = double.tryParse(b['Price'] ?? '0') ?? 0;

              // Custom sorting logic
              if (priceA >= 45.0 && priceB >= 45.0) {
                return priceA.compareTo(priceB);
              } else if (priceA <= 45.0 && priceB > 45.0) {
                return -1; // 'a' goes above 'b'
              } else if (priceA > 45.0 && priceB <= 45.0) {
                return 1; // 'b' goes above 'a'
              } else {
                return priceB.compareTo(priceA); // Sort higher prices in descending order
              }
            });

            inverterdataList = sortedList;
          }
        });
      }
    });
  }

  String? downlaodUrl;

  Future getImage() async {
    try {
      await downlaodUrlExample();
      return downlaodUrl;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> downlaodUrlExample() async {
    downlaodUrl = await FirebaseStorage.instance
        .ref()
        .child("renewable.png")
        .getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;

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
                  height: screenHeight * .09,
                  width: screenWidth * .5,
                ),
              ],
            ),
            SizedBox(
              height: 1,
            ),
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.03),
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
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              formattedDate,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
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
            downlaodUrl != null && downlaodUrl!.isNotEmpty
                ? Center(
                    child: Image.network(
                      downlaodUrl.toString(),
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 100,
                    ),
                  )
                : Center(child: Text('No image available')),
            SizedBox(
              height: 5,
            ),
            TabBar(
              indicatorColor: Color(0xff18be88),
              labelColor: Colors.black,
              dividerColor: Colors.grey,
              tabs: [
                Tab(text: 'Market'),
                Tab(text: 'News'),
                Tab(text: 'China Rate'),
              ],
              controller: _tabController,
            ),
            Flexible(
                child: TabBarView(
              controller: _tabController,
              children: [
                _buildCategoryList(dataList, inverterdataList),
                _buildCategoryList2(newsTitle, newsDesc),
                _buildCategoryList3(
                    CandianName,
                    Candianprice,
                    CandianPName,
                    CandianPprice,
                    JaName,
                    Japrice,
                    JaBame,
                    JaBprice,
                    jinkoName,
                    jinkoprice,
                    jinkoPname,
                    jinkoPprice,
                    longiName,
                    longiPrice,
                    longi6Name,
                    longi6Price),
              ],
            ))
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryList(
    List<dynamic> categories,
    List<dynamic> invertercategories,
  ) {
    return categories.isNotEmpty
        ? SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        "Panel Market",
                        style: TextStyle(
                            color: Color(0xff18be88),
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    Map data = categories[index];

                    String homeCat = data["Home Cat"] ?? '';
                    String abbreviatedHomeCat =
                        homeCat.substring(0, min(homeCat.length, 5));
                    return ListTile(
                      leading: Container(
                        width: 40,
                        height: 40,
                        child: CircleAvatar(
                          backgroundColor: Color(0xff71ACDA8E),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(abbreviatedHomeCat),
                          ),
                        ),
                      ),
                      title: Text(data['Home Cat']),
                      trailing: Text(
                        'RS ${data["Price"]}',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () {
                        String tappedCategory = data['Home Cat'];

                        setState(() {
                          if (tappedCategory.contains('Canadian')) {
                            selectedCategory = 'Canadian';
                          } else if (tappedCategory.contains('Longi')) {
                            selectedCategory = 'Longi';
                          } else if (tappedCategory.contains('Jinko')) {
                            selectedCategory = 'Jinko';
                          } else if (tappedCategory.contains('JA')) {
                            selectedCategory = 'JA';
                          }
                        });

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BottomNavScreen(
                              initialIndex: 1,
                              selectedCategory: selectedCategory,
                            ),
                          ),
                        );
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        "Inverter Market",
                        style: TextStyle(
                            color: Color(0xff18be88),
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: invertercategories.length,
                  itemBuilder: (context, index) {
                    Map inverterdata = invertercategories[index];

                    String inverterhomeCat =
                        inverterdata["Home Inverter"] ?? '';
                    String inverterabbreviatedHomeCat = inverterhomeCat
                        .substring(0, min(inverterhomeCat.length, 5));
                    return ListTile(
                      leading: Container(
                        width: 40,
                        height: 40,
                        child: CircleAvatar(
                          backgroundColor: Color(0xff71ACDA8E),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(inverterabbreviatedHomeCat),
                          ),
                        ),
                      ),
                      title: Text(inverterdata['Home Inverter']),
                      trailing: Text(
                        'RS ${inverterdata["Price"]}',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () {
                        String tappedCategory2 = inverterdata['Home Inverter'];

                        setState(() {
                          if (tappedCategory2.contains('GROWATT')) {
                            selectedCategory2 = 'GROWATT';
                          } else if (tappedCategory2.contains('KNOX')) {
                            selectedCategory2 = 'KNOX';
                          } else if (tappedCategory2.contains('LEVOLTEC')) {
                            selectedCategory2 = 'LEVOLTEC';
                          } else if (tappedCategory2.contains('SOLIS')) {
                            selectedCategory2 = 'SOLIS';
                          } else if (tappedCategory2.contains('TESLA')) {
                            selectedCategory2 = 'TESLA';
                          }
                        });

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BottomNavScreen(
                              initialIndex: 3,
                              selectedCategory: selectedCategory2,
                            ),
                          ),
                        );
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                ),
              ],
            ),
          )
        : Center(child: CircularProgressIndicator());
  }

  Widget _buildCategoryList2(String title, String description) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10,
        ),
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                      text: title,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            )),
        Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                      text: description,
                      style: TextStyle(color: Colors.black, fontSize: 15)),
                ],
              ),
            )),
      ],
    );
  }

  Widget _buildCategoryList3(
    String name,
    double price,
    String name2,
    double price2,
    String name3,
    double price3,
    String name4,
    double price4,
    String name5,
    double price5,
    String name6,
    double price6,
    String name7,
    double price7,
    String name8,
    double price8,
  ) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(
                  name.length > 3 ? '${name.substring(0, 15)}...' : name,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              trailing: Text(price.toString(),
                  style: TextStyle(color: Colors.black, fontSize: 15)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(
                  name2.length > 3 ? '${name2.substring(0, 15)}...' : name2,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              trailing: Text(price2.toString(),
                  style: TextStyle(color: Colors.black, fontSize: 15)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(
                  name3.length > 3
                      ? '${name3.substring(0, name3.length > 15 ? 15 : name3.length)}'
                      : name3,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              trailing: Text(price3.toString(),
                  style: TextStyle(color: Colors.black, fontSize: 15)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(
                name4.length > 3
                    ? '${name4.substring(0, name4.length > 15 ? 15 : name4.length)}'
                    : name4,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: Text(price4.toString(),
                  style: TextStyle(color: Colors.black, fontSize: 15)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(
                  name5.length > 3
                      ? '${name5.substring(0, name5.length > 15 ? 15 : name5.length)}'
                      : name5,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              trailing: Text(price5.toString(),
                  style: TextStyle(color: Colors.black, fontSize: 15)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(
                  name6.length > 3
                      ? '${name6.substring(0, name6.length > 15 ? 15 : name6.length)}'
                      : name6,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              trailing: Text(price6.toString(),
                  style: TextStyle(color: Colors.black, fontSize: 15)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(
                  name7.length > 3
                      ? '${name7.substring(0, name7.length > 15 ? 15 : name7.length)}'
                      : name7,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              trailing: Text(price7.toString(),
                  style: TextStyle(color: Colors.black, fontSize: 15)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(
                  name8.length > 3
                      ? '${name8.substring(0, name8.length > 15 ? 15 : name8.length)}'
                      : name8,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              trailing: Text(price8.toString(),
                  style: TextStyle(color: Colors.black, fontSize: 15)),
            ),
          ),
        ],
      ),
    );
  }
}
