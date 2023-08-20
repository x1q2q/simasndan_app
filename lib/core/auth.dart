import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email', 'profile']);
  final GoogleSignIn googleSignTautkan = GoogleSignIn(
      scopes: ['email', 'https://www.googleapis.com/auth/contacts.readonly']);

  Future<bool> signInWithGoogle() async {
    bool rest = false;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuth =
          await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuth.idToken,
        accessToken: googleSignInAuth.accessToken,
      );

      try {
        final UserCredential authResult =
            await _auth.signInWithCredential(credential);

        final User? user = authResult.user;

        if (authResult.additionalUserInfo!.isNewUser) {
          if (user != null) {
            // if selected email so signOut and delete user on firebase users
            googleSignIn.signOut();
            user.delete();
            rest = false;
          }
        } else {
          rest = true;
        }
      } catch (e) {
        print('error $e');
        rest = false;
      }
    }
    return rest;
  }

  Future<String> getUUID() async {
    final User? user = _auth.currentUser;
    return user!.uid;
  }

  Future<Map<String, dynamic>> tautkanGoogle() async {
    Map<String, dynamic> result = {
      "email": null,
      "uuid": null,
      "fcm_token": null
    };
    final GoogleSignIn googleSignTautkan = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignTautkan.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuth =
          await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuth.idToken,
        accessToken: googleSignInAuth.accessToken,
      );

      try {
        final UserCredential authResult =
            await _auth.signInWithCredential(credential);

        final User? user = authResult.user;
        googleSignTautkan.signOut();
        result["email"] = user!.email;
        result["uuid"] = user.uid;
      } catch (e) {
        print('error $e');
      }
    }
    return result;
  }

  Future<void> signOut() async {
    await googleSignIn.signOut();
    await googleSignTautkan.signOut();
  }
}
