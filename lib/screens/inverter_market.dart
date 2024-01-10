import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:pakistan_solar_market/constant/colors.dart';
import 'package:pakistan_solar_market/widgets/inverterWidgets.dart';
import 'package:pakistan_solar_market/widgets/inverter_categoriesWidgets.dart';

import '../widgets/panelWidgets.dart';

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

  String? selectedCategory;

  List<Map<String, dynamic>> userData = [];
  List<Map<String, dynamic>> userData2 = [];
  List<Map<String, dynamic>> userData3 = [];
  List<Map<String, dynamic>> userData4 = [];
  List<Map<String, dynamic>> userData5 = [];

  void fetchGROWATTData() async {
    selectedCategory = 'GROWATT';

    userData = await InverterWidgets.fetchDataForInverter(selectedCategory!);
  }

  void fetchKNOXData() async {
    selectedCategory = 'KNOX';

    userData2 = await InverterWidgets.fetchDataForInverter(selectedCategory!);
  }

  void fetchLEVOLTECData() async {
    selectedCategory = 'LEVOLTEC';

    userData3 = await InverterWidgets.fetchDataForInverter(selectedCategory!);
  }

  void fetchSOLISData() async {
    selectedCategory = 'SOLIS';

    userData4 = await InverterWidgets.fetchDataForInverter(selectedCategory!);
  }

  void fetchTESLAData() async {
    selectedCategory = 'TESLA';

    userData5 = await InverterWidgets.fetchDataForInverter(selectedCategory!);
  }

  Size? screenSize;
  double? screenHeight;
  double? screenWidth;
  late TabController _tabController;

  void getMarketPriceRate() async {
    marketRatePrice = await PanelWidgets.getMarketRate();

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchGROWATTData();
    fetchKNOXData();
    fetchLEVOLTECData();
    fetchSOLISData();
    fetchTESLAData();
    getMarketPriceRate();
    _tabController = TabController(length: 5, vsync: this);

    if (widget.selectedCategory != null) {
      _setInitialIndex(widget.selectedCategory!);
    }
  }

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

    String formattedDate = DateFormat('dd MMM').format(currentDate);
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset(
                    "assets/images/logo.png",
                    fit: BoxFit.cover,
                    width: 150,
                    height: 150,

                  ),
                  Image.asset(
                    "assets/images/bismallah1.png",
                    fit: BoxFit.contain,
                    width: 120,
                    height: 50,

                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '$formattedDate\n',
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
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

            TabBar(
              indicatorColor: primaryColor,
              labelColor: black,
              dividerColor: grey,
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
                InverterCategoryWidget.buildCategoryList(userData, context),
                InverterCategoryWidget.buildCategoryList(userData2, context),
                InverterCategoryWidget.buildCategoryList(userData3, context),
                InverterCategoryWidget.buildCategoryList(userData4, context),
                InverterCategoryWidget.buildCategoryList(userData5, context),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
