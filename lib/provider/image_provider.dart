import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class DataProvider extends ChangeNotifier {
  final usersCollection = FirebaseFirestore.instance.collection('Users');
  final currentUser = FirebaseAuth.instance.currentUser!;
  File? _selectedImage;
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
    notifyListeners();
  }
}
