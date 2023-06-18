import 'package:flutter/material.dart';
import 'package:social_posting/theme/colors.dart';

class Comments extends StatelessWidget {
  const Comments(
      {super.key, required this.text, required this.time, required this.user});
  final String text;
  final String user;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
          color: backgroundColor1, borderRadius: BorderRadius.circular(5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //comment
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                user,
                style:
                    const TextStyle(color: text2, fontWeight: FontWeight.bold),
              ),
              Text(
                time,
                style: const TextStyle(color: text1),
              )
            ],
          ),
          const SizedBox(height: 5),
          //row of user,time
          Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.w500, color: text2),
          )
        ],
      ),
    );
  }
}
