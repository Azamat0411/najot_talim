import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBxj4c0RZBD_NDC0NTvBGml_F-v0eCpbhM',
    appId: '1:295994309170:android:0460d1f987511c79bb9a2b',
    messagingSenderId: '295994309170',
    projectId: 'najottalim-25e1a',
    storageBucket: 'najottalim-25e1a.appspot.com',
    androidClientId: '295994309170-0ss1jineu9cpj82n1q5jmjqlk07gq4ns.apps.googleusercontent.com'
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA7ncAsH34EEB8SpCrhLoY0lHpC5WbCWto',
    appId: '1:295994309170:ios:923a29c0fbe35593bb9a2b',
    messagingSenderId: '295994309170',
    projectId: 'najottalim-25e1a',
    storageBucket: 'najottalim-25e1a.appspot.com',
    iosClientId: '295994309170-767su3rsvq0qs8cu1lkmfek35l06qhjg.apps.googleusercontent.com',
    iosBundleId: 'com.example.najotTalim',
  );
}
