import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacementNamed(context, '/home_page');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff01402E),
      child: Center(
        child: Lottie.asset(
          "images/plant-animation.json",
          fit: BoxFit.fitWidth,
          repeat: false,
          // frameRate: FrameRate(15),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
