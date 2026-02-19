import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<void> GoogleAuth() async {
  final googleSignIn = GoogleSignIn();
  try {
    final GoogleSignInAccount? googleUser =
        await googleSignIn.signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential =
        GoogleAuthProvider.credential(
          //accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );
    final userCredential = await FirebaseAuth
        .instance
        .signInWithCredential(credential);
  } catch (e) {
    Fluttertoast.showToast(
      msg: 'Error: $e',
      toastLength: Toast.LENGTH_LONG,
    );
  }
}
