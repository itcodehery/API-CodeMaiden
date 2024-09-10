import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:toastification/toastification.dart';
import 'package:translator_libre_flutter/pages/home_page.dart';
import 'package:translator_libre_flutter/pages/auth_page.dart';
import 'package:translator_libre_flutter/pages/widget_tree.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await Supabase.initialize(
    url: dotenv.env['PROJ_URL']!,
    anonKey: dotenv.env['PROJ_KEY']!,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const WidgetTree(),
          '/home': (context) => const HomePage(),
          '/auth': (context) => const AuthPage(),
        },
      ),
    );
  }
}
