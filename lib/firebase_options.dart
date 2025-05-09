// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyBaQPf8LcM4vMZ2Sp0h1uSkVwQPc1539n0',
    appId: '1:267982723777:web:c3d884214b327d1f1b5240',
    messagingSenderId: '267982723777',
    projectId: 'senior-project-67961',
    authDomain: 'senior-project-67961.firebaseapp.com',
    storageBucket: 'senior-project-67961.firebasestorage.app',
    measurementId: 'G-E0RXVBQENK',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBEAedW4DTlMGovfwh9acX5HqPCudIrQPI',
    appId: '1:267982723777:android:55039d8315f9f2dc1b5240',
    messagingSenderId: '267982723777',
    projectId: 'senior-project-67961',
    storageBucket: 'senior-project-67961.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDHCh3CkLYj0lm-A6CxXaFZoyrCdy3Juck',
    appId: '1:267982723777:ios:14a45f6265abe7311b5240',
    messagingSenderId: '267982723777',
    projectId: 'senior-project-67961',
    storageBucket: 'senior-project-67961.firebasestorage.app',
    iosBundleId: 'com.example.autoExpenseTracker',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDHCh3CkLYj0lm-A6CxXaFZoyrCdy3Juck',
    appId: '1:267982723777:ios:14a45f6265abe7311b5240',
    messagingSenderId: '267982723777',
    projectId: 'senior-project-67961',
    storageBucket: 'senior-project-67961.firebasestorage.app',
    iosBundleId: 'com.example.autoExpenseTracker',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBaQPf8LcM4vMZ2Sp0h1uSkVwQPc1539n0',
    appId: '1:267982723777:web:31c5ca333659d64d1b5240',
    messagingSenderId: '267982723777',
    projectId: 'senior-project-67961',
    authDomain: 'senior-project-67961.firebaseapp.com',
    storageBucket: 'senior-project-67961.firebasestorage.app',
    measurementId: 'G-L64LFDVDLX',
  );

}