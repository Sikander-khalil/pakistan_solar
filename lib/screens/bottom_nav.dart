import 'package:flutter/material.dart';
import 'package:pakistan_solar_market/widgets/add_post.dart';
import 'package:pakistan_solar_market/screens/home_screen.dart';
import 'package:pakistan_solar_market/screens/panel.dart';



import 'inverter_market.dart';


class BottomNavScreen extends StatefulWidget {

  BottomNavScreen({Key? key}) : super(key: key);

  @override
  _BottomNavScreenState createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _tabIndex = 0;

  List<Widget> _pages = [

    HomeScreen(),
    PanelMarket(),
    AddPost(),
    InverterMarket(),
    Placeholder(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_tabIndex], // Use _pages instead of _tabs
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
        onTap: (int index) {
          setState(() {
            _tabIndex = index;
          });
        },
        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset(


              "assets/images/home.png",fit: BoxFit.cover,
              width: 30,
              height: 30,
            ),
            label: 'HOME',
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/images/solar-panel.png",fit: BoxFit.cover,

              width: 30,
              height: 30,
            ),
            label: 'Panels',
          ),
          BottomNavigationBarItem(
            icon: Container(

              width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: Color(0xff18be88),
                  borderRadius: BorderRadius.circular(60),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.add, color: Colors.white,),
                )),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/images/solar-inverter.png",fit: BoxFit.cover,
              width: 30,
              height: 30,
            ),
            label: 'Inverters',
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/images/settings.png",fit: BoxFit.cover,
              width: 30,
              height: 30,
            ),
            label: 'Setting',
          ),
        ],
      ),
    );
  }
}