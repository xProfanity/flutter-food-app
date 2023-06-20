import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:foodapp/models/user.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserData? _userFromFirebase(User? user) {
    return user != null
        ? UserData(user.uid, user.displayName, user.photoURL)
        : null;
  }

  Stream<UserData?> get user {
    return _auth.authStateChanges().map(_userFromFirebase);
  }

  Future signInWIthGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await _auth.signInWithCredential(credential);
    } catch (e) {
      print("error signing in with google === $e");
    }
  }

  Future signInWithFacebook() async {
    final facebook = FacebookAuth.instance;
    try {
      final LoginResult result = await facebook.login();
      final token = result.accessToken?.token;
      final OAuthCredential facebookCredential =
          await FacebookAuthProvider.credential(token!);

      await _auth.signInWithCredential(facebookCredential);

      // final dynamic userCred = await _facebook.getUserData();
    } catch (e) {
      print("fb sign in error === $e");
    }
  }
}
