import 'package:flutter/material.dart';


class Textfield extends StatelessWidget {
  const Textfield(
      {super.key,
        required this.width,
        required this.hight,
        required this.hint,
        required this.type,
        required this.controller,
        this.val,
        required this.radius,
        required this.hintcolor,
        required this.textcolor,
        required this.hintsize,
        required this.textsize,
        required this.fillcolor,
        required this.enablecolor,
        required this.disablecolor,
        required this.focusedcolor,
        required this.errorcolor,
        required this.focusederrorcolor});
  final Color fillcolor;
  final Color enablecolor;
  final Color disablecolor;
  final Color focusedcolor;
  final Color errorcolor;
  final Color focusederrorcolor;
  final Color hintcolor;
  final Color textcolor;
  final double hintsize;
  final double textsize;
  final TextEditingController controller;
  final TextInputType type;
  final String hint;
  final double radius;
  final double width;
  final double hight;
  final String? Function(String?)? val;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: hight,
      width: width,
      child: TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius),
              borderSide: BorderSide(width: 0.0)
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                width: 0.0,
                color: enablecolor
            ),
            borderRadius: BorderRadius.circular(radius),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 0.0,color: disablecolor),
            borderRadius: BorderRadius.circular(radius),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 0.0,color: errorcolor),
            borderRadius: BorderRadius.circular(radius),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 0.0,color: focusedcolor),
            borderRadius: BorderRadius.circular(radius),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 0.0,color: focusederrorcolor),
            borderRadius: BorderRadius.circular(radius),
          ),
          fillColor: fillcolor,
          filled: true,
          hintStyle: TextStyle(color: hintcolor, fontSize: hintsize),
          hintText: hint,
        ),
        style: TextStyle(color: textcolor, fontSize: textsize),
        textAlign: TextAlign.start,
        keyboardType: type,
        controller: controller,
        validator: val,
      ),
    );
  }
}