import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:signin_page/AuthenticationLogic/signUpPage.dart';
import 'package:signin_page/Controllers/myGlobalSettingController.dart';
import 'package:signin_page/Services/Screens/Setting/mySectionCardWithoutSideButton.dart';
import 'package:signin_page/Services/Screens/popAlert.dart';

class Account extends StatefulWidget {
  final setting = Get.find<GlobalSetting>();
   Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    popAlert(
      String title,
      String description,
    ) async {
      return await showDialog<bool>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Delete Account"),
            content: const Text(
              'Account will be permanently deleted, Do you want to proceed?',
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text('Ok'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(
                    context,
                  ).pop(false);
                },
                child: const Text('Cancel'),
              ),
            ],
          );
        },
      );
    }

    Future signOut() async {
      final dialogBox = dialogService();
      final shouldSignOut = await dialogBox
          .showDialogBox(
            'Sign Out',
            'Are you sure you want to sign out? You will need to login again to access your account.',
            'Sign Out',
          );
      if (shouldSignOut) {
        try {
          if(widget.setting.isGuestMode.value){
            Get.offAll(MySignUpPage());
          }
          await FirebaseAuth.instance.signOut();
          await GoogleSignIn().disconnect();
        } catch (e) {
          Get.snackbar('An error occured', '');
        }
      }
    }

    Future<void> deletAccount() async {
      final dialogBox = dialogService();
      final shouldDelete = await dialogBox
          .showDialogBox(
            'Delete Account',
            'This action is permanent and cannot be undone. All your data and favorites will be lost forever. Are you sure?',
            'Delete',
          );
      if (shouldDelete) {
        try {
          String provider = '';
          final user =
              FirebaseAuth.instance.currentUser;
          for (final userProvider
              in user!.providerData) {
            provider = userProvider.providerId;
          }

          if (provider == 'google.com') {
            final GoogleSignInAccount? userAcc =
                await GoogleSignIn().signIn();
            final GoogleSignInAuthentication?
            userAuth =
                await userAcc?.authentication;
            final credential =
                GoogleAuthProvider.credential(
                  idToken: userAuth?.idToken,
                );
            await user
                .reauthenticateWithCredential(
                  credential,
                );

            var fav = await FirebaseFirestore
                .instance
                .collection('user')
                .doc(user.uid)
                .collection('favourites')
                .get();

            for (var doc in fav.docs) {
              await doc.reference.delete();
            }
            await FirebaseFirestore.instance
                .collection('user')
                .doc(user.uid)
                .delete();
            await user.delete();
            await GoogleSignIn().disconnect();
          } 
        } catch (e) {
          Get.snackbar('Error', e.toString());
        }
      }
    }

   

    return MySectionCardWithoutSideButtons(
      titles: const [
        'Sign out',
        'Delete Account',
      ],
      functions: [
        signOut,
        deletAccount,
      ],
    );
  }
}
