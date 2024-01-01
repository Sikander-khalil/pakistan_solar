import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pakistan_solar_market/constant/colors.dart';

import 'package:pakistan_solar_market/screens/register_screen.dart';
import 'package:pakistan_solar_market/screens/settings_screens.dart';
import 'package:pakistan_solar_market/widgets/add_post.dart';
import 'package:pakistan_solar_market/screens/home_screen.dart';
import 'package:pakistan_solar_market/screens/panel.dart';
import 'package:pakistan_solar_market/screens/inverter_market.dart';
import 'package:pakistan_solar_market/screens/login_screen.dart';

class BottomNavScreen extends StatefulWidget {
  final int initialIndex;
  final String? selectedCategory;

  BottomNavScreen({Key? key, required this.initialIndex, this.selectedCategory})
      : super(key: key);

  @override
  _BottomNavScreenState createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _tabIndex = 0;
  User? user = FirebaseAuth.instance.currentUser;

  List<Widget> _pages = [
    HomeScreen(),
    PanelMarket(),
    AddPost(), // Make sure AddPost() is initially placed at the correct index
    InverterMarket(),
    SettingsScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _tabIndex = widget.initialIndex;
    _handleTabSelection(_tabIndex);
  }

  void _handleTabSelection(int index) {
    setState(() {
      if (index == 2 && user == null) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("LOGIN OR REGISTER"),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MaterialButton(
                    color: primaryColor,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  MaterialButton(
                    color: primaryColor,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterScreen()),
                      );
                    },
                    child: Text(
                      "Register",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      } else if (index == 4 && user == null) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("LOGIN OR REGISTER"),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MaterialButton(
                    color: primaryColor,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  MaterialButton(
                    color: primaryColor,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterScreen()),
                      );
                    },
                    child: Text(
                      "Register",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      } else {
        _tabIndex = index;
      }

      // Update the pages according to tab selection
      if (_tabIndex == 1) {
        _pages[_tabIndex] =
            PanelMarket(selectedCategory: widget.selectedCategory);
      } else if (_tabIndex == 3) {
        _pages[_tabIndex] =
            InverterMarket(selectedCategory: widget.selectedCategory);
      } else if (_tabIndex == 4 && user != null) {
        _pages[_tabIndex] = SettingsScreen();
      } else if (_tabIndex == 2 && user != null) {
        _pages[_tabIndex] = AddPost(); // Set a default screen if needed
      } else {
        _pages[_tabIndex] = HomeScreen();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_tabIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedLabelStyle: TextStyle(fontSize: 14),
        elevation: 10,
        unselectedLabelStyle: TextStyle(fontSize: 14.0),
        unselectedItemColor: Color(0xff546481),
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        currentIndex: _tabIndex,
        onTap: _handleTabSelection,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/images/home.png",
              fit: BoxFit.cover,
              width: 25,
              height: 25,
            ),
            label: 'HOME',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/images/solar-panel.png",
              fit: BoxFit.cover,
              width: 25,
              height: 25,
            ),
            label: 'Panels',
          ),
          BottomNavigationBarItem(
            icon: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Color(0xff18be88),
                  borderRadius: BorderRadius.circular(60),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                )),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/images/solar-inverter.png",
              fit: BoxFit.cover,
              width: 25,
              height: 25,
            ),
            label: 'Inverters',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/images/settings.png",
              fit: BoxFit.cover,
              width: 25,
              height: 25,
            ),
            label: 'Setting',
          ),
        ],
      ),
    );
  }
}
