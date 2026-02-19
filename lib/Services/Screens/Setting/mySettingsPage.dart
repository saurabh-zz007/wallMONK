import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signin_page/Controllers/colorScheme.dart';
import 'package:signin_page/Controllers/myGlobalSettingController.dart';
import 'package:signin_page/Services/Screens/Setting/myAccountSection.dart';
import 'package:signin_page/Services/Screens/Setting/myAppearenceSection.dart';
import 'package:signin_page/Services/Screens/Setting/myPerformanceCard.dart';

class MySettingsPage extends StatefulWidget {
  const MySettingsPage({super.key});

  @override
  State<MySettingsPage> createState() =>
      _MySettingsPageState();
}

class _MySettingsPageState
    extends State<MySettingsPage> {
  @override
  Widget build(BuildContext context) {
    final setting = Get.find<GlobalSetting>();
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.start,
        crossAxisAlignment:
            CrossAxisAlignment.center,
        spacing: 20,
        children: [
          //SizedBox(height: 20),
          Text(
            'Setting',
            style: TextStyle(
              fontSize:
                  MediaQuery.of(
                    context,
                  ).size.width *
                  0.1,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Flexible(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                spacing: 20,
                children: [
                  const Appearence(),
                  const Performance(),
                  //Download(),
                  const Account(),
                  const SizedBox(height: 30),
                  Obx(
                    () => Text(
                      'WallMonk ${setting.appVersion.value}',
                      style: TextStyle(
                        color:
                            Colorscheme.color30,
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
