import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:pakistan_solar_market/screens/add_post.dart';
import 'package:pakistan_solar_market/screens/bottom_nav.dart';
import 'package:pakistan_solar_market/screens/panel.dart';
import 'package:pakistan_solar_market/screens/register_screen.dart';

User? user = FirebaseAuth.instance.currentUser;


bool isUnavailable = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.getInitialMessage();
  runApp(const MyApp());
}



class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkTime();
  }

  void checkTime() {
    DateTime currentTime = DateTime.now();
    int currentHour = currentTime.hour;

    String timePeriod = (currentHour < 12) ? 'AM' : 'PM';

    if (currentHour >= 0 && currentHour < 7) {
      setState(() {
        isUnavailable = true;
      });
    } else {
      setState(() {
        isUnavailable = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pakistan Solar Market',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: BottomNavScreen(
      //   initialIndex: 0,
      // ),
      home: AddPost(),

    );
  }
}
