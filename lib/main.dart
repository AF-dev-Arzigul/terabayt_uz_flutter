import 'package:flutter/material.dart';
import 'package:terabayt_uz/di/di.dart';
import 'package:terabayt_uz/screens/main_screen.dart';

void main() {
  setUp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Terabayt uz',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: const MainScreen(),
    );
  }
}
