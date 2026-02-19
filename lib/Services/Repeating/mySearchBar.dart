import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:signin_page/Controllers/colorScheme.dart';

class MySearchBar extends StatefulWidget {
  final Function(String) onSearch;
  const MySearchBar({
    super.key,
    required this.onSearch,
  });

  @override
  State<MySearchBar> createState() =>
      _MySearchBarState();
}

class _MySearchBarState
    extends State<MySearchBar> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 300,
        maxHeight: 50,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 2.0,
            sigmaY: 2.0,
          ),
          child: Material(
            color: Colorscheme.colorbg20,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Colorscheme.color40,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(
                20,
              ),
            ),
            child: TextField(
              onSubmitted: (value) {
                widget.onSearch(value);
              },
              cursorColor: Colorscheme.color30,

              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(20),
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                prefixIcon: const Icon(
                  Icons.search_outlined,
                ),
                hintText: 'Search Wallpapers...',
                hintStyle: const TextStyle(),
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(20),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
