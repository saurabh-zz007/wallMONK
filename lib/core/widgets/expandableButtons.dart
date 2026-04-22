import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ExpandedButton extends StatefulWidget {
  String buttonText;
  Color buttonColor;
  Function onPressed;
  FaIcon buttonIcon;
  ExpandedButton({super.key,required this.buttonIcon, required this.buttonText, required this.buttonColor, required this.onPressed});

  @override
  State<ExpandedButton> createState() => _ExpandedButtonState();
}

class _ExpandedButtonState extends State<ExpandedButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadiusGeometry.all(
                                      Radius.circular(
                                        16,
                                      ),
                                    ),
                              ),
                              backgroundColor:
                                  widget.buttonColor,
                            ),
                          
                            onPressed: () {
                              widget.onPressed();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              
                              children: [
                                widget.buttonIcon,
                                const SizedBox(width: 10),
                                Text(
                                  widget.buttonText,
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
    );
  }
}