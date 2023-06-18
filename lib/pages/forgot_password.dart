import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/colors.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    final _controller = TextEditingController();
    return Scaffold(
      backgroundColor: backgroundColor1,
      body: Center(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Reset password',
                style: GoogleFonts.bebasNeue(fontSize: 54),
              ),
              const SizedBox(height: 25),
              const Text(
                  'Enter your email and we will sent you a reset link to your email'),
              const SizedBox(height: 15),
              TextField(
                controller: _controller,
                cursorColor: Colors.grey,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.black)),
                      onPressed: () {
                        FirebaseAuth.instance.sendPasswordResetEmail(
                            email: _controller.text.trim());
                      },
                      child: const Text('Reset')),
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
