import 'dart:ui';

import 'package:flutter/material.dart';

class BasePage extends StatefulWidget {
  Widget body;
  Widget? searchBar;
  BasePage({
    super.key,
    required this.body,
    this.searchBar,
  });
  double count = 1;
  final bool _isDrawerOpen = false;
  @override
  State<BasePage> createState() =>
      _BasePageState();
}

class _BasePageState extends State<BasePage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        widget.body,

        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 10,
          ),
          child: SafeArea(
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(width: 50),
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 300,
                    maxHeight: 50,
                  ),
                  child:
                      widget.searchBar ??
                      const SizedBox(),
                ),
              ],
            ),
          ),
        ),
        IgnorePointer(
          ignoring: !widget
              ._isDrawerOpen, // If closed, let clicks pass through to the Grid
          child: AnimatedOpacity(
            duration: const Duration(
              milliseconds: 300,
            ),
            opacity: widget._isDrawerOpen
                ? 1.0
                : 0.0,
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 2.0,
                sigmaY: 2.0,
              ),
              child: Container(),
            ),
          ),
        ),
      ],
    );
  }
}
