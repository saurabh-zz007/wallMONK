import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MyDownloadsPage extends StatefulWidget {
  const MyDownloadsPage({super.key});

  @override
  State<MyDownloadsPage> createState() =>
      _MyDownloadsPageState();
}

class _MyDownloadsPageState
    extends State<MyDownloadsPage> {
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
