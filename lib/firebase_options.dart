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
    apiKey: 'AIzaSyD5CAHbELgsD_uHPaC3zR4EJyzI3N4ozK4',
    appId: '1:25903687398:web:5b80211facc2770de1bd27',
    messagingSenderId: '25903687398',
    projectId: 'generator-commands-spg',
    authDomain: 'generator-commands-spg.firebaseapp.com',
    storageBucket: 'generator-commands-spg.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAH3ni04M5TT0Q7SUGpBwa5HK_dIPzuHL4',
    appId: '1:25903687398:android:83331e03f893bb96e1bd27',
    messagingSenderId: '25903687398',
    projectId: 'generator-commands-spg',
    storageBucket: 'generator-commands-spg.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAmIuhh5d2iv3i0QGiVAWIQ28vuMROCnnQ',
    appId: '1:25903687398:ios:872192286784a6c2e1bd27',
    messagingSenderId: '25903687398',
    projectId: 'generator-commands-spg',
    storageBucket: 'generator-commands-spg.appspot.com',
    iosBundleId: 'com.example.guardianCommandsCreator',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAmIuhh5d2iv3i0QGiVAWIQ28vuMROCnnQ',
    appId: '1:25903687398:ios:872192286784a6c2e1bd27',
    messagingSenderId: '25903687398',
    projectId: 'generator-commands-spg',
    storageBucket: 'generator-commands-spg.appspot.com',
    iosBundleId: 'com.example.guardianCommandsCreator',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD5CAHbELgsD_uHPaC3zR4EJyzI3N4ozK4',
    appId: '1:25903687398:web:c270fba57a8c16e6e1bd27',
    messagingSenderId: '25903687398',
    projectId: 'generator-commands-spg',
    authDomain: 'generator-commands-spg.firebaseapp.com',
    storageBucket: 'generator-commands-spg.appspot.com',
  );

}