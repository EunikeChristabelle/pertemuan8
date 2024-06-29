import 'package:flutter/material.dart';

class RotateAnimationScreen extends StatefulWidget {
  const RotateAnimationScreen({super.key});

  @override
  State<RotateAnimationScreen> createState() => _RotateAnimationScreenState();
}

class _RotateAnimationScreenState extends State<RotateAnimationScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = Tween<double>(begin: 0, end: 2 * 3.14).animate(_controller);
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
      appBar: AppBar(title: const Text('Rotate Animation')),
      body: Center(
        child: RotationTransition(
          turns: _animation,
          child: const FlutterLogo(size: 200),
        ),
      ),
    );
  }
}
