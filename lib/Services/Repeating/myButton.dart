import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:signin_page/Controllers/myGlobalSettingController.dart';

class MyButton extends StatefulWidget {
  double height;
  double width;
  String title;
  IconData icon;
  final Function() onTap;
  Color? textColor = Colors.white;
  MyButton({
    super.key,
    required this.height,
    required this.width,
    required this.title,
    required this.icon,
    required this.onTap,
    this.textColor,
  });

  @override
  State<MyButton> createState() =>
      _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  @override
  Widget build(BuildContext context) {
    final setting = Get.find<GlobalSetting>();
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        height: widget.height * 0.06,
        alignment:
            AlignmentDirectional.centerStart,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            width: 1.5,
            color: setting.isDarkMode.value
                ? Colors.white24
                : Colors.black26,
          ),
        ),
        child: Padding(
          padding: const EdgeInsetsGeometry.fromLTRB(
            20,
            0,
            0,
            0,
          ),
          child: Row(
            spacing: 5,
            children: [
              Icon(
                widget.icon,
                size: widget.height * 0.025,
                color: widget.textColor,
              ),
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: widget.height * 0.02,
                  color: widget.textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
