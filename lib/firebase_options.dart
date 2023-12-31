// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAI3nD-SIBW71sBCnC8hz0CRW3uq8mwWW4',
    appId: '1:356718301171:web:d8fd47e560162664f24c86',
    messagingSenderId: '356718301171',
    projectId: 'dr-booking-4cf98',
    authDomain: 'dr-booking-4cf98.firebaseapp.com',
    storageBucket: 'dr-booking-4cf98.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBSgJrjRFUyxxvclJO8BX9SQxkP0mGP4t8',
    appId: '1:356718301171:android:5edddaf192c80b47f24c86',
    messagingSenderId: '356718301171',
    projectId: 'dr-booking-4cf98',
    storageBucket: 'dr-booking-4cf98.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDbbjZHleCSW1i2-Wvicw-ybD0P7ynkaQI',
    appId: '1:356718301171:ios:ed6651a8cb738158f24c86',
    messagingSenderId: '356718301171',
    projectId: 'dr-booking-4cf98',
    storageBucket: 'dr-booking-4cf98.appspot.com',
    iosClientId:
        '356718301171-bbqopq0p650jfjjhsncf8nlkr0lcii57.apps.googleusercontent.com',
    iosBundleId: 'com.example.doximity',
  );
}
