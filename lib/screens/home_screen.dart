import 'dart:async';
import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pakistan_solar_market/screens/inverter_market.dart';
import 'package:pakistan_solar_market/screens/panel.dart';

import '../services/firebase_serives.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  DatabaseReference _userRef =
      FirebaseDatabase.instance.reference().child('formatDate');
  String? date; // Nullable String
  String? price; // Nullable String
  String? avalaible; // Nullable String
  String? latestImageUrl = FirebaseService().latestImageUrl;
  List<dynamic> dataList = []; // Yahan aapki data store hogi
  DatabaseReference _userRef2 =
      FirebaseDatabase.instance.reference().child('home');

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    getData();
    _fetchData();
  }

  void getData() {
    _userRef2.once().then((DatabaseEvent snapshot) {
      setState(() {
        Map values = snapshot.snapshot.value as Map;
        values.forEach((key, value) {
          dataList.add(value); // DataList mein Firebase se mila data add karein
        });
      });
    });
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
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;
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
                  height: screenHeight * .1,
                  width: screenWidth * .6,
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
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                )
                              : Text("available"),
                          date != null
                              ? Text(
                                  date!,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                )
                              : Text("date"),
                          price != null
                              ? Text(
                                  price!,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
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
            latestImageUrl != null && latestImageUrl!.isNotEmpty
                ? Center(
                    child: Image.network(
                      latestImageUrl.toString(),
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
                Tab(text: 'China Rate'),
                Tab(text: 'News'),
                Tab(text: 'Verified Companies'),
              ],
              controller: _tabController,
            ),
            Flexible(
                child: TabBarView(
              controller: _tabController,
              children: [
                _buildCategoryList(dataList, dataList),
                _buildCategoryList(dataList, dataList),
                _buildCategoryList(dataList, dataList),
                _buildCategoryList(dataList, dataList),
              ],
            ))
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryList(
      List<dynamic> categories, List<dynamic> categories2) {
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
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PanelMarket()));
                },
                child: ListView.separated(

                  physics: NeverScrollableScrollPhysics(),

                  shrinkWrap: true,

                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    Map data = categories[index];

                    String homeCat = data["Home Cat"] ??
                        ''; // Ensure data["Home Cat"] is not null
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
                        data["Price"],
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => Divider(),
                ),
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
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => InverterMarket()));
                },
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: categories2.length,
                  itemBuilder: (context, index) {
                    Map data2 = categories2[index];
                    String homeCat2 = data2["Home Cat"] ??
                        ''; // Ensure data["Home Cat"] is not null
                    String abbreviatedHomeCat =
                        homeCat2.substring(0, min(homeCat2.length, 5));
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
                      title: Text(data2["Home Cat"]),
                      trailing: Text(
                        data2["Price"],
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => Divider(),
                ),
              )
            ],
          ),
        )
        : Center(child: CircularProgressIndicator());
  }
}
