import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xposed_or_not_flutter/provider/breached_sites_provider.dart';
import 'package:xposed_or_not_flutter/provider/email_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final email = ref.watch(fetchEmailProvider);
    final breachedSites = ref.watch(fetchBreachedSitesProvider);
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          ListTile(
            title: Text("Email: ${email.value}"),
          ),
          ListTile(
            title: Text(
                "Breached Sites: ${breachedSites.value?.breaches.length ?? "0"}"),
          ),
        ],
      ),
    ));
  }
}
