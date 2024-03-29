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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBcbRzf8J3zio1XSw836gNjgdVp0txyGII',
    appId: '1:606763393920:android:8d24bc91923310aa8b1765',
    messagingSenderId: '606763393920',
    projectId: 'centre-alliance-sport-sante',
    storageBucket: 'centre-alliance-sport-sante.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCSLKNgB8nP7QL_TawN_LV5mtT5rgUIupQ',
    appId: '1:606763393920:ios:25d166cc181210c68b1765',
    messagingSenderId: '606763393920',
    projectId: 'centre-alliance-sport-sante',
    storageBucket: 'centre-alliance-sport-sante.appspot.com',
    iosClientId:
        '606763393920-6vhoe3eej5l32a1l6rh6r7a8s2ehlan3.apps.googleusercontent.com',
    iosBundleId: 'com.rlebranchu.centreAllianceSportSante',
  );
}
