import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:signin_page/Controllers/colorScheme.dart';
import 'package:signin_page/Services/Repeating/linearLine.dart';

class MySectionCardWithoutSideButtons
    extends StatefulWidget {
  List<String> titles;
  List<VoidCallback> functions;
  MySectionCardWithoutSideButtons({
    super.key,
    required this.titles,
    required this.functions,
  });

  @override
  State<MySectionCardWithoutSideButtons>
  createState() =>
      _MySectionCardWithoutSideButtonsState();
}

class _MySectionCardWithoutSideButtonsState
    extends
        State<MySectionCardWithoutSideButtons> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        width: double.infinity,
        child: Material(
          color: Colorscheme.colorbg20,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Colorscheme.color30,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(
              30,
            ),
          ),
          child: ListView.builder(
            shrinkWrap: true,
            physics:
                const NeverScrollableScrollPhysics(),
            itemCount: widget.titles.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () =>
                    widget.functions[index](),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 15,
                          ),
                      child: Text(
                        widget.titles[index],
                        style: TextStyle(
                          fontSize:
                              MediaQuery.of(
                                context,
                              ).size.width *
                              0.05,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ),
                    index !=
                            widget.titles.length -
                                1
                        ? const SizedBox(
                            height: 1.5,
                            child: myLine(),
                          )
                        : const SizedBox(),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
