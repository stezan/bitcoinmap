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
    apiKey: 'AIzaSyC4ZWiDq7KNRnwwXxfXm15rYqQqrYJ-8fo',
    appId: '1:719479606452:web:42264a1899c8bca5ec9be1',
    messagingSenderId: '719479606452',
    projectId: 'bitcoin-map-13228',
    authDomain: 'bitcoin-map-13228.firebaseapp.com',
    storageBucket: 'bitcoin-map-13228.firebasestorage.app',
    measurementId: 'G-V13BMHX7FT',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDoMbfa0slHkXveMVLGSV81uJ7w_8hwBC0',
    appId: '1:719479606452:android:34604d4117156fbfec9be1',
    messagingSenderId: '719479606452',
    projectId: 'bitcoin-map-13228',
    storageBucket: 'bitcoin-map-13228.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCq7ILX8fC6L_uQepBPyOcP0ryfxWvgjlc',
    appId: '1:719479606452:ios:58c1d88eaa99ff00ec9be1',
    messagingSenderId: '719479606452',
    projectId: 'bitcoin-map-13228',
    storageBucket: 'bitcoin-map-13228.firebasestorage.app',
    iosBundleId: 'com.stzan.bitcoinmap.bitcoinMap',
  );
}
