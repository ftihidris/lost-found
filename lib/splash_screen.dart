import 'dart:async';
import 'package:flutter/material.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToNextScreen(context);
  }

  Future<void> navigateToNextScreen(BuildContext context) async {
    // Simulate a delay for the splash screen
    await Future.delayed(const Duration(seconds: 1));

    // Navigate to the next screen (replace with your desired screen)
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/1.png', // Replace with your image path
              width: 150,
            ),
            const SizedBox(height: 16),

            
          ],
        ),
      ),
    );
  }
}
