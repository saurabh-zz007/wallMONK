import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalSetting extends GetxController {
  late RxBool isDarkMode = true.obs;
  late RxDouble gridCol = 2.0.obs;
  late RxString previewQuality = 'portrait'.obs;
  var appVersion = 'Loading...'.obs;
  @override
  void onInit() {
    super.onInit();
    _loadCurrentVersion();
  }

  Future<void> _loadCurrentVersion() async {
    final PackageInfo info =
        await PackageInfo.fromPlatform();
    appVersion.value = 'v${info.version}';
  }

  GlobalSetting(
    bool isDarkMode,
    double gridCol,
    String previewQuality,
  ) {
    this.isDarkMode.value = isDarkMode;
    this.gridCol.value = gridCol;
    this.previewQuality.value = previewQuality;
  }

  void toggleTheme() async {
    final pref =
        await SharedPreferences.getInstance();
    isDarkMode.value
        ? Get.changeThemeMode(ThemeMode.dark)
        : Get.changeThemeMode(ThemeMode.light);
    pref.setBool('isDarkMode', isDarkMode.value);
  }

  void toggleGridCol(double col) async {
    final pref =
        await SharedPreferences.getInstance();
    gridCol.value = col;
    pref.setDouble('gridCol', col);
  }

  void togglePreviewQuality(
    String previewQuality,
  ) async {
    final pref =
        await SharedPreferences.getInstance();
    this.previewQuality.value = previewQuality;
    pref.setString(
      'previewQuality',
      previewQuality,
    );
  }
}
