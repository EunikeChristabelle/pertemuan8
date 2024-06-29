import 'package:flutter/material.dart';

class FadeAnimationScreen extends StatefulWidget {
  const FadeAnimationScreen({super.key});

  @override
  State<FadeAnimationScreen> createState() => _FadeAnimationScreenState();
}

class _FadeAnimationScreenState extends State<FadeAnimationScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
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
      appBar: AppBar(title: const Text('Fade Animation')),
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: const FlutterLogo(size: 200),
        ),
      ),
    );
  }
}
