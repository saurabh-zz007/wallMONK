import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:signin_page/Services/Screens/Setting/mySectionCardWithoutSideButton.dart';
import 'package:signin_page/Services/Screens/popAlert.dart';

class Account extends StatefulWidget {
  const Account({super.key});

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
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 2.0,
                sigmaY: 2.0,
              ),
              child:
                  const CircularProgressIndicator(),
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
          } else {}
        } catch (e) {
          Get.snackbar('Error', e.toString());
        }
      }
    }

    Future<void> changePassword() async {
      String provider = '';
      final user =
          FirebaseAuth.instance.currentUser;
      for (final userProvider
          in user!.providerData) {
        provider = userProvider.providerId;
      }
      final alert = dialogService();
      final reset = await alert.showDialogBox(
        'Change Password',
        'For security, we need to verify your identity. We will send a password reset link to your registered email ${FirebaseAuth.instance.currentUser!.email}. Please click the link to set a new password.',
        'Send Reset Link',
      );
      if (provider != 'google.com' && reset) {
        final email = user.email;
        await FirebaseAuth.instance
            .sendPasswordResetEmail(
              email: email!,
            );
        Get.snackbar(
          'Email has been sent to $email',
          '',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(
            milliseconds: 2000,
          ),
          animationDuration: const Duration(
            milliseconds: 300,
          ),
        );
      } else if (reset) {
        Get.snackbar(
          'Error',
          'You are signed in with Google. Please manage your password through your Google Account settings.',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(
            milliseconds: 2000,
          ),
          animationDuration: const Duration(
            milliseconds: 300,
          ),
        );
      }
    }

    return MySectionCardWithoutSideButtons(
      titles: const [
        'Change Password',
        'Sign out',
        'Delete Account',
      ],
      functions: [
        changePassword,
        signOut,
        deletAccount,
      ],
    );
  }
}
