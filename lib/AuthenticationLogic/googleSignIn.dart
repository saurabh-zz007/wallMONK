import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:signin_page/Controllers/myGlobalSettingController.dart';

Future<void> GoogleAuth() async {
  final googleSignIn = GoogleSignIn();
  final setting = Get.find<GlobalSetting>();
  try {
    final GoogleSignInAccount? googleUser =
        await googleSignIn.signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential =
        GoogleAuthProvider.credential(
          idToken: googleAuth?.idToken,
        );
    final user = await FirebaseAuth
        .instance
        .signInWithCredential(credential);
    setting.userName.value = user.user?.displayName ?? 'Guest';
    setting.userEmail.value = user.user?.email ?? '';
    setting.userPhotoURL.value = user.user?.photoURL ?? '';
    setting.isGuestMode.value = false;
  } catch (e) {
    Fluttertoast.showToast(
      msg: 'Error: $e',
      toastLength: Toast.LENGTH_LONG,
    );
  }
}
