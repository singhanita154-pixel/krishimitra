import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const KrishiMitraApp());
}

class KrishiMitraApp extends StatelessWidget {
  const KrishiMitraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KrishiMitra',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green, // farmer-facing main theme
        scaffoldBackgroundColor: Colors.green[50],
      ),
      home: const LoginScreen(),
    );
  }
}
