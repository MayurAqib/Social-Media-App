import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_posting/theme/colors.dart';

import '../widgets/my_button.dart';
import '../widgets/my_textfield.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, required this.onTap});
  final void Function() onTap;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
//todo: Controller
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  //todo: DISPOSE CONTROLLER
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _confirmPasswordController.dispose();
  }

  bool obscureText = true;

  void showPassword() {
    setState(() {
      obscureText = !obscureText;
    });
  }

//todo: create account function
  void signUp() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      //pop the loading circle
      Navigator.pop(context);
      displayMessage('password do not match');
      return;
    }
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text);

      //? after creating the user, craete a new document in cloud firestore called Users
      FirebaseFirestore.instance
          .collection('Users')
          .doc(userCredential.user!.email)
          .set({
        'Name':
            '${_firstNameController.text.substring(0, 1).toUpperCase() + _firstNameController.text.substring(1).toLowerCase()} ${_lastNameController.text.substring(0, 1).toUpperCase() + _lastNameController.text.substring(1).toLowerCase()}',
        'email': _emailController.text.trim(),
        'username': _emailController.text.trim().split('@')[0],
        'imageUrl': 'No Image uploaded yet',
        'Mobile Number': ''
      });
    } on FirebaseAuthException catch (e) {
      //pop the loading circle
      Navigator.pop(context);
      displayMessage(e.code);
    }
  }

  // display message

  void displayMessage(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(message),
      ),
    );
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
                const SizedBox(height: 20),
                const Icon(
                  Icons.lock,
                  size: 150,
                  color: text2,
                ),
                //todo:   WELCOME BACK MSG
                Text('Hello there!',
                    style: GoogleFonts.bebasNeue(fontSize: 56, color: text2)),
                //todo:   EMAIL TEXTFIELD
                const Text(
                  'Enter details to register',
                  style: TextStyle(color: text2),
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  children: [
                    Expanded(
                      child: MyTextfield(
                        label: 'First Name',
                        obscureText: false,
                        controller: _firstNameController,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    //todo:   Last Name TEXTFIELD
                    Expanded(
                      child: MyTextfield(
                        label: 'Last Name',
                        obscureText: false,
                        controller: _lastNameController,
                      ),
                    ),
                  ],
                ),

                MyTextfield(
                  label: 'Email',
                  obscureText: false,
                  controller: _emailController,
                ),
                MyTextfield(
                  label: 'Password',
                  obscureText: true,
                  controller: _passwordController,
                ),
                MyTextfield(
                  label: 'Confirm Password',
                  obscureText: true,
                  controller: _confirmPasswordController,
                ),

                const SizedBox(
                  height: 10,
                ),
                //todo:   Sign in button
                MyButton(buttonText: 'Register', onTap: signUp),
                const SizedBox(
                  height: 60,
                ),
                //todo:   GO TO REGISTER PAGE

                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Expanded(
                      child: Divider(
                        color: text1,
                      ),
                    ),
                    const SizedBox(width: 5),
                    const Text(
                      'Already a member?  ',
                      style: TextStyle(color: text2),
                    ),
                    InkWell(
                      onTap: widget.onTap,
                      splashColor: Colors.black,
                      child: const Text(
                        'Login',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(width: 5),
                    const Expanded(
                      child: Divider(
                        color: text1,
                      ),
                    ),
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
