import 'package:flutter/material.dart';

enum CustomButtonStyle { one, two }

class CustomButton extends StatelessWidget {
  CustomButton({
    super.key,
    this.height = 40,
    this.width = 120,
    required this.title,
    this.radius = 12.0,
    required this.buttonColor,
    this.fontSize,
    this.fontWeight,
    this.fontColor,
  });

  final double? height;
  final double? width;
  final String title;
  final double? radius;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color buttonColor;
  final Color? fontColor;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: width,
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: fontWeight,
              color: fontColor,
            ),
          ),
        ),
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(radius!),
        ),
    );
  }
}
