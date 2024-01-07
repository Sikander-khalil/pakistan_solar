import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

  TextEditingController bidController = TextEditingController();

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
                  color: white,
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
                              formattedDate,
                              style: TextStyle(
                                  color: black,
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
