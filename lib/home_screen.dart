import 'package:flutter/material.dart';
import 'login_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.white,
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 60,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(key: ValueKey('loginPage')),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF914D),
                  shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(25)),
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
                child: const Text(
                  'Get Started',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/1.png', // Replace with your image path
                  width: 150,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Get your things back here!',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFFFF914D),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
