// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signInWIthGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final response = await _auth.signInWithCredential(credential);
      print("response from successful sign in with google === $response");
    } catch (e) {
      print("error signing in with google === $e");
    }
  }

  Future signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      final token = result.accessToken?.token;
      final OAuthCredential facebookCredential =
          await FacebookAuthProvider.credential(token!);

      final response = await _auth.signInWithCredential(facebookCredential);
      print('response after successful sign in with fb === $response');
    } catch (e) {
      print("fb sign in error === $e");
    }
  }
}
