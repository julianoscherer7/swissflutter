import 'package:flutter/material.dart';
import 'package:swiss_army_knife/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Swiss Army Knife',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          primary: Colors.deepPurple,
          secondary: Colors.orange,
          background: Colors.grey[50],
        ),
        useMaterial3: true,
        fontFamily: 'Poppins',
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}