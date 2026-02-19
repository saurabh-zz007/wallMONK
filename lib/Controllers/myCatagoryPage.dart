import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MyCatagoryPage extends StatefulWidget {
  String catagoryName;
  String catagoryLink;

  MyCatagoryPage({
    super.key,
    required this.catagoryName,
    required this.catagoryLink,
  });

  @override
  State<MyCatagoryPage> createState() =>
      _MyCatagoryPageState();
}

class _MyCatagoryPageState
    extends State<MyCatagoryPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white38,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            alignment: AlignmentGeometry.center,
            children: [
              CachedNetworkImage(
                imageUrl: widget.catagoryLink,
                fit: BoxFit.cover,
                progressIndicatorBuilder:
                    (context, url, progress) =>
                        CircularProgressIndicator(
                          value:
                              progress.progress,
                        ),
              ),
              /*Image.network(
                widget.catagoryLink,
                fit: BoxFit.cover,
              ),*/
              Container(
                height: 120,
                width: 152,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(
                    127,
                    0,
                    0,
                    0,
                  ),
                  borderRadius:
                      BorderRadius.circular(10),
                ),
              ),
              Text(
                widget.catagoryName,
                style: const TextStyle(
                  color: Color.fromARGB(
                    255,
                    222,
                    210,
                    210,
                  ),
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
