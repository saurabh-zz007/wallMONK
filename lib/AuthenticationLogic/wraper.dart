import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/state_manager.dart';
import 'package:signin_page/AuthenticationLogic/signUpPage.dart';
import 'package:signin_page/Controllers/myGlobalSettingController.dart';
import 'package:signin_page/Controllers/myRouter.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final setting = Get.find<GlobalSetting>();
    return Obx((){
      if(setting.isGuestMode.value){
        return const MyRouterPage();
      }
    
    return StreamBuilder(
        stream: FirebaseAuth.instance
            .authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
           
            setting.isGuestMode.value = false;
            
            return const MyRouterPage();
          } else {
            return MySignUpPage();
          }
        },
    );
  });
}
}