import 'package:flutter/material.dart';
import 'package:spaceflight_news_flutter/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SpaceFlight',
      initialRoute: "/",
      routes: {
        "/": (context) => const HomeScreen(),
      },
    );
  }
}
