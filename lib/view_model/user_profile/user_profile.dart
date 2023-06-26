import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doximity/view/complete_profile/complete_profile.dart';
import 'package:doximity/view/complete_profile/edite_profile.dart';
import 'package:doximity/view/home/mainhomescreen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class UserProfile with ChangeNotifier {
  bool isProfileLoding = false;
  bool isProfileUpdateLoding = false;
  File? file;
  bool isLoding = false;
  String? pickedFile;
  void pickFile() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      file = File(result.files.single.path ?? "");
      pickedFile = result.names.first;
      notifyListeners();
    }
  }

  Future<String?> uploadFile(String userId) async {
    if (file == null) {
      return null;
    }
    final path = 'files/$userId.jpeg';
    final ref = FirebaseStorage.instance.ref().child(path);

    var uploadTask = await ref.putFile(file!);
    notifyListeners();
    return await uploadTask.ref.getDownloadURL();
  }

  final CollectionReference users =
      FirebaseFirestore.instance.collection('userProfile');
  final myUid = FirebaseAuth.instance.currentUser!.uid;

  Future addUserProfile(BuildContext context) async {
    isProfileLoding = true;
    var userRef = users.doc(myUid);
    String? profilePicUrl = await uploadFile(userRef.id);
    if (profilePicUrl == null) {
      return null;
    }
    final userData = {
      'userName': CompleteProfile.userName.text,
      'profilePic': profilePicUrl,
      'userUid': myUid
    };
    userRef.set(userData).then(
          (value) => {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => MainScreen(),
              ),
              (route) => false,
            ),
          },
        );
    isProfileLoding = false;
  }

  Future editeUserProfile(BuildContext context) async {
    isProfileUpdateLoding = true;
    var userRef = users.doc(myUid);
    String? profilePicUrl = await uploadFile(userRef.id);
    if (profilePicUrl == null) {
      return null;
    }
    final userData = {
      'userName': CompleteProfileEdite.userName.text,
      'profilePic': profilePicUrl,
      'userUid': myUid
    };
    userRef.update(userData).then((value) => Navigator.pop(context));
    isProfileUpdateLoding = false;
  }
}
