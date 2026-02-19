import 'package:flutter/material.dart';

class MyAnimatedIcon extends StatefulWidget {
  AnimatedIconData icon;
  bool tapped = false;

  MyAnimatedIcon({
    super.key,
    required this.icon,
    required this.tapped,
  });

  @override
  State<MyAnimatedIcon> createState() =>
      _MyAnimatedIconState();
}

class _MyAnimatedIconState
    extends State<MyAnimatedIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      value: widget.tapped ? 1 : 0,
    );
  }

  @override
  void didUpdateWidget(MyAnimatedIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.tapped != widget.tapped) {
      setState(() {
        widget.tapped
            ? _controller.forward()
            : _controller.reverse();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedIcon(
      icon: widget.icon,
      progress: _controller,
    );
  }
}
