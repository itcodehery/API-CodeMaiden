import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xposed_or_not_flutter/pages/email_enter_page.dart';
import 'package:xposed_or_not_flutter/pages/home_page.dart';
import 'package:xposed_or_not_flutter/provider/email_provider.dart';
import 'package:xposed_or_not_flutter/provider/username_provider.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();
    fetchEmail();
  }

  Future<void> fetchEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('user_email');
    if (email != null) {
      // Email exists, redirect to HomeScreen
      // build the username notifier so that it updates values in the home page
      await ref.read(usernameNotifierProvider.notifier).build().then((v) {
        if (mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        }
      });
    } else {
      // No email found, prompt user to enter email
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const EmailEnterPage()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("XposedOrNot",
            style: TextStyle(fontSize: 24, color: Colors.indigo)),
      ),
    );
  }
}
