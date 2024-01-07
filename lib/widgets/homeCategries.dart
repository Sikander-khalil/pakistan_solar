import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pakistan_solar_market/constant/colors.dart';

import '../screens/bottom_nav.dart';

class HomeCategories {
  static String selectedCategory = ""; // Default category

  static String selectedCategory2 = ""; // Default category

  static Widget buildCategoryList(
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
                            color: primaryColor,
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
                          color: black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () {
                        String tappedCategory = data['Home Cat'];

                        if (tappedCategory.contains('Canadian')) {
                          selectedCategory = 'Canadian';
                        } else if (tappedCategory.contains('Longi')) {
                          selectedCategory = 'Longi';
                        } else if (tappedCategory.contains('Jinko')) {
                          selectedCategory = 'Jinko';
                        } else if (tappedCategory.contains('JA')) {
                          selectedCategory = 'JA';
                        }

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
                            color: primaryColor,
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
                          color: black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () {
                        String tappedCategory2 = inverterdata['Home Inverter'];

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

  static Widget buildCategoryList2(String title, String description) {
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
                          color: black,
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
                      style: TextStyle(color: black, fontSize: 15)),
                ],
              ),
            )),
      ],
    );
  }

  static Widget buildCategoryList3(
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
                      color: black, fontSize: 18, fontWeight: FontWeight.bold)),
              trailing: Text(price.toString(),
                  style: TextStyle(color: black, fontSize: 15)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(
                  name2.length > 3 ? '${name2.substring(0, 15)}...' : name2,
                  style: TextStyle(
                      color: black, fontSize: 18, fontWeight: FontWeight.bold)),
              trailing: Text(price2.toString(),
                  style: TextStyle(color: black, fontSize: 15)),
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
                      color: black, fontSize: 18, fontWeight: FontWeight.bold)),
              trailing: Text(price3.toString(),
                  style: TextStyle(color: black, fontSize: 15)),
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
                  color: black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: Text(price4.toString(),
                  style: TextStyle(color: black, fontSize: 15)),
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
                      color: black, fontSize: 18, fontWeight: FontWeight.bold)),
              trailing: Text(price5.toString(),
                  style: TextStyle(color: black, fontSize: 15)),
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
                      color: black, fontSize: 18, fontWeight: FontWeight.bold)),
              trailing: Text(price6.toString(),
                  style: TextStyle(color: black, fontSize: 15)),
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
                      color: black, fontSize: 18, fontWeight: FontWeight.bold)),
              trailing: Text(price7.toString(),
                  style: TextStyle(color: black, fontSize: 15)),
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
                      color: black, fontSize: 18, fontWeight: FontWeight.bold)),
              trailing: Text(price8.toString(),
                  style: TextStyle(color: black, fontSize: 15)),
            ),
          ),
        ],
      ),
    );
  }
}
