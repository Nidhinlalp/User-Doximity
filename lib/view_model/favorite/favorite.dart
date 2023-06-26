import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doximity/model/doctormodel/doctor_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FavorteDr with ChangeNotifier {
  List<AllDoctorsDetails> _dr = [];

  List<AllDoctorsDetails> get dr => _dr;
  void toggleFavorite(AllDoctorsDetails dr) {
    var favRef = favDoctors.doc(FirebaseAuth.instance.currentUser!.uid);
    final isExist = _dr.contains(dr);
    if (isExist) {
      _dr.remove(dr);
    } else {
      _dr.add(dr);
    }
    notifyListeners();
    log(_dr.toString());
    favRef.set({'favourite': _dr.map((e) => e.toJson()).toList()});
  }

  bool isExist(AllDoctorsDetails dr) {
    final isExist = _dr.contains(dr);
    return isExist;
  }

  void clearFav() {
    var favRef = favDoctors.doc(FirebaseAuth.instance.currentUser!.uid);

    _dr = [];
    favRef.set({'favourite': _dr.map((e) => e.toJson()).toList()});
    log(_dr.toString());
    notifyListeners();
  }

  final CollectionReference favDoctors =
      FirebaseFirestore.instance.collection('favorateDoctors');
}
