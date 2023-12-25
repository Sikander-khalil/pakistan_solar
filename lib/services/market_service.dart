import 'package:flutter/material.dart';

import '../widgets/dialoge_box.dart';

class MarketServices {


  static buildCategoryList(List<dynamic> categories, BuildContext context) {

  Size  screenSize = MediaQuery.of(context).size;
  double  screenHeight = screenSize.height;
   double screenWidth = screenSize.width;
    return categories.isNotEmpty
        ? SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          ListView.separated(
            shrinkWrap: true,
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
                                  Dialogue.dialogeBox(context);
                                },
                                child: Text(
                                  longiData['fullName'].substring(0, 8) ??
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
                                "  ${longiData['Number']} ${longiData['Size'] ??
                                    'NA'}",
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

  static buildCategoryList2(List<dynamic> categories, BuildContext context) {
    Size  screenSize = MediaQuery.of(context).size;
    double  screenHeight = screenSize.height;
    double screenWidth = screenSize.width;
    return categories.isNotEmpty
        ? SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          ListView.separated(
            shrinkWrap: true,
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
                                  Dialogue.dialogeBox(context);
                                },
                                child: Text(
                                  jinkoData['fullName'].substring(0, 8) ??
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
                                "  ${jinkoData['Number']} ${jinkoData['Size'] ??
                                    'NA'}",
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

  static buildCategoryList3(List<dynamic> categories, BuildContext context) {
    Size  screenSize = MediaQuery.of(context).size;
    double  screenHeight = screenSize.height;
    double screenWidth = screenSize.width;
    return categories.isNotEmpty
        ? SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          ListView.separated(
            shrinkWrap: true,
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
                                  Dialogue.dialogeBox(context);
                                },
                                child: Text(
                                  JaData['fullName'].substring(0, 8) ??
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
                                "  ${JaData['Number']} ${JaData['Size'] ??
                                    'NA'}",
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

  static  buildCategoryList4(List<dynamic> categories, BuildContext context) {
    Size  screenSize = MediaQuery.of(context).size;
    double  screenHeight = screenSize.height;
    double screenWidth = screenSize.width;
    return categories.isNotEmpty
        ? SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          ListView.separated(
            shrinkWrap: true,
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
                                  Dialogue.dialogeBox(context);
                                },
                                child: Text(
                                  CaData['fullName'].substring(0, 8) ??
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
                                "  ${CaData['Number']} ${CaData['Size'] ??
                                    'NA'}",
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
}