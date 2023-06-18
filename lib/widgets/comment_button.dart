import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_posting/theme/colors.dart';

class CommentButton extends StatelessWidget {
  const CommentButton({super.key, required this.onTap, required this.id});
  final void Function() onTap;
  final String id;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: const Icon(
            Icons.comment,
            color: text2,
          ),
        ),
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('User Posts')
              .doc(id)
              .collection('Comments')
              .snapshots(),
          builder: (BuildContext context, snapshot) {
            //show loading circle till data comes
            if (!snapshot.hasData) {
              return const Text('0');
            }

            return Text(snapshot.data!.docs.length.toString());
          },
        )
      ],
    );
  }
}
