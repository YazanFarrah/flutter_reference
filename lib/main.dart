import 'package:flutter/material.dart';
import 'package:flutter_reference/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

const startAlignment = Alignment.bottomLeft;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
