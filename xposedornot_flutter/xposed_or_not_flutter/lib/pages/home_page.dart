import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xposed_or_not_flutter/provider/breached_sites_provider.dart';
import 'package:xposed_or_not_flutter/provider/email_provider.dart';
import 'package:xposed_or_not_flutter/provider/username_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  String getStatus(int num) {
    if (num == 0) {
      return "No Breaches";
    } else {
      return "Actions Required";
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final email = ref.watch(fetchEmailProvider);
    final userName = ref.watch(fetchNameProvider);
    final breachedSites = ref.watch(fetchBreachedSitesProvider);
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Text(
                "Hello,\n${userName.value}",
                style:
                    const TextStyle(fontSize: 44, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Card(
            child: ListTile(
              title: Text("${email.value}"),
              subtitle: Text(
                  "Status: ${getStatus(breachedSites.value?.breaches.length ?? 0)}"),
              trailing: Icon(
                  getStatus(breachedSites.value?.breaches.length ?? 0) ==
                          "No Breaches"
                      ? Icons.verified_user
                      : Icons.warning),
            ),
          ),
          getStatus(breachedSites.value?.breaches.length ?? 0) ==
                  "Actions Required"
              ? Card(
                  child: ListTile(
                    title: Text(
                        "Breached Sites: ${breachedSites.value?.breaches.length ?? "0"}"),
                  ),
                )
              : Container(),
          TextButton(
              onPressed: () {
                // notifiers for all of em
              },
              child: const Text("Logout"))
        ],
      ),
    ));
  }
}
