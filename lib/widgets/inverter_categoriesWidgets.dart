import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constant/colors.dart';

class InverterCategoryWidget {
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
                        height: screenHeight * 0.12,
                        decoration: BoxDecoration(
                          color: white,
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
                                              imageUrl: categoriesData['image'],
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
                                      categoriesData['fullName'] ??
                                          categoriesData['fullName'],
                                      style: TextStyle(
                                        color: black,
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
                                      categoriesData['SubCategories'],
                                      style: TextStyle(
                                        color: black,
                                        fontSize: 15,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      categoriesData['Location'] ?? 'NA',
                                      style: TextStyle(
                                        color: black,
                                        fontSize: 11,
                                      ),
                                    ),
                                    Text(
                                      categoriesData['Type'] ?? 'N/A',
                                      style: TextStyle(
                                        color: black,
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
                                      "  ${categoriesData['Number']} ${categoriesData['Size'] ?? 'NA'}",
                                      style:
                                          TextStyle(color: black, fontSize: 12),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      categoriesData['Available'] ?? 'NA',
                                      style:
                                          TextStyle(color: black, fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: categoriesData['Price'].length > 4
                                    ? EdgeInsets.only(top: 8, right: 50)
                                    : EdgeInsets.only(top: 8, left: 10),
                                child: Column(
                                  children: [
                                    Text(
                                      "RS",
                                      style: TextStyle(
                                        color: black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      categoriesData['Price'] ?? 'NA',
                                      style: TextStyle(
                                        color: black,
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            categoriesData['Price'].length > 4
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
