import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:signin_page/Controllers/colorScheme.dart';

class myLine extends StatelessWidget {
  const myLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Flexible(
        child: Container(
          height: 1.5,
          color: Colorscheme.color30,
        ),
      ),
    );
  }
}
