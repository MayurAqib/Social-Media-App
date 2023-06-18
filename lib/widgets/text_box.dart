import 'package:flutter/material.dart';
import 'package:social_posting/theme/colors.dart';

class MyTextBox extends StatelessWidget {
  const MyTextBox(
      {super.key,
      required this.sectionName,
      required this.text,
      this.onPressed,
      this.icon});
  final String sectionName;
  final String text;
  final void Function()? onPressed;
  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 15),
      padding: const EdgeInsets.only(left: 15, bottom: 10),
      decoration: BoxDecoration(
          color: backgroundColor2, borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        //section name
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              sectionName,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 15, color: text2),
            ),
            IconButton(
                onPressed: onPressed,
                icon: Icon(
                  icon,
                  color: text2,
                ))
          ],
        ),

        //text
        Text(
          text,
          style: const TextStyle(color: text1),
        )
      ]),
    );
  }
}
