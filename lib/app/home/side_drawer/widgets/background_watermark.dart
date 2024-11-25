import 'package:flutter/material.dart';

class WatermarkWidget extends StatelessWidget {
  const WatermarkWidget({super.key});

  //TODO to implement correctly

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Background with Logo
        Image.asset(
          'assets/wrlogo.png',
          fit: BoxFit.cover,
        ),
        // Your Content
        const Center(
          child: Text(
            'Your Content Here',
            style: TextStyle(
              color: Colors.white, // Adjust text color to contrast with the logo
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
