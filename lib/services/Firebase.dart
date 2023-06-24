import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:foodapp/models/menu.dart';
import 'package:foodapp/models/user.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _users =
      FirebaseFirestore.instance.collection('users');

  UserData? _userFromFirebase(User? user) {
    return user != null
        ? UserData(user.uid, user.displayName, user.photoURL, user.email)
        : null;
  }

  Stream<UserData?> get user {
    return _auth.authStateChanges().map(_userFromFirebase);
  }

  Future<void> addGoogleUserCredentials(
      isNewUser, uid, username, photoURL, email, token) async {
    isNewUser
        ? {
            await _users.add({
              'userId': uid,
              'username': username,
              'profilePic': photoURL,
              'email': email,
              'needToken': false,
              'token': token,
              'cart': [],
            })
          }
        : null;
  }

  Future<void> addFacebookUserCredentials(
      isNewUser, uid, username, photoURL, email, token) async {
    isNewUser
        ? {
            await _users.add({
              'userId': uid,
              'username': username,
              'profilePic': '$photoURL?height=500&access_token=$token',
              'email': email,
              'needToken': true,
              'token': token,
              'cart': [],
            })
          }
        : null;
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

      final response = await _auth.signInWithCredential(credential);

      await addGoogleUserCredentials(
          response.additionalUserInfo?.isNewUser,
          response.user?.uid,
          response.user?.displayName,
          response.user?.photoURL,
          response.user?.email,
          response.credential?.accessToken);
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
          FacebookAuthProvider.credential(token!);

      final response = await _auth.signInWithCredential(facebookCredential);

      await addFacebookUserCredentials(
          response.additionalUserInfo?.isNewUser,
          response.user?.uid,
          response.user?.displayName,
          response.user?.photoURL,
          response.user?.email,
          token);
    } catch (e) {
      print("fb sign in error === $e");
    }
  }
}

class Firestore {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference menuCollection =
      FirebaseFirestore.instance.collection('menu');
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  List<FoodMenu> _menuCollection(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return FoodMenu(
          name: (doc.data() as Map)['name'],
          price: (doc.data() as Map)['price'],
          photoUrl: (doc.data() as Map)['photo'],
          contents: (doc.data() as Map)['contents'],
          docId: doc.id);
    }).toList();
  }

  Stream<List<FoodMenu>>? get menu {
    return menuCollection.snapshots().map(_menuCollection);
  }
}
