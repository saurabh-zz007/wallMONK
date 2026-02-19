import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:signin_page/Controllers/myRouter.dart';
import 'package:signin_page/AuthenticationLogic/signUpPage.dart';
import 'package:signin_page/AuthenticationLogic/verify.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance
            .authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.emailVerified) {
              return const MyRouterPage();
            } else {
              return const MyVarificationPage();
            }
          } else {
            return MySignUpPage();
          }
        },
      ),
    );
  }
}
