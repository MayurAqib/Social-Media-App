import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_posting/pages/profile.page.dart';
import 'package:social_posting/theme/colors.dart';
import 'package:social_posting/widgets/my_button.dart';
import 'package:social_posting/widgets/my_drawer.dart';
import 'package:social_posting/widgets/my_textfield.dart';
import 'package:social_posting/widgets/wall_post.dart';

import '../services/services_methods.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _wallController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser!;

  void postMessage() async {
    //only post if there in the textfield
    if (_wallController.text.isEmpty) {
      return;
    }

    //! fetching data from firestore{
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(user.email)
        .get();
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
//!   }

    await FirebaseFirestore.instance.collection('User Posts').add({
      'UserName': data['Name'],
      'Message': _wallController.text,
      'UserEmail': data['email'],
      'TimeStamp': Timestamp.now(),
      'Likes': [],
      'imageUrl': data['imageUrl']
    });

    //clear the textfield
    setState(() {
      _wallController.clear();
    });

    // ignore: use_build_context_synchronously
    FocusScope.of(context).unfocus();
  }

  // navigate to profile page
  void goToProfile() {
    //pop the drawer menu
    Navigator.pop(context);
    //go to profile page
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const ProfilePage()));
  }

  //post message
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor1,
        drawer: MyDrawer(
          onProfileTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfilePage(),
                ));
          },
          onSignOut: () {
            FirebaseAuth.instance.signOut();
          },
        ),
        appBar: AppBar(
          backgroundColor: backgroundColor1,
          elevation: 0,
          title: const Text(
            'The Wall',
            style: TextStyle(color: text2),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            //the wall
            Expanded(
                child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('User Posts')
                  .orderBy('TimeStamp', descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      //get the message
                      final post = snapshot.data!.docs[index];
                      return WallPost(
                        imageUrl: post['imageUrl'],
                        message: post['Message'],
                        name: post['UserEmail'],
                        user: post['UserName'],
                        time: formatDate(post['TimeStamp']),
                        postId: post.id,
                        likes: List<String>.from(post['Likes'] ?? []),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error.toString()}'),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            )),
            //post message
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                      child: MyTextfield(
                          hintText: 'write something on the wall..',
                          controller: _wallController,
                          obscureText: false)),
                  const SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: MyButton(
                      buttonText: 'Post',
                      onTap: postMessage,
                      width: 80,
                      height: 40,
                    ),
                  )
                ],
              ),
            )
            //logged in as
          ],
        ));
  }
}
