import 'dart:developer';

import 'package:doximity/view/complete_profile/complete_profile.dart';
import 'package:doximity/view_model/network_error_handling/network_error_handling.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:overlay_support/overlay_support.dart';

class AuthProvider with ChangeNotifier {
  GoogleSignInAccount? _user;
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount get user => _user!;
  final FirebaseAuth _fb;
  AuthProvider(this._fb);
  bool isLoading = false;
  bool isGoogleLoding = false;
  bool isSignUpLoding = false;
  Stream<User?> stream() => _fb.authStateChanges();
  bool get loading => isLoading;

  //-----------------Sign in function--------------------------//
  Future signIn(String email, String password, BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();

      await _fb
          .signInWithEmailAndPassword(
            email: email.trim().toLowerCase(),
            password: password.trim(),
          )
          .then(
            (value) => {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const CompleteProfile(),
                ),
                (route) => false,
              ),
            },
          );
      isLoading = false;
      notifyListeners();
      return Future.value('');
    } on FirebaseAuthException catch (ex) {
      isLoading = false;
      notifyListeners();
      return Future.value(ex.message);
    }
  }
  //******************************************************************//

  //-------------------------Sign Out function--------------------//

  Future<void> signOut(BuildContext context) async {
    await _fb.signOut().then(
          (value) => {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => const HomeScreen(),
              ),
              (route) => false,
            ),
          },
        );
  }

  //***************************************************************//

  //-----------------------------SigUp function-------------------//

  Future signUp(String email, String password, BuildContext context) async {
    try {
      isSignUpLoding = true;
      notifyListeners();
      await _fb
          .createUserWithEmailAndPassword(
              email: email.trim(), password: password.trim())
          .then(
            (value) => {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const CompleteProfile(),
                ),
                (route) => false,
              ),
            },
          );

      isSignUpLoding = false;
      notifyListeners();
      return Future.value('');
    } on FirebaseAuthException catch (ex) {
      isSignUpLoding = false;
      notifyListeners();
      log(ex.message!);
      log(ex.toString());
      return Future.value(ex.message);
    }
  }

  //**************************************************************//

  //-------------Google Login-------------------------------------//

  Future googleLoigin(BuildContext context) async {
    try {
      isGoogleLoding = true;
      notifyListeners();
      final isLogged = await GoogleSignIn().isSignedIn();
      if (isLogged) GoogleSignIn().signOut();
      final result = await GoogleSignIn().signIn();
      if (result == null) {
        isGoogleLoding = false;
        notifyListeners();
        return Future.value('Occured an error while sign in.');
      }
      final cred = await result.authentication;
      final exists = await _fb.fetchSignInMethodsForEmail(result.email);
      if (exists.isEmpty) {
        isGoogleLoding = false;
        notifyListeners();
        return Future.value('User Dose Not exist  !');
      }
      await _fb
          .signInWithCredential(GoogleAuthProvider.credential(
              accessToken: cred.accessToken, idToken: cred.idToken))
          .then(
            (value) => {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const CompleteProfile(),
                ),
                (route) => false,
              ),
            },
          );
      isGoogleLoding = false;
      notifyListeners();
      return Future.value('');
      // Use the authentication token to sign in the user to  app's backend server
    } on FirebaseAuthException catch (ex) {
      isGoogleLoding = false;
      notifyListeners();
      return Future.value(ex.message);
    }
  }

  Future googleSigUp(BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();
      final isLogged = await GoogleSignIn().isSignedIn();
      if (isLogged) GoogleSignIn().signOut();
      final result = await GoogleSignIn().signIn();
      if (result == null) {
        isGoogleLoding = false;
        notifyListeners();
        return Future.value('Occured an error while sign in.');
      }
      final cred = await result.authentication;
      final exists = await _fb.fetchSignInMethodsForEmail(result.email);
      if (exists.isNotEmpty) {
        isLoading = false;
        notifyListeners();
        return Future.value('User Dose Not exist  !.');
      }
      await _fb
          .signInWithCredential(GoogleAuthProvider.credential(
              accessToken: cred.accessToken, idToken: cred.idToken))
          .then(
            (value) => {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const CompleteProfile(),
                ),
                (route) => false,
              ),
            },
          );
      isLoading = false;
      notifyListeners();
      return Future.value('');
      // Use the authentication token to sign in the user to  app's backend server
    } on FirebaseAuthException catch (ex) {
      isLoading = false;
      notifyListeners();
      log(ex.message!);
      log(ex.toString());
      return Future.value(ex.message);
    }
  }
  //*********************************************************************//

  //-------reset Password------------------------------------------------//

  Future restPassword(BuildContext context, String email) async {
    try {
      isLoading = true;
      notifyListeners();
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: email)
          .then((value) => Navigator.pop(context));
      isLoading = false;
      notifyListeners();
    } on FirebaseAuthException catch (ex) {
      isLoading = false;
      notifyListeners();
      return Future.value(ex.message);
    }
  }
  //*********************************************************************//

  //-----------erorr---------------------------------------------------//

  OverlaySupportEntry erorr(msg) {
    return showOverlayNotification((context) {
      return Card(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        child: SafeArea(
          child: ListTile(
            leading: SizedBox.fromSize(
              size: const Size(40, 40),
              child: ClipOval(
                child: Container(
                  color: Colors.black,
                  child: const Center(
                    child: Icon(
                      Icons.error_outline_rounded,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            title: Text(msg),
            //subtitle: const Text('Thanks for checking out my tutorial'),
            trailing: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  OverlaySupportEntry.of(context)?.dismiss();
                }),
          ),
        ),
      );
    }, duration: const Duration(seconds: 1));
  }
  //*********************************************************************//
}
