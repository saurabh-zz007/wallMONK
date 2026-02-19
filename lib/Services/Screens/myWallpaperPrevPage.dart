import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_media_downloader/flutter_media_downloader.dart';
import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
//import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class Mywallpaperprevpage extends StatefulWidget {
  String url;
  String title;
  String photographer;
  int uniqueId;
  bool _isFavorite = false;
  Mywallpaperprevpage({
    super.key,
    required this.url,
    required this.title,
    required this.photographer,
    required this.uniqueId,
  });

  @override
  State<Mywallpaperprevpage> createState() =>
      _MywallpaperprevpageState();
}

class _MywallpaperprevpageState
    extends State<Mywallpaperprevpage> {
  @override
  void initState() {
    checkFav();
    super.initState();
  }

  final user = FirebaseAuth.instance.currentUser;
  Future<void> checkFav() async {
    final doc = await FirebaseFirestore.instance
        .collection('user')
        .doc(user!.uid)
        .collection('favourites')
        .doc(widget.uniqueId.toString())
        .get();
    setState(() {
      widget._isFavorite = doc.exists;
    });
  }

  void removeFromFavorites() {
    setState(() {
      widget._isFavorite = false;
      FirebaseFirestore.instance
          .collection('user')
          .doc(user!.uid)
          .collection('favourites')
          .doc(widget.uniqueId.toString())
          .delete();
    });
  }

  void addToFavorites() {
    setState(() {
      FirebaseFirestore.instance
          .collection('user')
          .doc(user!.uid)
          .collection('favourites')
          .doc(widget.uniqueId.toString())
          .set({
            'uniqueId': widget.uniqueId,
            'addedAt':
                FieldValue.serverTimestamp(),
            'url': widget.url,
            'title': widget.title,
            'photographer': widget.photographer,
          });
      widget._isFavorite = true;
    });
  }

  Future<void> downloadImage() async {
    MediaDownload().downloadMedia(
      context,
      widget.url,
      '',
      'wallMonk${widget.uniqueId}.png',
    );
    Get.snackbar(
      "Success",
      "Image downloaded successfully",
      duration: const Duration(seconds: 1),
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  Future<void> setWallpaper() async {
    try {
      await AsyncWallpaper.setWallpaper(
        url: widget.url,
        wallpaperLocation:
            AsyncWallpaper.BOTH_SCREENS,
        goToHome: false,
      );

      Get.snackbar(
        "Success",
        "Wallpaper set successfully",

        duration: const Duration(seconds: 1),
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            child: Image.network(
              widget.url,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 25,
            left: 16,
            right: 16,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                20,
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 2,
                  sigmaY: 2,
                ),
                child: Material(
                  elevation: 6,
                  color: Colors.white24,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      color: Colors.white38,
                      width: 1.5,
                    ),
                    borderRadius:
                        BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(
                      16.0,
                    ),
                    child: Column(
                      spacing: 20,
                      mainAxisAlignment:
                          MainAxisAlignment
                              .spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment
                                  .spaceAround,
                          spacing: 20,
                          children: [
                            Flexible(
                              child: GestureDetector(
                                onTap: () {
                                  setWallpaper();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(
                                          0xFF6779E4,
                                        ),
                                        Color(
                                          0xff754ea7,
                                        ),
                                      ],
                                    ),
                                    borderRadius:
                                        BorderRadius.circular(
                                          20,
                                        ),
                                  ),
                                  child: const Padding(
                                    padding:
                                        EdgeInsets.all(
                                          16.0,
                                        ),
                                    child: Row(
                                      spacing: 10,
                                      mainAxisAlignment:
                                          MainAxisAlignment
                                              .center,
                                      children: [
                                        Icon(
                                          Icons
                                              .wallpaper_outlined,
                                          size:
                                              20,
                                          color: Colors
                                              .white,
                                        ),
                                        Text(
                                          "Set Wallpaper",
                                          style: TextStyle(
                                            color:
                                                Colors.white,
                                            fontSize:
                                                16,
                                            fontWeight:
                                                FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                downloadImage();
                              },
                              child: Material(
                                elevation: 6,
                                color: Colors
                                    .white24,
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                    color: Colors
                                        .white38,
                                    width: 1.5,
                                  ),
                                  borderRadius:
                                      BorderRadius.circular(
                                        10,
                                      ),
                                ),
                                child: const Padding(
                                  padding:
                                      EdgeInsets.all(
                                        8.0,
                                      ),
                                  child: Icon(
                                    Icons
                                        .download,
                                    color: Colors
                                        .white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 1,
                          color: Colors.white38,
                        ),
                        Text(
                          widget.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                        Text(
                          "By ${widget.photographer}",
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 20,
            right: 20,
            child: GestureDetector(
              onTap: () {
                if (widget._isFavorite) {
                  removeFromFavorites();
                } else {
                  addToFavorites();
                }
              },
              child: Material(
                elevation: 6,
                color: Colors.white24,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    color: Colors.white38,
                    width: 1.5,
                  ),
                  borderRadius:
                      BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(
                    8.0,
                  ),
                  child: widget._isFavorite
                      ? const Icon(
                          Icons.favorite,
                          color: Colors.redAccent,
                        )
                      : const Icon(
                          Icons
                              .favorite_border_outlined,
                          color: Colors.white,
                        ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 20,
            left: 20,
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Material(
                elevation: 6,
                color: Colors.white24,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    color: Colors.white38,
                    width: 1.5,
                  ),
                  borderRadius:
                      BorderRadius.circular(10),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(
                    8.0,
                  ),
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
