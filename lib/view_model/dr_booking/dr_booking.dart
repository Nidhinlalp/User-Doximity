import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doximity/model/doctorbooking/dr_booking.dart';

final CollectionReference allBookedDrDeteils =
    FirebaseFirestore.instance.collection('appointment');

Stream<List<BookingDrDetails>> getAllBookedDrStream() {
  return allBookedDrDeteils.snapshots().map((snapshot) {
    return snapshot.docs.map((doc) {
      log('hasdata${doc.data()}');
      return BookingDrDetails.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();
  });
}
