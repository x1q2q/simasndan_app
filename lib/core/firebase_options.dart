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
    apiKey: 'AIzaSyBZS1nM5xe0t6TC0sdQcfRUManxVI0AUsQ',
    appId: '1:463131478033:android:7003ed0217e766b343c9b0',
    messagingSenderId: '463131478033',
    projectId: 'simasndan-auth',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBZS1nM5xe0t6TC0sdQcfRUManxVI0AUsQ',
    appId: '1:463131478033:android:7003ed0217e766b343c9b0',
    messagingSenderId: '463131478033',
    projectId: 'simasndan-auth',
    iosClientId:
        '1091889459400-pf3eouvi7850iav3qveunrh0jsohi15g.apps.googleusercontent.com',
    iosBundleId: 'com.example.simasndan_app',
  );
}
