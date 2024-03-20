import 'package:flutter/material.dart';

class LnFItem extends StatelessWidget {
  const LnFItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'LnF',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: const Center(
        child: Text(
          'Hello',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
