import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drivey_files/core/values/app_collections.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();
  late Rx<User?> user = Rx<User?>(FirebaseAuth.instance.currentUser);
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    user.bindStream(firebaseAuth.authStateChanges());
  }

  Future<void> login() async {
    try {
      GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser != null) {
        GoogleSignInAuthentication googleAuth = await googleUser.authentication;

        OAuthCredential credential = GoogleAuthProvider.credential(
            idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
        UserCredential userCredential =
            await firebaseAuth.signInWithCredential(credential);
        User? user = userCredential.user;
        AppCollections.userCollection.doc(user!.uid).set({
          "user_name": user.displayName,
          "profile_pic": user.photoURL,
          "email": user.email,
          "id": user.uid,
          "user_created": FieldValue.serverTimestamp()
        });
      }
    } catch (e) {
      print("SSSSSSSSSSSSSSS");
      if (e is PlatformException) {
        if (e.code == "network_error") {
          Get.snackbar(
              colorText: Colors.white,
              backgroundColor: Colors.deepOrange,
              "No internet",
              "Please check your internet connection and login agin");
        }
      }
    }
  }
}
