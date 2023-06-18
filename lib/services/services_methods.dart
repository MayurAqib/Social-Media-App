//return the formatted data as a striong

import 'package:cloud_firestore/cloud_firestore.dart';

String formatDate(Timestamp timestamp) {
  DateTime dateTime = timestamp.toDate();
  // timestamp is the object we retrieve from firebase

  //get year
  String year = dateTime.year.toString();

  //get month
  String month = dateTime.month.toString();

  //get day
  String day = dateTime.day.toString();
  String hour = dateTime.hour.toString();
  String minute = dateTime.minute.toString();
  String formattedTime = '$hour:$minute  $day/$month/$year';
  return formattedTime;
}
