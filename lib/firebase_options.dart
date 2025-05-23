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
    apiKey: 'AIzaSyB58nhtGLdtHfFqsDvDlve3bhB6suGsVlY',
    appId: '1:570679449818:web:cdc1a47f2c5d7a71e1ede3',
    messagingSenderId: '570679449818',
    projectId: 'tvapp-25890',
    authDomain: 'tvapp-25890.firebaseapp.com',
    storageBucket: 'tvapp-25890.firebasestorage.app',
    measurementId: 'G-0YTC0VJX43',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCDzRLh1jkZH8nhS4GtLtH6xP3_R6qlE1k',
    appId: '1:570679449818:android:8a3cb7a1cbf9146ee1ede3',
    messagingSenderId: '570679449818',
    projectId: 'tvapp-25890',
    storageBucket: 'tvapp-25890.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDshWbmIvzNsWDf9N_OPIuTgq7ETvJ2u24',
    appId: '1:570679449818:ios:d12b0a9ca7939db1e1ede3',
    messagingSenderId: '570679449818',
    projectId: 'tvapp-25890',
    storageBucket: 'tvapp-25890.firebasestorage.app',
    iosBundleId: 'com.ecom.hello.ecomarceHello',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDshWbmIvzNsWDf9N_OPIuTgq7ETvJ2u24',
    appId: '1:570679449818:ios:d12b0a9ca7939db1e1ede3',
    messagingSenderId: '570679449818',
    projectId: 'tvapp-25890',
    storageBucket: 'tvapp-25890.firebasestorage.app',
    iosBundleId: 'com.ecom.hello.ecomarceHello',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyB58nhtGLdtHfFqsDvDlve3bhB6suGsVlY',
    appId: '1:570679449818:web:3a394a6d865b7c3ce1ede3',
    messagingSenderId: '570679449818',
    projectId: 'tvapp-25890',
    authDomain: 'tvapp-25890.firebaseapp.com',
    storageBucket: 'tvapp-25890.firebasestorage.app',
    measurementId: 'G-Q8MWF7V2T9',
  );
}
