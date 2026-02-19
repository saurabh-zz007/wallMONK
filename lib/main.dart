import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signin_page/AuthenticationLogic/wraper.dart';
import 'package:signin_page/Controllers/myGlobalSettingController.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final pref =
      await SharedPreferences.getInstance();
  final bool isDarkMode =
      pref.getBool('isDarkMode') ?? true;
  final double gridCol =
      pref.getDouble('gridCol') ?? 2.0;
  final String previewQuality =
      pref.getString('previewQuality') ??
      'portrait';
  Get.put(
    GlobalSetting(
      isDarkMode,
      gridCol,
      previewQuality,
    ),
  );
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final setting = Get.find<GlobalSetting>();
    return GetMaterialApp(
      title: 'WallMONK',
      debugShowCheckedModeBanner: false,
      themeMode: setting.isDarkMode.value
          ? ThemeMode.dark
          : ThemeMode.light,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),

      home: const Wrapper(),
    );
  }
}
