import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MyFavouritesPage extends StatefulWidget {
  const MyFavouritesPage({super.key});

  @override
  State<MyFavouritesPage> createState() =>
      _MyFavouritesPageState();
}

class _MyFavouritesPageState
    extends State<MyFavouritesPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
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
            "Sorry! Area under construction",
            style: TextStyle(
              fontSize:
                  MediaQuery.of(
                    context,
                  ).size.height *
                  0.02,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Your favourites will be safe with us, once the work is done you can check the list of your favourites.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white38,

              fontSize:
                  MediaQuery.of(
                    context,
                  ).size.height *
                  0.015,
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
      ),
    );
  }
}
