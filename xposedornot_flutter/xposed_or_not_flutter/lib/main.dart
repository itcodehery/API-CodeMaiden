import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xposed_or_not_flutter/helpers/constants.dart';
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
        colorScheme: ColorScheme(
          primary: Colors.indigo.shade300,
          // primaryVariant: Colors.indigo[700],
          secondary: Colors.indigo.shade400,
          // secondaryVariant: Colors.indigo[700],
          surface: scaffoldColor!,
          error: Colors.red,

          onPrimary: Colors.grey,
          onSecondary: Colors.grey,
          onSurface: Colors.white,
          onError: Colors.white,
          brightness: Brightness.light,
        ),
        textTheme: GoogleFonts.outfitTextTheme(),
      ),
      home: const SplashPage(),
      routes: {
        '/login': (context) => const SplashPage(),
      },
    );
  }
}
