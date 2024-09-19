import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xposed_or_not_flutter/pages/splash_page.dart';

void main() {
  runApp(const ProviderScope(child: XposedOrNot()));
}

class XposedOrNot extends StatelessWidget {
  const XposedOrNot({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Xposed or Not',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        primaryColor: Colors.indigo,
        primaryColorDark: Colors.indigo[700],
        colorScheme: const ColorScheme(
          primary: Colors.indigo,
          // primaryVariant: Colors.indigo[700],
          secondary: Colors.indigo,
          // secondaryVariant: Colors.indigo[700],
          surface: Colors.white,
          error: Colors.red,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: Colors.black,
          onError: Colors.white,
          brightness: Brightness.light,
        ),
        textTheme: GoogleFonts.outfitTextTheme(),
      ),
      home: const SplashPage(),
    );
  }
}
