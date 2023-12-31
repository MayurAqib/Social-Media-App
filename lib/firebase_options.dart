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
    apiKey: 'AIzaSyCz0p3XmR2loekDfQW49Z2htgrMLhRrqzk',
    appId: '1:140182591314:web:e2fac6392e7137a4b9cc8b',
    messagingSenderId: '140182591314',
    projectId: 'the-wall-2b951',
    authDomain: 'the-wall-2b951.firebaseapp.com',
    storageBucket: 'the-wall-2b951.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBgRO57zmsFMUiw5EV9IFyMCPhAeAhlAL0',
    appId: '1:140182591314:android:ac553420805e3c19b9cc8b',
    messagingSenderId: '140182591314',
    projectId: 'the-wall-2b951',
    storageBucket: 'the-wall-2b951.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCIdd7keM_5x5NVhn8pWJ2YjWnAatc5_vg',
    appId: '1:140182591314:ios:fcc85b123168043ab9cc8b',
    messagingSenderId: '140182591314',
    projectId: 'the-wall-2b951',
    storageBucket: 'the-wall-2b951.appspot.com',
    iosClientId: '140182591314-3jj5o3m18kafd1ukr7cku2lefcef05uj.apps.googleusercontent.com',
    iosBundleId: 'com.example.socialPosting',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCIdd7keM_5x5NVhn8pWJ2YjWnAatc5_vg',
    appId: '1:140182591314:ios:fcc85b123168043ab9cc8b',
    messagingSenderId: '140182591314',
    projectId: 'the-wall-2b951',
    storageBucket: 'the-wall-2b951.appspot.com',
    iosClientId: '140182591314-3jj5o3m18kafd1ukr7cku2lefcef05uj.apps.googleusercontent.com',
    iosBundleId: 'com.example.socialPosting',
  );
}
