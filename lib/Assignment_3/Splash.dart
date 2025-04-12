import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to the IntroSlider after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/intro');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xff24BAEC),
        ),
        child: Stack(
          children: [
            Center(
              child: Image.asset(
                'assets/Travernor_icon.png',
                width: 150,
                height: 150,
              ),
            ),
            // Bottom image
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Image.asset(
                  'assets/Travenor.png',
                  width: 200,
                  height: 50,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}