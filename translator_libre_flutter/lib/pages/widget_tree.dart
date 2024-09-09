import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:translator_libre_flutter/constants.dart';

class WidgetTree extends ConsumerStatefulWidget {
  const WidgetTree({super.key});

  @override
  _WidgetTreeState createState() => _WidgetTreeState();
}

class _WidgetTreeState extends ConsumerState<WidgetTree> {
  @override
  void initState() {
    super.initState();
    _redirect();
  }

  Future<void> _redirect() async {
    await Future.delayed(Duration.zero);
    debugPrint('inside redirect!');
    final session = supabase.auth.currentSession;
    if (!mounted) return;
    if (session != null) {
      Navigator.of(context).pushReplacementNamed("/home");
    } else {
      Navigator.of(context).pushReplacementNamed("/auth");
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('LibreTranslate', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
