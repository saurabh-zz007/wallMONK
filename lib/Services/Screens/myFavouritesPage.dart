import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:lottie/lottie.dart';
import 'package:signin_page/AuthenticationLogic/googleSignIn.dart';
import 'package:signin_page/Controllers/myGlobalSettingController.dart';
import 'package:signin_page/Services/Screens/myWallpaperPrevPage.dart';
import 'package:signin_page/core/widgets/expandableButtons.dart';

class MyFavouritesPage extends StatefulWidget {
  MyFavouritesPage({super.key});
  double count = 1;
  @override
  State<MyFavouritesPage> createState() =>
      _MyFavouritesPageState();
}

List<dynamic> Images = [];
Future<void> fetchImage() async {
  final user = FirebaseAuth.instance.currentUser;
  final val = await FirebaseFirestore.instance
      .collection('user')
      .doc(user!.uid)
      .collection('favourites')
      .get();
  Images = val.docs
      .map((doc) => doc.data())
      .toList();
  print(Images);
}

class _MyFavouritesPageState
    extends State<MyFavouritesPage> {
  @override
  void initState() {
    super.initState();
    fetchImage();
  }

  @override
  Widget build(BuildContext context) {
    final setting = Get.find<GlobalSetting>();
    return Obx((){
      if(setting.isGuestMode.value == true){
        return Column(
        mainAxisAlignment:
            MainAxisAlignment.center,
        crossAxisAlignment:
            CrossAxisAlignment.center,
        children: [
          SizedBox(
            height:
                MediaQuery.of(
                  context,
                ).size.height *
                0.3,
            child: Lottie.asset(
              'assets/rocket.json',
            ),
          ),
          Text(
            "Please log in to continue",
            style: TextStyle(
              fontSize:
                  MediaQuery.of(
                    context,
                  ).size.height *
                  0.02,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: ExpandedButton(
                            buttonText: "Google",
                            buttonColor: Colors.blue,
                            onPressed: () {
                              GoogleAuth();
                            },
                            buttonIcon: const FaIcon(
                              FontAwesomeIcons.google,
                              color: Colors.white,
                            ),
                          ),
          ),
          SizedBox(
            height:
                MediaQuery.of(
                  context,
                ).size.height *
                0.2,
          ),
        ],
      );
      }
      else{
        return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.start,
        crossAxisAlignment:
            CrossAxisAlignment.center,
        children: [
          Text(
            'Favourites',
            style: TextStyle(
              fontSize:
                  MediaQuery.of(
                    context,
                  ).size.width *
                  0.1,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Flexible(
            child: CustomScrollView(
              slivers: [
                SliverMasonryGrid.count(
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  crossAxisCount: setting
                      .gridCol
                      .value
                      .toInt(),
                  childCount: Images.length,
                  itemBuilder: (context, index) {
                    widget.count =
                        (index.toDouble() %
                            setting
                                .gridCol
                                .value) +
                        1;
                    return GestureDetector(
                      onTap: () {
                        Get.to(
                          Mywallpaperprevpage(
                            url:
                                Images[index]['url'],
                            title:
                                Images[index]['title'],
                            photographer:
                                Images[index]['photographer'],
                            uniqueId:
                                Images[index]['uniqueId'],
                          ),
                        );
                      },
                      child: Material(
                        borderRadius:
                            BorderRadius.circular(
                              20.0,
                            ),
                        elevation: 8,

                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(
                                20.0,
                              ),
                          child: CachedNetworkImage(
                            imageUrl:
                                Images[index]['url'],
                            progressIndicatorBuilder:
                                (
                                  context,
                                  url,
                                  progress,
                                ) => Center(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.all(
                                          8.0,
                                        ),
                                    child: CircularProgressIndicator(
                                      value: progress
                                          .progress,
                                    ),
                                  ),
                                ),
                            imageBuilder:
                                (
                                  context,
                                  imageProvider,
                                ) => Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image:
                                          imageProvider,

                                      fit: BoxFit
                                          .cover,
                                    ),
                                  ),
                                ),
                            height:
                                150 *
                                        widget
                                            .count >
                                    300
                                ? 300
                                : 150 * widget.count <
                                      200
                                ? 200
                                : 150 *
                                      widget
                                          .count,
                            errorWidget:
                                (
                                  context,
                                  url,
                                  error,
                                ) => const Icon(
                                  Icons
                                      .error_outline,
                                  color:
                                      Colors.red,
                                ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
      }}  
    );
    
    
  }
}
