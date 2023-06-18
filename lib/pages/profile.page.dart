import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:social_posting/theme/colors.dart';
import 'package:social_posting/widgets/user_image.dart';
import '../widgets/text_box.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  File? _selectedImage;

  //all users
  final usersCollection = FirebaseFirestore.instance.collection('Users');
  //edit field
  Future<void> editField(String field) async {
    String newValue = '';
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: text2,
              title: Text(
                'Edit: $field',
                style: const TextStyle(color: backgroundColor1),
              ),
              content: TextField(
                autofocus: true,
                cursorColor: text1,
                style: const TextStyle(color: backgroundColor1),
                decoration: InputDecoration(
                    hintText: 'Enter new $field',
                    hintStyle: const TextStyle(color: backgroundColor1),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: text1),
                        borderRadius: BorderRadius.circular(12))),
                onChanged: (value) {
                  newValue = value;
                },
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: backgroundColor1),
                    )),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(newValue);
                    },
                    child: const Text('Save',
                        style: TextStyle(color: backgroundColor1)))
              ],
            ));

    //update in firestore
    if (newValue.trim().isNotEmpty) {
      await usersCollection.doc(currentUser.email).update({field: newValue});
    }
  }

  //update the imageUrl

  Future<void> imageUpload() async {
    final userCredentials = FirebaseAuth.instance.currentUser!;

    final storageRef = FirebaseStorage.instance
        .ref()
        .child('imageUrl')
        .child('${userCredentials.uid}.jpg');

    await storageRef.putFile(_selectedImage!);
    final imageUrl = await storageRef.getDownloadURL();
    if (imageUrl.isNotEmpty) {
      await usersCollection
          .doc(currentUser.email)
          .update({'imageUrl': imageUrl});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor1,
        appBar: AppBar(
          backgroundColor: text1,
          elevation: 0,
          iconTheme: const IconThemeData(color: backgroundColor1),
          centerTitle: true,
          title: const Text(
            'P R O F I L E',
            style: TextStyle(color: backgroundColor1),
          ),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Users')
              .doc(currentUser.email)
              .snapshots(),
          builder: (context, snapshot) {
            //get userData

            if (snapshot.hasData) {
              final userData = snapshot.data!.data() as Map<String, dynamic>;
              return ListView(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        color: text1,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15))),
                    child: UserImage(
                      fullName: userData['Name'],
                      onSave: () {
                        imageUpload();
                        Navigator.pop(context);
                      },
                      onPickImage: (pickedImage) =>
                          _selectedImage = pickedImage,
                    ),
                  ),

                  //User full name

                  const SizedBox(
                    height: 50,
                  ),
                  //user details
                  const Padding(
                    padding: EdgeInsets.only(left: 25),
                    child: Text(
                      'My Details',
                      style: TextStyle(
                          color: text2,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                  //username
                  MyTextBox(sectionName: 'Email', text: userData['email']),
                  //username
                  MyTextBox(
                    text: userData['username'],
                    sectionName: 'Username',
                    onPressed: () => editField('username'),
                    icon: Icons.edit,
                  ),
                  // mobile number
                  MyTextBox(
                    text: userData['Mobile Number'],
                    sectionName: 'Mobile Number',
                    onPressed: () => editField('Mobile Number'),
                    icon: Icons.edit,
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error.toString()}');
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
