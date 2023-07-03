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
    apiKey: 'AIzaSyDZNAu6WiN4SfCoIoXm1Kv_1zZOX1UpCqY',
    appId: '1:952077368785:web:1d54f64743565771dfb4f0',
    messagingSenderId: '952077368785',
    projectId: 'sie021-f9950',
    authDomain: 'sie021-f9950.firebaseapp.com',
    storageBucket: 'sie021-f9950.appspot.com',
    measurementId: 'G-0THVQ0D8XW',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD8Hqqq3Ppf02vMTqOQJlqv4XtwEbNQo4E',
    appId: '1:952077368785:android:a37dcf0b24cf4a23dfb4f0',
    messagingSenderId: '952077368785',
    projectId: 'sie021-f9950',
    storageBucket: 'sie021-f9950.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDnWbCRAhHL3lPgXSZwHC5BAJSapanlGrU',
    appId: '1:952077368785:ios:e0e6cb269bd3d850dfb4f0',
    messagingSenderId: '952077368785',
    projectId: 'sie021-f9950',
    storageBucket: 'sie021-f9950.appspot.com',
    iosClientId:
        '952077368785-dv7q1glru37qfvfggeqmtqbl1obpvlk6.apps.googleusercontent.com',
    iosBundleId: 'com.mycompany.sie021',
  );
}
