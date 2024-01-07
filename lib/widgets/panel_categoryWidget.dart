import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pakistan_solar_market/constant/colors.dart';

class PanelCategoryWidget{

 static buildCategoryList(List<dynamic> categories, BuildContext context) {
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
              Map<String, dynamic> categoriesData = categories[index];

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  height: screenHeight * 0.23,
                  decoration: BoxDecoration(
                    color: white,
                    border: Border.all(width: 1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: screenWidth * 0.11,
                              height: screenWidth * 0.11,
                              child: ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl: categoriesData['image'],
                                  progressIndicatorBuilder: (context,
                                      url, downloadProgress) =>
                                      CircularProgressIndicator(
                                          value: downloadProgress
                                              .progress),
                                  errorWidget:
                                      (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                            ),
                            Text(
                              categoriesData['SubCategories'],
                              style: TextStyle(
                                color: black,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              "RS",
                              style: TextStyle(
                                color: black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding:
                              const EdgeInsets.only(left: 20),
                              child: Text(
                                categoriesData['fullName'] ??
                                    categoriesData['fullName'],
                                style: TextStyle(
                                  color: black,
                                  fontSize: screenHeight * 0.018,
                                ),
                              ),
                            ),
                            Container(
                              decoration:
                              BoxDecoration(color: yellow),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10),
                                child: Text(
                                  categoriesData['Location'],
                                  style: TextStyle(
                                    color: black,
                                    fontSize: 11,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              decoration:
                              BoxDecoration(color: yellow),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10),
                                child: Text(
                                  "  ${categoriesData['Number']} ${categoriesData['Size'] ?? 'NA'}",
                                  style: TextStyle(
                                      color: black,
                                      fontSize: 12),
                                ),
                              ),
                            ),
                            Text(
                              categoriesData['Price'] ?? 'NA',
                              style: TextStyle(
                                color: black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              color: white,
                            ),
                            Container(
                              decoration:
                              BoxDecoration(color: blue),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10),
                                child: Text(
                                  categoriesData['Type'] ?? 'N/A',
                                  style: TextStyle(
                                    color: white,
                                    fontSize: 11,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              decoration:
                              BoxDecoration(color: blue),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10),
                                child: Text(
                                  categoriesData['Available'] ?? 'NA',
                                  style: TextStyle(
                                      color: white, fontSize: 12),
                                ),
                              ),
                            ),
                            Container(
                              color: white,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              decoration:
                              BoxDecoration(color: primaryColor),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 15, right: 15),
                                child: Text(
                                  "Call",
                                  style: TextStyle(color: white),
                                ),
                              ),
                            ),
                            Container(
                              decoration:
                              BoxDecoration(color: primaryColor),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 15, right: 15),
                                child: Text(
                                  "WhatsApp",
                                  style: TextStyle(color: white),
                                ),
                              ),
                            ),
                            Container(
                              decoration:
                              BoxDecoration(color: primaryColor),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 15, right: 15),
                                child: Text(
                                  "Bid",
                                  style: TextStyle(color: white),
                                ),
                              ),
                            ),
                          ],
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