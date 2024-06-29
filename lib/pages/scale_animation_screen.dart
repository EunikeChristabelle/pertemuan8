import 'package:flutter/material.dart';

class ScaleAnimationScreen extends StatefulWidget {
  const ScaleAnimationScreen({super.key});

  @override
  State<ScaleAnimationScreen> createState() => _ScaleAnimationScreenState();
}

class _ScaleAnimationScreenState extends State<ScaleAnimationScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = Tween<double>(begin: 0.5, end: 1).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scale Animation')),
      body: Center(
        child: ScaleTransition(
          scale: _animation,
          child: const FlutterLogo(size: 200),
        ),
      ),
    );
  }
}
