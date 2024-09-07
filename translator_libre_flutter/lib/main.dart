import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:translator_libre_flutter/pages/home_page.dart';
import 'package:translator_libre_flutter/pages/auth_page.dart';
import 'package:translator_libre_flutter/pages/widget_tree.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => const WidgetTree(),
        '/home': (context) => const HomePage(),
        '/auth': (context) => const AuthPage(),
      },
    );
  }
}
