import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:security_api_flutter/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Secure Space',
      theme: ThemeData(
        textTheme: GoogleFonts.rubikTextTheme(),
        primarySwatch: Colors.orange,
      ),
      home: const HomePage(),
    );
  }
}
