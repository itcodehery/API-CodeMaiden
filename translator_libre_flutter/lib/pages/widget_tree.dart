import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketbase/pocketbase.dart';

// PocketBase instance provider
final pocketBaseProvider =
    Provider((ref) => PocketBase('http://127.0.0.1:8090/'));

class WidgetTree extends ConsumerStatefulWidget {
  const WidgetTree({super.key});

  @override
  _WidgetTreeState createState() => _WidgetTreeState();
}

class _WidgetTreeState extends ConsumerState<WidgetTree> {
  @override
  void initState() {
    super.initState();

    // Use a post-frame callback to navigate after the build is complete
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final pb = ref.read(pocketBaseProvider);

      // Check if the user is authenticated
      if (pb.authStore.isValid) {
        Navigator.of(context).pushReplacementNamed('/home');
      } else {
        Navigator.of(context).pushReplacementNamed('/auth');
      }
    });
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
