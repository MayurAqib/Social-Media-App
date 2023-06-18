import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_posting/pages/forgot_password.dart';
import 'package:social_posting/theme/colors.dart';
import 'package:social_posting/widgets/my_button.dart';
import 'package:social_posting/widgets/my_textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.onTap});
  final void Function() onTap;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //todo: Controller
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  //todo: DISPOSE CONTROLLER
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  bool obscureText = true;
  //! showHidePassword in textfield function
  void showPassword() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  //! Sign In Function
  Future signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context); //pop the loading circle
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text(e.message.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor1,
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 25, right: 25, top: 25, bottom: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                //todo:  LOGO
                const Icon(
                  Icons.lock,
                  size: 120,
                  color: text2,
                ),
                //todo:   WELCOME BACK MSG
                Text('Welcome Back!',
                    style: GoogleFonts.bebasNeue(fontSize: 56, color: text2)),
                //todo:   EMAIL TEXTFIELD
                MyTextfield(
                  label: 'Email',
                  obscureText: false,
                  controller: _emailController,
                ),
                //todo:   PASSWORD TEXTFIELD
                MyTextfield(
                  label: 'password',
                  obscureText: obscureText,
                  suffixIcon: obscureText
                      ? Icons.remove_red_eye_outlined
                      : Icons.remove_red_eye,
                  onPressed: showPassword,
                  controller: _passwordController,
                ),

                //todo:   FORGOT PASSWORD
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ForgotPassword()));
                      },
                      child: const Text(
                        'Forgot Password? ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.red),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                //todo:   Sign in button
                MyButton(buttonText: 'Login', onTap: signIn),

                const SizedBox(
                  height: 60,
                ),
                //todo:   GO TO REGISTER PAGE
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 120),
                  child: Divider(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don\'t have an Account?  ',
                      style: TextStyle(color: text2),
                    ),
                    InkWell(
                      onTap: widget.onTap,
                      splashColor: Colors.black,
                      child: const Text(
                        'Create Account!',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
