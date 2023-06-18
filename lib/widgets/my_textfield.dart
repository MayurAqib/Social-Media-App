import 'package:flutter/material.dart';
import 'package:social_posting/theme/colors.dart';

// ignore: must_be_immutable
class MyTextfield extends StatefulWidget {
  MyTextfield(
      {super.key,
      this.label,
      this.suffixIcon,
      this.hintText,
      required this.controller,
      required this.obscureText,
      this.onPressed});
  // ignore: prefer_typing_uninitialized_variables
  final TextEditingController controller;
  final String? label;
  final String? hintText;
  final bool obscureText;
  final IconData? suffixIcon;
  void Function()? onPressed;

  @override
  State<MyTextfield> createState() => _MyTextfieldState();
}

class _MyTextfieldState extends State<MyTextfield> {
  @override
  Widget build(BuildContext context) {
    final FocusNode focusNode = FocusNode();

    // @override
    // void dispose() {
    //   _focusNode.dispose();
    //   super.dispose();
    // }

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        style: const TextStyle(color: text2),
        cursorColor: text1,
        obscureText: widget.obscureText,
        controller: widget.controller,
        focusNode: focusNode,
        onEditingComplete: () {
          focusNode.unfocus(); // Unfocus the TextField
        },
        decoration: InputDecoration(
            iconColor: text1,
            suffixIconColor: text1,
            hintText: widget.hintText,
            fillColor: backgroundColor2,
            filled: true,
            labelText: widget.label,
            labelStyle: const TextStyle(color: text1),
            suffixIcon: IconButton(
              icon: Icon(widget.suffixIcon),
              onPressed: widget.onPressed,
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(color: Colors.blueGrey.shade300)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide.none)),
      ),
    );
  }
}
