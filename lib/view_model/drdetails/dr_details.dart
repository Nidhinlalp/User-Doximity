import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doximity/model/doctormodel/doctor_model.dart';

final CollectionReference allDoctorsDeteils =
    FirebaseFirestore.instance.collection('doctors');
Stream<List<AllDoctorsDetails>> getAlldoctorStream() {
  return allDoctorsDeteils.snapshots().map((snapshot) {
    return snapshot.docs.map((doc) {
      return AllDoctorsDetails.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();
  });
}
