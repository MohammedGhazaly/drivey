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
    GoogleSignInAccount? user = await googleSignIn.signIn();
    if (user != null) {
      GoogleSignInAuthentication googleAuth = await user.authentication;
      OAuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
    }
  }
}
