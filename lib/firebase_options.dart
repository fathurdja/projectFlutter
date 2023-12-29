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
        return macos;
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
    apiKey: 'AIzaSyDXr8Hhq7159wsYB3U07BehGQmU4LCv-6g',
    appId: '1:528091540129:web:83db280c525f6176b09ee0',
    messagingSenderId: '528091540129',
    projectId: 'projectlapangan-8b86a',
    authDomain: 'projectlapangan-8b86a.firebaseapp.com',
    storageBucket: 'projectlapangan-8b86a.appspot.com',
    measurementId: 'G-57KGXPLBRD',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyApqIR2qkoRjS_Y6HcswWm1_-S48Y310vM',
    appId: '1:528091540129:android:6b79fa7e8693e10bb09ee0',
    messagingSenderId: '528091540129',
    projectId: 'projectlapangan-8b86a',
    storageBucket: 'projectlapangan-8b86a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDpHHwaxU5cY0TWp1RsARSaWEktxYQl-uM',
    appId: '1:528091540129:ios:0e5815d647a77acfb09ee0',
    messagingSenderId: '528091540129',
    projectId: 'projectlapangan-8b86a',
    storageBucket: 'projectlapangan-8b86a.appspot.com',
    iosBundleId: 'com.example.lapanganku',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDpHHwaxU5cY0TWp1RsARSaWEktxYQl-uM',
    appId: '1:528091540129:ios:515202b2f3336d31b09ee0',
    messagingSenderId: '528091540129',
    projectId: 'projectlapangan-8b86a',
    storageBucket: 'projectlapangan-8b86a.appspot.com',
    iosBundleId: 'com.example.lapanganku.RunnerTests',
  );
}
