import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pertemuan8/firebase_options.dart';
import 'package:pertemuan8/pages/login_page.dart';
//import 'package:pertemuan8/pages/scale_animation_screen.dart';
//import 'package:pertemuan8/pages/fade_animation_screen.dart';
//import 'package:pertemuan8/pages/rotate_animation_screen.dart';
import 'package:pertemuan8/pages/splash_screen.dart'; 

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple),
        // Ubah sesuai dengan preferensi tema Anda
      ),
      home: const SplashScreen(), // Ganti home dengan SplashScreen
      routes: {
        '/login': (context) => const LoginPage(), // Tentukan rute login page
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (_) => const Scaffold(body: Center(child: Text('Route not found'))));
      },
      onGenerateRoute: (settings) {
        // Kustomisasi tambahan untuk rute
        return MaterialPageRoute(builder: (_) => const Scaffold(body: Center(child: Text('Route not found'))));
      },
    );
  }
}