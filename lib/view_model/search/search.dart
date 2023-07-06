import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Search with ChangeNotifier {
  List searchResult = [];
  TextEditingController textEditingController = TextEditingController();

  final data = FirebaseFirestore.instance.collection('doctors');

  void searchFromFirebase(String query) async {
    final result = await FirebaseFirestore.instance
        .collection('doctors')
        .where('name', isGreaterThanOrEqualTo: query.toUpperCase())
        .get();

    searchResult = result.docs.map((e) => e.data()).toList();
    notifyListeners();
  }
}
