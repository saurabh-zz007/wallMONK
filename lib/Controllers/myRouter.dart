import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:signin_page/Controllers/colorScheme.dart';
import 'package:signin_page/Controllers/myGlobalSettingController.dart';
import 'package:signin_page/Services/Repeating/linearLine.dart';
import 'package:signin_page/Services/Repeating/myAnimatedIcons.dart';
import 'package:signin_page/Services/Screens/myHomePage.dart';
import 'package:flutter/material.dart';
import 'package:signin_page/Services/Repeating/myButton.dart';
import 'package:signin_page/Services/Screens/myDownloadsPage.dart';
import 'package:signin_page/Services/Screens/myFavouritesPage.dart';
import 'package:signin_page/Services/Screens/Setting/mySettingsPage.dart';

class MyRouterPage extends StatefulWidget {
  const MyRouterPage({super.key});

  @override
  State<MyRouterPage> createState() =>
      _MyRouterPageState();
}

class _MyRouterPageState
    extends State<MyRouterPage> {
  Widget page = MyHomePage();
  bool _openRout = false;

  @override
  Widget build(BuildContext context) {
    final user =
        FirebaseAuth.instance.currentUser;
    final photoURL = user?.photoURL;
    final userName = user?.displayName;
    final useremail = user?.email;
    double height = MediaQuery.of(
      context,
    ).size.height;
    double width = MediaQuery.of(
      context,
    ).size.width;
    final setting = Get.find<GlobalSetting>();

    return Obx(
      () => SafeArea(
        child: Stack(
          children: [
            AbsorbPointer(
              absorbing: _openRout,
              child: SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: page,
              ),
            ),
            IgnorePointer(
              ignoring:
                  !_openRout, // If closed, let clicks pass through to the Grid
              child: AnimatedOpacity(
                duration: const Duration(
                  milliseconds: 300,
                ),
                opacity: _openRout ? 1.0 : 0.0,
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 2.0,
                    sigmaY: 2.0,
                  ),
                  child: SizedBox(
                    height: height,
                    width: width,
                  ),
                ),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(
                milliseconds: 400,
              ),
              curve: Curves.elasticInOut,
              transform:
                  Matrix4.translationValues(
                    _openRout ? width * 0.6 : 0,
                    0,
                    0,
                  ),
              child: Padding(
                padding: const EdgeInsets.all(
                  16.0,
                ),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _openRout = !_openRout;
                    });
                  },
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(10),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 2.0,
                        sigmaY: 2.0,
                      ),
                      child: Material(
                        color:
                            Colorscheme.colorbg20,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Colorscheme
                                .color40,
                            width: 1.5,
                          ),
                          borderRadius:
                              BorderRadius.circular(
                                10,
                              ),
                        ),
                        child: Padding(
                          padding:
                              const EdgeInsets.all(
                                8.0,
                              ),
                          child: MyAnimatedIcon(
                            tapped: _openRout,
                            icon: AnimatedIcons
                                .menu_close,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(
                milliseconds: 400,
              ),
              curve: Curves.elasticInOut,
              transform:
                  Matrix4.translationValues(
                    _openRout ? 0 : -width * 0.6,
                    0,
                    0,
                  ),
              child: Container(
                height: height,
                width: width * 0.6,
                color: setting.isDarkMode.value
                    ? Colors.black87
                    : Colors.white70,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 20,
                      ),
                  child: Column(
                    mainAxisAlignment:
                        MainAxisAlignment.start,
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    spacing: 10,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(
                              0,
                              10,
                              0,
                              20,
                            ),
                        child: Text(
                          "WallMONK",
                          style: TextStyle(
                            fontSize:
                                width * 0.07,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ),
                      const myLine(),
                      Row(
                        spacing: 5,
                        children: [
                          Container(
                            height: width * 0.15,
                            width: width * 0.15,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(
                                    10,
                                  ),
                            ),
                            child:
                                photoURL != null
                                ? ClipRRect(
                                    borderRadius:
                                        BorderRadiusGeometry.circular(
                                          10,
                                        ),
                                    child: Image.network(
                                      photoURL,
                                      fit: BoxFit
                                          .cover,
                                    ),
                                  )
                                : Icon(
                                    Icons.person,
                                    size:
                                        width *
                                        0.12,
                                  ),
                          ),

                          Padding(
                            padding:
                                const EdgeInsets.symmetric(
                                  vertical: 20,
                                ),
                            child: SizedBox(
                              width: width * 0.35,
                              child: Column(
                                spacing: 5,
                                crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,

                                children: [
                                  Text(
                                    '$userName',
                                    maxLines: 1,
                                    style: const TextStyle(
                                      fontSize:
                                          15,
                                      overflow:
                                          TextOverflow
                                              .ellipsis,
                                    ),
                                  ),
                                  Text(
                                    '$useremail',
                                    maxLines: 1,
                                    style: const TextStyle(
                                      fontSize:
                                          14,
                                      overflow:
                                          TextOverflow
                                              .ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      const myLine(),
                      MyButton(
                        title: "Home",
                        height: height,
                        width: width,
                        icon: Icons.home,
                        onTap: () => setState(() {
                          _openRout = !_openRout;
                          page = MyHomePage();
                        }),
                      ),
                      MyButton(
                        title: "Favourites",
                        icon: Icons
                            .favorite_outline,
                        height: height,
                        width: width,
                        onTap: () {
                          setState(() {
                            _openRout =
                                !_openRout;
                            page =
                                const MyFavouritesPage();
                          });
                        },
                      ),
                      MyButton(
                        title: "Downloads",
                        height: height,
                        width: width,
                        icon: Icons.download,
                        onTap: () {
                          setState(() {
                            _openRout =
                                !_openRout;
                            page =
                                const MyDownloadsPage();
                          });
                        },
                      ),
                      MyButton(
                        title: "Setting",
                        height: height,
                        width: width,
                        icon: Icons.settings,
                        onTap: () {
                          setState(() {
                            _openRout =
                                !_openRout;
                            page =
                                const MySettingsPage();
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
