import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drivey_files/core/values/app_collections.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  Future<void> login() async {
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
  }
}
