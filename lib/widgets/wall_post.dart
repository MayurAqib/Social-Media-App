// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_posting/services/services_methods.dart';
import 'package:social_posting/theme/colors.dart';
import 'package:social_posting/widgets/comment_button.dart';
import 'package:social_posting/widgets/comments.dart';
import 'package:social_posting/widgets/like_button.dart';

class WallPost extends StatefulWidget {
  const WallPost(
      {super.key,
      required this.message,
      required this.user,
      required this.likes,
      required this.postId,
      required this.time,
      required this.imageUrl,
      required this.name});
  final String message;
  final String user;
  final String postId;
  final String time;
  final List<String> likes;
  final String imageUrl;
  final String name;

  @override
  State<WallPost> createState() => _WallPostState();
}

class _WallPostState extends State<WallPost> {
  final _commentController = TextEditingController(); //! CONTROLLER
  final currentUser = FirebaseAuth.instance.currentUser!;
  bool isLiked = false;
  @override
  void initState() {
    super.initState();
    isLiked = widget.likes.contains(currentUser.email);
  }

  //toggleLikes
  void toggleLikes() {
    setState(() {
      isLiked = !isLiked;
    });

    // access the document in firebase
    DocumentReference postRef =
        FirebaseFirestore.instance.collection('User Posts').doc(widget.postId);

    if (isLiked) {
      // if the post is now liked, add the users email to the 'likes' field
      postRef.update({
        'Likes': FieldValue.arrayUnion([currentUser.email])
      });
    } else {
      //if the post is now unliked, remove the users email from the 'likes' field
      postRef.update({
        'Likes': FieldValue.arrayRemove([currentUser.email])
      });
    }
  }

  // add comment function
  void addComment(String commentText) async {
    //! fetching data from firestore{
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(currentUser.email)
        .get();
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
//!   }

    // write the comment to firestore under the comments collection for this post
    FirebaseFirestore.instance
        .collection('User Posts')
        .doc(widget.postId)
        .collection('Comments')
        .add({
      'CommentText': commentText,
      'CommentedBy': data['Name'],
      'CommentTime': Timestamp.now(),
      // 'imageUrl':
    });
  }

  //show the dialog box for adding comment
  void showCommentDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Comment'),
        content: TextField(
          controller: _commentController,
          decoration: const InputDecoration(hintText: 'Write a comment..'),
        ),
        actions: [
          // post button
          TextButton(
            onPressed: () {
              addComment(_commentController.text);
              Navigator.pop(context);
              _commentController.clear();
            },
            child: const Text('Save'),
          ),

          //cancel button
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _commentController.clear();
            },
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  //todo: Delete Post
  void deletePost() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.grey.shade900,
              title: const Text(
                'Are you sure?',
                style: TextStyle(color: Colors.white),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel',
                      style: TextStyle(color: Colors.white)),
                ),
                TextButton(
                  onPressed: () async {
                    //!first delete the comments
                    final commentDocs = await FirebaseFirestore.instance
                        .collection('User Posts')
                        .doc(widget.postId)
                        .collection('Comments')
                        .get();
                    // ignore: unnecessary_null_comparison
                    if (commentDocs != null) {
                      for (var doc in commentDocs.docs) {
                        await FirebaseFirestore.instance
                            .collection('User Posts')
                            .doc(widget.postId)
                            .collection('Comments')
                            .doc(doc.id)
                            .delete();
                      }

                      //! delete the post
                      FirebaseFirestore.instance
                          .collection('User Posts')
                          .doc(widget.postId)
                          .delete()
                          .then((value) => print('post deleted'))
                          .catchError((error) =>
                              print('failed to delete post: $error'));
                    }
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                  },
                  child: const Text('Delete',
                      style: TextStyle(color: Colors.white)),
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 20, left: 20, bottom: 10),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: backgroundColor2),
        padding:
            const EdgeInsets.only(top: 20, bottom: 10, right: 20, left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          image: DecorationImage(
                              image: NetworkImage(widget.imageUrl),
                              fit: BoxFit.cover)),
                    ),
                    const SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.user,
                              style: TextStyle(
                                  color: Colors.grey.shade900,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            const SizedBox(width: 5),
                            Text(widget.time),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.message,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 15),
                        ),
                      ],
                    ),
                  ],
                ),

                //todo: delete button

                if (widget.name == currentUser.email)
                  GestureDetector(
                      onTap: deletePost, child: const Icon(Icons.delete))
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //?   LIKE
                Column(
                  children: [
                    // like button
                    LikeButton(isLiked: isLiked, onTap: toggleLikes),

                    // like count
                    Text(widget.likes.length.toString())
                  ],
                ),
                const SizedBox(width: 5),
                //?   COMMENT
                Column(
                  children: [
                    //comment button
                    CommentButton(
                      onTap: showCommentDialog,
                      id: widget.postId,
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 20),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('User Posts')
                  .doc(widget.postId)
                  .collection('Comments')
                  .orderBy('CommentTime', descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                //show loading circle till data comes
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return ListView(
                    shrinkWrap: true, //for nested list
                    physics: const NeverScrollableScrollPhysics(),
                    children: snapshot.data!.docs.map((doc) {
                      //get the comment
                      final commentData = doc.data() as Map<String, dynamic>;
                      //return the comment
                      return Comments(
                          // text: commentData['CommentText'],
                          text: commentData['CommentText'],
                          user: commentData['CommentedBy'],
                          time: formatDate(commentData['CommentTime']));
                    }).toList());
              },
            )
          ],
        ),
      ),
    );
  }
}
