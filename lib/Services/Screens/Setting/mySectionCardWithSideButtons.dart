import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:signin_page/Controllers/colorScheme.dart';

class MySectionCardWithSideButtons
    extends StatefulWidget {
  List<String> titles;
  //List<VoidCallback> functions;
  List<Widget>? sideButtons;
  MySectionCardWithSideButtons({
    super.key,
    required this.titles,
    //required this.functions,
    this.sideButtons,
  });

  @override
  State<MySectionCardWithSideButtons>
  createState() =>
      _MySectionCardWithSideButtonsState();
}

class _MySectionCardWithSideButtonsState
    extends State<MySectionCardWithSideButtons> {
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
              return Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 15,
                        ),
                    child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment
                              .spaceBetween,
                      children: [
                        Text(
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
                        widget.sideButtons != null
                            ? widget
                                  .sideButtons![index]
                            : const SizedBox(),
                      ],
                    ),
                  ),
                  index !=
                          widget.titles.length - 1
                      ? Container(
                          height: 1.5,

                          color:
                              Colorscheme.color30,
                        )
                      : const SizedBox(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
