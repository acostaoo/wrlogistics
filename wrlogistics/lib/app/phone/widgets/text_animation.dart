// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class MaterializeTextAnimation extends StatefulWidget {
  const MaterializeTextAnimation({super.key});

  @override
  _MaterializeTextAnimationState createState() => _MaterializeTextAnimationState();
}

class _MaterializeTextAnimationState extends State<MaterializeTextAnimation> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    CurvedAnimation curve = CurvedAnimation(parent: _controller, curve:Curves.easeInOut);

    // Create a tween that animates opacity from 0.0 to 1.0
    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(curve);

    // Create a tween that animates vertical slide from -50.0 to 0.0
    _slideAnimation =Tween<Offset>(
      begin: const Offset(0.0, -1),
      end: const Offset(0.0, 0.0),
    ).animate(_controller);

    // Start the animation
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return  Center(
        child: FadeTransition(
          opacity: _opacityAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: const Text(
              '¡Bienvenido! Necesitamos tu número de teléfono.',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ),
    );
  }

  @override
  void dispose() {
    // Dispose of the animation controller
    _controller.dispose();
    super.dispose();
  }
}
