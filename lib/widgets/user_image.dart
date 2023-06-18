import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_posting/theme/colors.dart';

class UserImage extends StatefulWidget {
  const UserImage(
      {super.key,
      required this.onPickImage,
      required this.onSave,
      required this.fullName});
  final void Function(File pickedImage) onPickImage;
  final void Function()? onSave;
  final String fullName;

  @override
  State<UserImage> createState() => _UserImageState();
}

class _UserImageState extends State<UserImage> {
  File? _pickedImageFile;
  final currentUser = FirebaseAuth.instance.currentUser!;

  void _pickImageGallery() async {
    final pickedImage = await ImagePicker().pickImage(
        source: ImageSource.gallery, imageQuality: 100, maxWidth: 150);
    if (pickedImage == null) {
      return;
    }
    setState(() {
      _pickedImageFile = File(pickedImage.path);
    });
    widget.onPickImage(_pickedImageFile!);
  }

  void _pickImageCamera() async {
    final pickedImage = await ImagePicker().pickImage(
        source: ImageSource.camera, imageQuality: 100, maxWidth: 150);
    if (pickedImage == null) {
      return;
    }
    setState(() {
      _pickedImageFile = File(pickedImage.path);
    });
    widget.onPickImage(_pickedImageFile!);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(shape: BoxShape.circle),
      child: Center(
        child: Column(
          children: [
            Stack(
              children: [
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('Users')
                      .doc(currentUser.email)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final userData =
                          snapshot.data!.data() as Map<String, dynamic>;

                      if (userData['imageUrl'] == 'No Image uploaded yet') {
                        return Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(60),
                              color: text1),
                          child: const Icon(
                            Icons.image,
                            size: 65,
                          ),
                        );
                      } else {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(60),
                          child: Image.network(
                            userData['imageUrl'],
                            height: 120,
                            width: 120,
                            fit: BoxFit.cover,
                          ),
                        );
                      }
                    }
                    if (snapshot.hasError) {
                      return const Text('Error found');
                    }

                    return const Text('No data fetched');
                  },
                ),
                Opacity(
                  opacity: 0,
                  child: Container(
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey),
                    child: _pickedImageFile != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.file(
                              _pickedImageFile!,
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: text1),
                            child: const Icon(
                              Icons.image,
                              size: 60,
                            ),
                          ),
                  ),
                ),
                Positioned(
                  top: 70,
                  right: 0,
                  child: IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            backgroundColor: text2,
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: _pickImageGallery,
                                  child: const Text(
                                    'Gallery',
                                    style:
                                        TextStyle(color: backgroundColor1),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 100),
                                  child: TextButton(
                                      onPressed: _pickImageCamera,
                                      child: const Text('Camera',
                                          style: TextStyle(
                                              color: backgroundColor1))),
                                ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                  onPressed: widget.onSave,
                                  child: const Text('Save')),
                              TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _pickedImageFile == null;
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Cancel'))
                            ],
                          ),
                        );

                        // Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.edit,
                        size: 30,
                        color: backgroundColor1,
                      )),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              widget.fullName,
              textAlign: TextAlign.center,
              style:
                  GoogleFonts.bebasNeue(fontSize: 30, color: backgroundColor1),
            )
          ],
        ),
      ),
    );
  }
}
