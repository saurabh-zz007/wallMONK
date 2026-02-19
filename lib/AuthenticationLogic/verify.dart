import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:signin_page/AuthenticationLogic/signUpPage.dart';
import 'package:signin_page/AuthenticationLogic/wraper.dart';

class MyVarificationPage extends StatefulWidget {
  const MyVarificationPage({super.key});

  @override
  State<MyVarificationPage> createState() =>
      _MyVarificationPageState();
}

class _MyVarificationPageState
    extends State<MyVarificationPage> {
  @override
  void initState() {
    sendVerificationLink();
    super.initState();
  }

  Future<void> sendVerificationLink() async {
    final user =
        FirebaseAuth.instance.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification().then(
        (_) => {
          Get.snackbar(
            "Verification Email Sent",
            "Please check your email to verify your account.",
            snackPosition: SnackPosition.BOTTOM,
          ),
        },
      );
    }
  }

  Future<void> reload() async {
    await FirebaseAuth.instance.currentUser
        ?.reload();
    final user =
        FirebaseAuth.instance.currentUser;
    if (user != null && !user.emailVerified) {
      Get.snackbar(
        "Email Not Verified",
        "Please verify your email before proceeding.",
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      Get.offAll(const Wrapper());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxHeight: 600,
            maxWidth: 600,
          ),

          child: Material(
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(50),
              child: SizedBox(
                height:
                    MediaQuery.of(
                      context,
                    ).size.height *
                    0.4,
                width:
                    MediaQuery.of(
                      context,
                    ).size.width *
                    0.5,
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center,
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Email Varification",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "A verification link has been sent to your email. Verify by clicking the link in the mail, then click on Proceed.",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment:
                          Alignment.centerRight,
                      child: Row(
                        mainAxisAlignment:
                            MainAxisAlignment
                                .spaceBetween,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadiusGeometry.all(
                                      Radius.circular(
                                        0,
                                      ),
                                    ),
                              ),
                              backgroundColor:
                                  Colors.white10,
                            ),
                            onPressed: () {
                              Get.to(
                                MySignUpPage(),
                              );
                            },
                            child: const Text(
                              "Back",
                              style: TextStyle(
                                color:
                                    Colors.black,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadiusGeometry.all(
                                      Radius.circular(
                                        0,
                                      ),
                                    ),
                              ),
                              backgroundColor:
                                  Colors.blue,
                            ),
                            onPressed: () {
                              reload();
                            },
                            child: const Text(
                              "Proceed",
                              style: TextStyle(
                                color:
                                    Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
