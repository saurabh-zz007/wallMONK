import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:signin_page/AuthenticationLogic/googleSignIn.dart';
import 'package:signin_page/AuthenticationLogic/signUpPage.dart';
import 'package:signin_page/AuthenticationLogic/wraper.dart';

class MyLogInPage extends StatefulWidget {
  const MyLogInPage({super.key});

  @override
  State<MyLogInPage> createState() =>
      _MyLogInPageState();
}

class _MyLogInPageState
    extends State<MyLogInPage> {
  TextEditingController emailController =
      TextEditingController();

  TextEditingController passwordController =
      TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> login(BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          );

      Get.offAll(const Wrapper());
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Error: $e',
        toastLength: Toast.LENGTH_LONG,
      );
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
                      "Log in",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 50),
                    TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        label: Text(
                          "Email or Username",
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    TextField(
                      controller:
                          passwordController,
                      decoration: const InputDecoration(
                        label: Text("Password"),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Text(
                          "New User?",
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.to(
                              MySignUpPage(),
                            );
                          },
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
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
                                Colors.green,
                          ),

                          onPressed: () {
                            GoogleAuth();
                          },
                          child: const Text(
                            "Google",
                            style: TextStyle(
                              color: Colors.white,
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
                            login(context);
                          },
                          child: const Text(
                            "Log In",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
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
