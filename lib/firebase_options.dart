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
    apiKey: 'AIzaSyARU1-8H9rWqVSU5lrkkdLK-UL9Gy-xzsA',
    appId: '1:1063268305060:web:99fa5c0a60ef452aa97e31',
    messagingSenderId: '1063268305060',
    projectId: 'zolatte-assignment-7a13a',
    authDomain: 'zolatte-assignment-7a13a.firebaseapp.com',
    storageBucket: 'zolatte-assignment-7a13a.appspot.com',
    measurementId: 'G-6MK07VXCXQ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBBYFPG6rPCb38ZqklLAgJQznQLepQ4fbQ',
    appId: '1:1063268305060:android:5b79c5cdb1a3cf33a97e31',
    messagingSenderId: '1063268305060',
    projectId: 'zolatte-assignment-7a13a',
    storageBucket: 'zolatte-assignment-7a13a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDjOzMc6ODYJwq2e5uKdCGxVcQoakAoktY',
    appId: '1:1063268305060:ios:dda4a659fb13364ea97e31',
    messagingSenderId: '1063268305060',
    projectId: 'zolatte-assignment-7a13a',
    storageBucket: 'zolatte-assignment-7a13a.appspot.com',
    androidClientId: '1063268305060-g3l9f2v18j4vqcdeqa6sivergv3p7laq.apps.googleusercontent.com',
    iosClientId: '1063268305060-rdrehn20l4vr234tcf7putnc83i6chrb.apps.googleusercontent.com',
    iosBundleId: 'com.example.zolatteAssignment',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDjOzMc6ODYJwq2e5uKdCGxVcQoakAoktY',
    appId: '1:1063268305060:ios:dda4a659fb13364ea97e31',
    messagingSenderId: '1063268305060',
    projectId: 'zolatte-assignment-7a13a',
    storageBucket: 'zolatte-assignment-7a13a.appspot.com',
    androidClientId: '1063268305060-g3l9f2v18j4vqcdeqa6sivergv3p7laq.apps.googleusercontent.com',
    iosClientId: '1063268305060-rdrehn20l4vr234tcf7putnc83i6chrb.apps.googleusercontent.com',
    iosBundleId: 'com.example.zolatteAssignment',
  );
}