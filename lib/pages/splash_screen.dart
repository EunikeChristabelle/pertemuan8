import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pertemuan8/pages/home_page.dart'; // Ubah sesuai dengan nama file yang sesuai dengan aplikasi Anda

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(), // Tampilkan splash screen sebagai home pertama
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Tunggu beberapa detik sebelum pindah ke halaman berikutnya
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            FlutterLogo(size: 100),
            SizedBox(height: 24),
            Text('Welcome to My App', style: TextStyle(fontSize: 24)),
          ],
        ),
      ),
    );
  }
}
