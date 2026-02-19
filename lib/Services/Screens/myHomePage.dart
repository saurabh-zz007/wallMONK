import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:signin_page/Controllers/myBaseScreen.dart';
import 'package:signin_page/Controllers/myCatagoryPage.dart';
import 'package:signin_page/Controllers/myGlobalSettingController.dart';
import 'package:signin_page/Controllers/mycatagoryList.dart';
import 'package:signin_page/Services/Repeating/mySearchBar.dart';
import 'package:signin_page/Services/Screens/myWallpaperPrevPage.dart';
import 'package:signin_page/Services/wallpaperServices.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  double count = 1;

  String search = '';
  final ScrollController _scrollController =
      ScrollController();
  final String? email =
      FirebaseAuth.instance.currentUser != null
      ? FirebaseAuth.instance.currentUser?.email!
      : "";
  final String displayName =
      FirebaseAuth
          .instance
          .currentUser
          ?.displayName ??
      "";
  @override
  State<MyHomePage> createState() =>
      _MyHomePageState();
}

int selectedCat = -1;

class _MyHomePageState extends State<MyHomePage> {
  List<dynamic> Images = [];
  bool _isRefreshed = false;
  int _page = 1;
  bool _isLoading = false;
  @override
  void dispose() {
    widget._scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    fetchAPI();
    widget._scrollController.addListener(() {
      if (widget
                  ._scrollController
                  .position
                  .pixels >=
              widget
                      ._scrollController
                      .position
                      .maxScrollExtent -
                  100 &&
          !_isLoading) {
        fetchAPI();
      }
    });
  }

  Future<void> fetchAPI() async {
    if (_isLoading) return;
    setState(() {
      _isLoading = true;
    });
    if (!_isRefreshed) {
      _isRefreshed = true;
    } else {
      _isRefreshed = false;
    }
    final service = Wallpaperservices();
    final data = await service.fetchWallpaper(
      page: _page,
      query: widget.search,
    );
    setState(() {
      Images.addAll(data);
      _page++;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final setting = Get.find<GlobalSetting>();
    return BasePage(
      searchBar: MySearchBar(
        onSearch: (value) {
          setState(() {
            widget.search = value;
            Images.clear();
            _page = 1;
            fetchAPI();
          });
        },
      ),
      body: CustomScrollView(
        controller: widget._scrollController,
        slivers: [
          const SliverPadding(
            padding: EdgeInsetsGeometry.only(
              top: 70,
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 120,

              width: double.infinity,
              child: ListView.builder(
                itemCount: catagoryNames.length,
                scrollDirection: Axis.horizontal,

                itemBuilder: (context, index) {
                  bool isSelected =
                      index == selectedCat;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.search = isSelected
                            ? ''
                            : catagoryNames[index];
                        selectedCat = isSelected
                            ? -1
                            : index;
                        Images.clear();

                        _page = 1;
                        fetchAPI();
                      });
                    },
                    child: Padding(
                      padding:
                          const EdgeInsets.all(
                            8.0,
                          ),
                      child: AnimatedScale(
                        scale: isSelected
                            ? 1.1
                            : 1,
                        duration: const Duration(
                          milliseconds: 200,
                        ),
                        child: Material(
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadiusGeometry.circular(
                                  10,
                                ),
                            side: BorderSide(
                              width: isSelected
                                  ? 4
                                  : 1,
                              color: isSelected
                                  ? Colors.white54
                                  : Colors
                                        .white24,
                            ),
                          ),
                          child: MyCatagoryPage(
                            catagoryLink:
                                catagoryBackgroundUrl[index],
                            catagoryName:
                                catagoryNames[index],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SliverPadding(
            padding: EdgeInsetsGeometry.only(
              top: 10,
            ),
          ),
          SliverMasonryGrid.count(
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            crossAxisCount: setting.gridCol.value
                .toInt(),
            childCount: Images.length,
            itemBuilder: (context, index) {
              widget.count =
                  (index.toDouble() %
                      setting.gridCol.value) +
                  1;
              return GestureDetector(
                onTap: () {
                  Get.to(
                    Mywallpaperprevpage(
                      url:
                          Images[index]['src']['portrait'],
                      title: Images[index]['alt'],
                      photographer:
                          Images[index]['photographer'],
                      uniqueId:
                          Images[index]['id'],
                    ),
                  );
                },
                child: Material(
                  borderRadius:
                      BorderRadius.circular(20.0),
                  elevation: 8,
                  shadowColor: HexColor(
                    Images[index]['avg_color'],
                  ),

                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(
                          20.0,
                        ),
                    child: CachedNetworkImage(
                      imageUrl:
                          Images[index]['src'][setting
                              .previewQuality
                              .value],
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
                              child:
                                  CircularProgressIndicator(
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

                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                      height:
                          150 * widget.count > 300
                          ? 300
                          : 150 * widget.count <
                                200
                          ? 200
                          : 150 * widget.count,
                      errorWidget:
                          (
                            context,
                            url,
                            error,
                          ) => const Icon(
                            Icons.error_outline,
                            color: Colors.red,
                          ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
