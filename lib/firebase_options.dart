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
    apiKey: 'AIzaSyCPfEKIT6hFrkBSIubo3Eoo25EE9ms3L-A',
    appId: '1:263568229718:web:e2d28bfed6853fa39302f7',
    messagingSenderId: '263568229718',
    projectId: 'chatapp-7495e',
    authDomain: 'chatapp-7495e.firebaseapp.com',
    storageBucket: 'chatapp-7495e.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDHk2Kc0TnZVmB9LILNdUb_GxWnjEd5I9w',
    appId: '1:263568229718:android:93d33568e46e071d9302f7',
    messagingSenderId: '263568229718',
    projectId: 'chatapp-7495e',
    storageBucket: 'chatapp-7495e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDY-cNZV9lG6iSrvGbhnV9i_ruXVbO5r40',
    appId: '1:263568229718:ios:fa9d057c0bc557569302f7',
    messagingSenderId: '263568229718',
    projectId: 'chatapp-7495e',
    storageBucket: 'chatapp-7495e.appspot.com',
    iosClientId: '263568229718-lcjt5r8pf12n4lr15tv2uvilbjquvqba.apps.googleusercontent.com',
    iosBundleId: 'com.example.chatApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDY-cNZV9lG6iSrvGbhnV9i_ruXVbO5r40',
    appId: '1:263568229718:ios:0766bb613a79cb749302f7',
    messagingSenderId: '263568229718',
    projectId: 'chatapp-7495e',
    storageBucket: 'chatapp-7495e.appspot.com',
    iosClientId: '263568229718-gnk469q11kgqkjlrahu8kquru3rj19uf.apps.googleusercontent.com',
    iosBundleId: 'com.example.chatApp.RunnerTests',
  );
}