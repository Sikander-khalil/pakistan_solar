import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constant/colors.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: white
          ),
          backgroundColor: blueAccent,
          title: Text("My Notifications",style: TextStyle(color: white),),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Card(
                      color: white70,
                      shape: RoundedRectangleBorder(),
                      child: ListTile(
                        leading: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              color: blueAccent,
                              borderRadius: BorderRadius.circular(40)),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Icon(
                              Icons.notification_important,
                              color: white,
                            ),
                          ),
                        ),
                        title: Text(
                          "This is title",
                          style: TextStyle(
                              color: black, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text("This is body"),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
