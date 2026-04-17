
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:signin_page/AuthenticationLogic/googleSignIn.dart';
import 'package:signin_page/Controllers/myGlobalSettingController.dart';
import 'package:signin_page/Controllers/myRouter.dart';
import 'package:signin_page/core/widgets/expandableButtons.dart';

class MySignUpPage extends StatefulWidget {
  MySignUpPage({super.key});

  @override
  State<MySignUpPage> createState() =>
      _MySignUpPageState();
}

class _MySignUpPageState
    extends State<MySignUpPage> {
  
  

  @override
  Widget build(BuildContext context) {
    final setting = Get.find<GlobalSetting>();
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
                      "Welcome!",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                    
                    const Text(
                      "Continue with..."
                    ),
                    const SizedBox(height: 50),

                        ExpandedButton(
                          buttonText: "Google",
                          buttonColor: Colors.blue,
                          onPressed: () {
                            GoogleAuth();
                          },
                          buttonIcon: const FaIcon(
                            FontAwesomeIcons.google,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 20,),
                        ExpandedButton(buttonText: "Guest",
                        buttonColor: Colors.red,
                        onPressed: (){
                          setting.isGuestMode.value = true;
                        },
                        buttonIcon: const FaIcon(
                          FontAwesomeIcons.user,
                          color: Colors.white,
                        ),
                        )
                        
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
