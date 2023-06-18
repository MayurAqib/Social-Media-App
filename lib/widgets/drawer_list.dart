import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_posting/theme/colors.dart';

// ignore: must_be_immutable
class DrawerList extends StatelessWidget {
  DrawerList(
      {super.key, required this.icon, required this.text, required this.onTap});
  final String text;
  final IconData icon;
  void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: ListTile(
        onTap: onTap,
        leading: Icon(
          icon,
          color: backgroundColor1,
        ),
        title: Text(
          text,
          style: GoogleFonts.montserrat(
              color: backgroundColor1,
              fontWeight: FontWeight.w500,
              fontSize: 17),
        ),
      ),
    );
  }
}
