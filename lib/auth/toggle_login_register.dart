import 'package:flutter/material.dart';
import 'package:social_posting/pages/login_page.dart';
import 'package:social_posting/pages/register_page.dart';

class LoginRegister extends StatefulWidget {
  const LoginRegister({super.key});

  @override
  State<LoginRegister> createState() => _LoginRegisterState();
}

class _LoginRegisterState extends State<LoginRegister> {
  bool showLoginPage = true;

  //todo : TOGGLE PAGE FUNCTION
  void toggleScreen() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(onTap: toggleScreen);
    } else {
      return RegisterPage(onTap: toggleScreen);
    }
  }
}
