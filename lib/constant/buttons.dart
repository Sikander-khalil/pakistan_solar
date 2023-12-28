import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final double w;
  final double h;
  final double radius;
  final double fontsize;
  final FontWeight textweight;
  final String title;
  final Color buttoncolor;
  final Color textcolor;
  void Function()? onPressed;
  Button(
      {super.key,
        required this.w,
        required this.onPressed,
        required this.title,
        required this.radius,
        required this.textcolor,
        required this.fontsize,
        required this.textweight,
        required this.buttoncolor, required this.h});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: buttoncolor,
          borderRadius: BorderRadius.circular(radius),
        ),
        height: h,
        width: w,
        child: Center(
          child: Text(
            title,
            style: TextStyle(
                fontSize: fontsize, color: textcolor, fontWeight: textweight),
          ),
        ),
      ),
    );
  }
}
