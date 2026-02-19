import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/state_manager.dart';
import 'package:signin_page/Controllers/colorScheme.dart';
import 'package:signin_page/Controllers/myGlobalSettingController.dart';
import 'package:signin_page/Services/Screens/Setting/mySectionCardWithSideButtons.dart';

class Performance extends StatefulWidget {
  const Performance({super.key});

  @override
  State<Performance> createState() =>
      _PerformanceState();
}

class _PerformanceState
    extends State<Performance> {
  @override
  Widget build(BuildContext context) {
    final setting = Get.find<GlobalSetting>();
    clearCache() async {
      try {
        await DefaultCacheManager().emptyCache();
        if (mounted) {
          Fluttertoast.showToast(
            msg: "Cache Cleared",
            toastLength: Toast.LENGTH_LONG,
          );
        }
      } catch (e) {
        Fluttertoast.showToast(
          msg: 'Error: $e',
          toastLength: Toast.LENGTH_LONG,
        );
      }
    }

    return Obx(
      () => MySectionCardWithSideButtons(
        titles: const [
          'Preview quality',
          'Clear cache',
        ],
        sideButtons: [
          Obx(() {
            final String quality =
                setting.previewQuality.value;
            List<bool> isSelected = [
              quality == 'tiny',
              quality == 'portrait',
            ];
            return Material(
              color: Colorscheme.colorbg20,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Colorscheme.color30,
                  width: 1.5,
                ),
                borderRadius:
                    BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(
                  5.0,
                ),
                child: ToggleButtons(
                  isSelected: isSelected,
                  fillColor:
                      setting.isDarkMode.value
                      ? Colors.deepPurpleAccent
                      : Colors.white24,
                  borderColor: Colors.transparent,
                  borderRadius:
                      BorderRadius.circular(10),
                  onPressed: (index) {
                    index == 0
                        ? setting
                              .togglePreviewQuality(
                                'tiny',
                              )
                        : setting
                              .togglePreviewQuality(
                                'portrait',
                              );
                  },
                  children: const [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(
                            horizontal: 15.0,
                          ),
                      child: Text('Low'),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(
                            horizontal: 15,
                          ),
                      child: Text('High'),
                    ),
                  ],
                ),
              ),
            );
          }),
          GestureDetector(
            onTap: () => clearCache(),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Material(
                color: Colorscheme.colorbg20,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Colorscheme.color30,
                    width: 1.5,
                  ),
                  borderRadius:
                      BorderRadius.circular(10),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(
                    8.0,
                  ),
                  child: Icon(
                    Icons.delete,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
