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
    apiKey: 'AIzaSyBraEisOZXx5RVvF0nDIf3FHWkZMi9kNgM',
    appId: '1:1026102640133:web:b884724849617afe71a66c',
    messagingSenderId: '1026102640133',
    projectId: 'issandronotes',
    authDomain: 'issandronotes.firebaseapp.com',
    storageBucket: 'issandronotes.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDn8nz3Ba_pgfWP5qrxt5WX_Q_xmm0bVJM',
    appId: '1:1026102640133:android:292148c4eeb6d1f471a66c',
    messagingSenderId: '1026102640133',
    projectId: 'issandronotes',
    storageBucket: 'issandronotes.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAUGxR2oloRdG5g_8V-s6iM94YlfB8QGAI',
    appId: '1:1026102640133:ios:59b73e3d4a15c36f71a66c',
    messagingSenderId: '1026102640133',
    projectId: 'issandronotes',
    storageBucket: 'issandronotes.appspot.com',
    iosClientId: '1026102640133-011l68aq18kjn7mtclpn3irefqj3p5d1.apps.googleusercontent.com',
    iosBundleId: 'com.abdihakimomar.notebook',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAUGxR2oloRdG5g_8V-s6iM94YlfB8QGAI',
    appId: '1:1026102640133:ios:59b73e3d4a15c36f71a66c',
    messagingSenderId: '1026102640133',
    projectId: 'issandronotes',
    storageBucket: 'issandronotes.appspot.com',
    iosClientId: '1026102640133-011l68aq18kjn7mtclpn3irefqj3p5d1.apps.googleusercontent.com',
    iosBundleId: 'com.abdihakimomar.notebook',
  );
}
