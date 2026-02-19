import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:signin_page/Controllers/myGlobalSettingController.dart';

class Colorscheme {
  static bool get setting =>
      Get.find<GlobalSetting>().isDarkMode.value;
  static Color get color10 =>
      setting ? Colors.white10 : Colors.black12;
  static Color get color20 =>
      setting ? Colors.white24 : Colors.black26;
  static Color get color30 =>
      setting ? Colors.white38 : Colors.black38;
  static Color get color40 =>
      setting ? Colors.white54 : Colors.black45;
  static Color get color50 =>
      setting ? Colors.white60 : Colors.black54;
  static Color get color60 =>
      setting ? Colors.white70 : Colors.black87;

  static Color get colorbg10 =>
      setting ? Colors.white10 : Colors.black12;
  static Color get colorbg20 =>
      setting ? Colors.white24 : Colors.black12;
  static Color get colorbg30 =>
      setting ? Colors.white38 : Colors.black12;
  static Color get colorbg40 =>
      setting ? Colors.white54 : Colors.black12;
  static Color get colorbg50 =>
      setting ? Colors.white60 : Colors.black12;
  static Color get colorbg60 =>
      setting ? Colors.white70 : Colors.black12;
}
