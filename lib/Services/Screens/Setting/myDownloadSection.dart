import 'package:flutter/material.dart';
import 'package:signin_page/Services/Screens/Setting/mySectionCardWithoutSideButton.dart';

class Download extends StatefulWidget {
  const Download({super.key});

  @override
  State<Download> createState() =>
      _DownloadState();
}

class _DownloadState extends State<Download> {
  @override
  Widget build(BuildContext context) {
    return MySectionCardWithoutSideButtons(
      titles: const [
        'Download location',
        'Wallpaper Quality',
      ],
      functions: [() {}, () {}],
    );
  }
}
