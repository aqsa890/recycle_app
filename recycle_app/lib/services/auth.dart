import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:recycle_app/pages/home.dart';
import 'package:recycle_app/services/database.dart';
import 'package:recycle_app/services/shared_preferences.dart';

class AuthMethods {
  signInWithGoogle(BuildContext context) async {
    // ignore: unused_local_variable
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    final GoogleSignInAuthentication? googleSignInAuthentication =
        await googleSignInAccount?.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication?.idToken,
      accessToken: googleSignInAuthentication?.accessToken,
    );

    UserCredential result = await firebaseAuth.signInWithCredential(credential);

    User? userDetails = result.user;

    await SharedPreferenceHelper().saveUserEmail(userDetails!.email!);
    await SharedPreferenceHelper().saveUserId(userDetails.uid);
    await SharedPreferenceHelper().saveUserImage(userDetails.photoURL!);
    await SharedPreferenceHelper().saveUserName(userDetails.displayName!);

    Map<String, dynamic> userInfoMap = {
      "email": userDetails!.email,
      "name": userDetails.displayName,
      "image": userDetails.photoURL,
      "Id": userDetails.uid,
    };

    await DatabaseMethods().addUserInfo(userInfoMap, userDetails.uid);
    Navigator.pushReplacementNamed(context, '/home');
  }
}
