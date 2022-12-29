import 'package:flutter/material.dart';

import 'app/home/presentation/pages/home/home_page.dart';

// ignore: use_key_in_widget_constructors
class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool showTitle = false;
  @override
  void initState() {
    super.initState();
    enableTitle();
  }

  enableTitle() async {
    await Future.delayed(
      const Duration(
        seconds: 2,
      ),
    );
    setState(() {
      showTitle = true;
    });
    await Future.delayed(
      const Duration(
        seconds: 2,
      ),
    );
    navigateToHome();
  }

  navigateToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Spacer(),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Image(
                image: const AssetImage(
                  "asset/github.png",
                ),
                width: MediaQuery.of(context).size.width * 0.6,
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          AnimatedOpacity(
            opacity: showTitle ? 1 : 0,
            curve: Curves.easeInOut,
            duration: const Duration(
              seconds: 2,
            ),
            child: Text(
              'Rick And Morty',
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
