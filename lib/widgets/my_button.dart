import 'package:flutter/material.dart';
import 'package:social_posting/theme/colors.dart';

// ignore: must_be_immutable
class MyButton extends StatelessWidget {
  MyButton(
      {super.key,
      required this.buttonText,
      required this.onTap,
      this.width,
      this.height = 58});
  final String buttonText;
  void Function()? onTap;
  final double? width;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration:
            BoxDecoration(color: text2, borderRadius: BorderRadius.circular(6)),
        child: Center(
          child: Text(
            buttonText,
            style: const TextStyle(
                color: backgroundColor1, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
