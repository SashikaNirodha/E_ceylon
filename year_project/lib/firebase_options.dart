// File: lib/firebase_options.dart
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBeivhtrtKyX7QSTt-lld573KBrpxJlMNA',
    appId: '1:1006902598533:android:cc31e22bef31ade512c2ec',
    messagingSenderId: '1006902598533',
    projectId: 'eceylonunifiedapp',
    storageBucket: 'eceylonunifiedapp.firebasestorage.app',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCgkkmNsMejG2Aa-HOVgDTSWHPCn_DwySA',
    appId: '1:1006902598533:web:1862bbca4a3a830212c2ec',
    messagingSenderId: '1006902598533',
    projectId: 'eceylonunifiedapp',
    authDomain: 'eceylonunifiedapp.firebaseapp.com',
    storageBucket: 'eceylonunifiedapp.firebasestorage.app',
    measurementId: 'G-7K431Q1PZQ',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAqu3hB8nMfnZkOH9ZB79flwcDOFxKlXLg',
    appId: '1:1006902598533:ios:164ef2936ba2fa5312c2ec',
    messagingSenderId: '1006902598533',
    projectId: 'eceylonunifiedapp',
    storageBucket: 'eceylonunifiedapp.firebasestorage.app',
    iosBundleId: 'com.example.yearProject',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAqu3hB8nMfnZkOH9ZB79flwcDOFxKlXLg',
    appId: '1:1006902598533:ios:164ef2936ba2fa5312c2ec',
    messagingSenderId: '1006902598533',
    projectId: 'eceylonunifiedapp',
    storageBucket: 'eceylonunifiedapp.firebasestorage.app',
    iosBundleId: 'com.example.yearProject',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCgkkmNsMejG2Aa-HOVgDTSWHPCn_DwySA',
    appId: '1:1006902598533:web:6c3bcf4accc86f3112c2ec',
    messagingSenderId: '1006902598533',
    projectId: 'eceylonunifiedapp',
    authDomain: 'eceylonunifiedapp.firebaseapp.com',
    storageBucket: 'eceylonunifiedapp.firebasestorage.app',
    measurementId: 'G-KB28M1RFSP',
  );

}