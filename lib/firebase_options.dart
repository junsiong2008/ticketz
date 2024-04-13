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
    apiKey: 'AIzaSyBKQcLbgTN-kK86Bob7supOnDXCqtkLfEE',
    appId: '1:926544606239:web:ae2b49c8b3802cc70e912a',
    messagingSenderId: '926544606239',
    projectId: 'cw-bsmm-2022',
    authDomain: 'cw-bsmm-2022.firebaseapp.com',
    storageBucket: 'cw-bsmm-2022.appspot.com',
    measurementId: 'G-WYGXKD7QXP',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAV88OYE-79guM8vVvEQ7v8s_LJUttpO00',
    appId: '1:926544606239:android:d7c67ff0a6e6beeb0e912a',
    messagingSenderId: '926544606239',
    projectId: 'cw-bsmm-2022',
    storageBucket: 'cw-bsmm-2022.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB5-5EDtPBjplqWTiGvA4uFZdqhF--LfDE',
    appId: '1:926544606239:ios:14bef092d06263e80e912a',
    messagingSenderId: '926544606239',
    projectId: 'cw-bsmm-2022',
    storageBucket: 'cw-bsmm-2022.appspot.com',
    iosClientId: '926544606239-2ncije9gmhgsv268nuke8a6u5mv8ejql.apps.googleusercontent.com',
    iosBundleId: 'com.jsdevexperiment.ticketz',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB5-5EDtPBjplqWTiGvA4uFZdqhF--LfDE',
    appId: '1:926544606239:ios:14bef092d06263e80e912a',
    messagingSenderId: '926544606239',
    projectId: 'cw-bsmm-2022',
    storageBucket: 'cw-bsmm-2022.appspot.com',
    iosClientId: '926544606239-2ncije9gmhgsv268nuke8a6u5mv8ejql.apps.googleusercontent.com',
    iosBundleId: 'com.jsdevexperiment.ticketz',
  );
}
