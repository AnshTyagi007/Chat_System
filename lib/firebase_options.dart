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
    apiKey: 'AIzaSyC-HlMpIKA3LSBBVHcjQKiSipNKVgGgATs',
    appId: '1:966356332630:web:9691a104cbdf1cbba04bf7',
    messagingSenderId: '966356332630',
    projectId: 'learning-flutter-a6e55',
    authDomain: 'learning-flutter-a6e55.firebaseapp.com',
    storageBucket: 'learning-flutter-a6e55.appspot.com',
    measurementId: 'G-W13WN72YL4',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBJntc0xNrpznWGIhdbgaUVSsoGqUY_VC0',
    appId: '1:966356332630:android:576cd5457a26d205a04bf7',
    messagingSenderId: '966356332630',
    projectId: 'learning-flutter-a6e55',
    storageBucket: 'learning-flutter-a6e55.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCgX3PsedxYsmTsFsY31bwANW0m800ehbo',
    appId: '1:966356332630:ios:bd824db7875e8381a04bf7',
    messagingSenderId: '966356332630',
    projectId: 'learning-flutter-a6e55',
    storageBucket: 'learning-flutter-a6e55.appspot.com',
    iosBundleId: 'com.example.chatSystem',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCgX3PsedxYsmTsFsY31bwANW0m800ehbo',
    appId: '1:966356332630:ios:bd824db7875e8381a04bf7',
    messagingSenderId: '966356332630',
    projectId: 'learning-flutter-a6e55',
    storageBucket: 'learning-flutter-a6e55.appspot.com',
    iosBundleId: 'com.example.chatSystem',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyC-HlMpIKA3LSBBVHcjQKiSipNKVgGgATs',
    appId: '1:966356332630:web:0ed415ee3eb83901a04bf7',
    messagingSenderId: '966356332630',
    projectId: 'learning-flutter-a6e55',
    authDomain: 'learning-flutter-a6e55.firebaseapp.com',
    storageBucket: 'learning-flutter-a6e55.appspot.com',
    measurementId: 'G-NV6F953J9V',
  );
}
