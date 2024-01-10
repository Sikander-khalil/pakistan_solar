import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import 'package:pakistan_solar_market/screens/register_screen.dart';
import 'package:pakistan_solar_market/widgets/panel_categoryWidget.dart';
import 'package:pakistan_solar_market/widgets/panelWidgets.dart';

import '../constant/colors.dart';

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



  List<Map<String, dynamic>> userData = [];
  List<Map<String, dynamic>> userData2 = [];
  List<Map<String, dynamic>> userData3 = [];
  List<Map<String, dynamic>> userData4 = [];
  String? selectedCategory;

  Size? screenSize;
  double? screenHeight;
  double? screenWidth;
  late TabController _tabController;

  void fetchLongiData() async {
    selectedCategory = 'Longi';

    userData = await PanelWidgets.fetchDataForPanel(selectedCategory!);
  }

  void fetchJinkoData() async {
    selectedCategory = 'Jinko';

    userData2 = await PanelWidgets.fetchDataForPanel(selectedCategory!);
  }

  void fetchJAData() async {
    selectedCategory = 'JA';

    userData3 = await PanelWidgets.fetchDataForPanel(selectedCategory!);
  }

  void fetchCanadianData() async {
    selectedCategory = 'Canadian';

    userData4 = await PanelWidgets.fetchDataForPanel(selectedCategory!);
  }

  void getMarketPriceRate() async {
    marketRatePrice = await PanelWidgets.getMarketRate();

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchLongiData();
    fetchJinkoData();
    fetchJAData();
    fetchCanadianData();
    getMarketPriceRate();

    _tabController = TabController(length: 4, vsync: this);

    if (widget.selectedCategory != null) {
      _setInitialIndex(widget.selectedCategory!);
    }
  }

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
        _tabController.index = 0;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    screenHeight = screenSize!.height;
    screenWidth = screenSize!.width;

    DateTime currentDate = DateTime.now();

    String formattedDate = DateFormat('dd MMM').format(currentDate);
    return SafeArea(
      child: Scaffold(
        body: Column(

          children: [
            Container(
              height: 80,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset(
                      "assets/images/logo.png",
                      fit: BoxFit.cover,
                      width: screenWidth! * 0.42,
                      height: screenHeight! * 0.12 ,

                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20, right: 10),
                      child: Image.asset(
                        "assets/images/bismallah1.png",
                        fit: BoxFit.contain,
                        width: screenWidth! * 0.22,
                        height: screenHeight! * 0.22 ,

                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 6),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '$formattedDate\n',
                              style: TextStyle(
                                color: Color(0xff05bc64),
                                fontSize: screenWidth! * 0.08,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            WidgetSpan(
                              alignment: PlaceholderAlignment.middle,
                              child: SizedBox(
                                width: 40.0, // Adjust the width to set the desired padding
                                child: Text(''), // Adding an empty text as a placeholder
                              ),
                            ),
                            TextSpan(
                              text: '\$${marketRatePrice.toString()}',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),



                    )

                  ],),
              ),
            ),
            TabBar(
              indicatorColor: primaryColor,
              labelColor: black,
              dividerColor: grey,
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
                 PanelCategoryWidget.buildCategoryList(userData, context),
                PanelCategoryWidget.buildCategoryList(userData2, context),
                PanelCategoryWidget.buildCategoryList(userData3, context),
                PanelCategoryWidget.buildCategoryList(userData4, context)
              ],
            ))
          ],
        ),
      ),
    );
  }

}
