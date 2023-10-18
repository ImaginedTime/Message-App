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
    apiKey: 'AIzaSyD4mz-ceM7VjUOc5A_WAhtpINAA4otmjFQ',
    appId: '1:805257817236:web:da27a1da056638c2c59881',
    messagingSenderId: '805257817236',
    projectId: 'chatapp-3978f',
    authDomain: 'chatapp-3978f.firebaseapp.com',
    storageBucket: 'chatapp-3978f.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDER--3wZjiq41QcX6m868eWaiHpUyALEc',
    appId: '1:805257817236:android:6ce77dfce5a4d7fcc59881',
    messagingSenderId: '805257817236',
    projectId: 'chatapp-3978f',
    storageBucket: 'chatapp-3978f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCHWg-yiWKUeO9w1BaufRYPORHnBeHkEwU',
    appId: '1:805257817236:ios:f80bcb5ee55008fac59881',
    messagingSenderId: '805257817236',
    projectId: 'chatapp-3978f',
    storageBucket: 'chatapp-3978f.appspot.com',
    iosBundleId: 'com.example.chatapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCHWg-yiWKUeO9w1BaufRYPORHnBeHkEwU',
    appId: '1:805257817236:ios:ab3769826903e3c4c59881',
    messagingSenderId: '805257817236',
    projectId: 'chatapp-3978f',
    storageBucket: 'chatapp-3978f.appspot.com',
    iosBundleId: 'com.example.chatapp.RunnerTests',
  );
}
