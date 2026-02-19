import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:signin_page/AuthenticationLogic/googleSignIn.dart';

import 'package:signin_page/AuthenticationLogic/loginPage.dart';
import 'package:signin_page/AuthenticationLogic/wraper.dart';

class MySignUpPage extends StatefulWidget {
  MySignUpPage({super.key});
  TextEditingController emailController =
      TextEditingController();
  TextEditingController passwordController =
      TextEditingController();
  TextEditingController nameController =
      TextEditingController();

  @override
  State<MySignUpPage> createState() =>
      _MySignUpPageState();
}

class _MySignUpPageState
    extends State<MySignUpPage> {
  bool _isloading = false;
  Future<void> signUp() async {
    if (_isloading) return;
    if (widget.nameController.text.isEmpty) {
      Fluttertoast.showToast(
        msg:
            'Error: Please enter valid credentials.',
        toastLength: Toast.LENGTH_LONG,
      );
    } else {
      setState(() {
        _isloading = true;
      });
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
              email: widget.emailController.text,
              password:
                  widget.passwordController.text,
            );

        await FirebaseAuth.instance.currentUser
            ?.updateProfile(
              displayName:
                  widget.nameController.text,
            );

        Get.offAll(() => const Wrapper());
      } catch (e) {
        Fluttertoast.showToast(
          msg: 'Error: $e',
          toastLength: Toast.LENGTH_LONG,
        );
      } finally {
        if (mounted) {
          setState(() {
            _isloading = false;
          });
        }
      }
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
                    0.5,
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
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 50),

                    TextField(
                      controller:
                          widget.nameController,
                      decoration: const InputDecoration(
                        label: Text("Full Name"),
                      ),
                    ),
                    const SizedBox(height: 20),

                    TextField(
                      controller:
                          widget.emailController,
                      decoration: const InputDecoration(
                        label: Text(
                          "Email or Username",
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    TextField(
                      controller: widget
                          .passwordController,
                      decoration: const InputDecoration(
                        label: Text("Password"),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Text(
                          "Already have an account?",
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(
                              context,
                            ).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) =>
                                    const MyLogInPage(),
                              ),
                            );
                          },
                          child: const Text(
                            "Log In",
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
                                _isloading
                                ? Colors.black54
                                : Colors.blue,
                          ),

                          onPressed: () {
                            signUp();
                          },
                          child: _isloading
                              ? const Center(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.all(
                                          2.0,
                                        ),
                                    child: CircularProgressIndicator(
                                      backgroundColor:
                                          Colors
                                              .transparent,
                                    ),
                                  ),
                                )
                              : const Text(
                                  "Sign Up",
                                  style: TextStyle(
                                    color: Colors
                                        .white,
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
