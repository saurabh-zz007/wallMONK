import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signin_page/Controllers/colorScheme.dart';
import 'package:signin_page/Controllers/myGlobalSettingController.dart';
import 'package:signin_page/Services/Screens/Setting/mySectionCardWithSideButtons.dart';

class Appearence extends StatefulWidget {
  const Appearence({super.key});

  @override
  State<Appearence> createState() =>
      _AppearenceState();
}

class _AppearenceState extends State<Appearence> {
  @override
  Widget build(BuildContext context) {
    final setting = Get.find<GlobalSetting>();
    return MySectionCardWithSideButtons(
      titles: const ['Dark Mode', 'Grid Columns'],
      /*functions: [
          () {
            setState(() {});
          },
          () {},
        ],*/
      sideButtons: [
        Obx(
          () => Switch(
            activeThumbColor:
                Colors.deepPurpleAccent,
            activeTrackColor: Colorscheme.color40,
            autofocus: true,
            value: setting.isDarkMode.value,
            onChanged: (bool newValue) async {
              setting.isDarkMode.value = newValue;
              setting.toggleTheme();
            },
          ),
        ),
        Obx(() {
          double currentIndex =
              setting.gridCol.value;
          List<bool> isSelected = [
            currentIndex == 2,
            currentIndex == 3,
            currentIndex == 4,
          ];
          return Material(
            color: Colorscheme.colorbg20,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Colorscheme.color30,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(
                10,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: SizedBox(
                child: ToggleButtons(
                  borderColor: Colors.transparent,
                  borderRadius:
                      BorderRadius.circular(10),
                  fillColor:
                      setting.isDarkMode.value
                      ? Colors.deepPurpleAccent
                      : Colors.white24,
                  isSelected: isSelected,
                  onPressed: (int index) {
                    setting.toggleGridCol(
                      index + 2,
                    );
                  },
                  children: const [
                    Text('2'),
                    Text('3'),
                    Text('4'),
                  ],
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}
