import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xposed_or_not_flutter/helpers/constants.dart';
import 'package:xposed_or_not_flutter/helpers/custom_gauge.dart';
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
    final email = ref.watch(emailNotifierProvider);
    final userName = ref.watch(usernameNotifierProvider);
    final breachedSites = ref.watch(fetchBreachedSitesProvider);

    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  IconButton(
                    style: appBarButtons,
                    icon: const Icon(Icons.logout),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Logout",
                                style: TextStyle(color: Colors.white)),
                            content: const Text(
                              "Are you sure you want to logout?",
                              style: TextStyle(color: Colors.white),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  ref
                                      .read(emailNotifierProvider.notifier)
                                      .clearEmail();
                                  ref
                                      .read(usernameNotifierProvider.notifier)
                                      .clearName();
                                  Navigator.pushReplacementNamed(
                                      context, '/login');
                                },
                                child: const Text("Yes"),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text("No"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  const Spacer(),
                  IconButton(
                      style: appBarButtons,
                      onPressed: () {},
                      icon: const Icon(Icons.settings_outlined)),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Text(
                  "Hello,\n${userName.value}",
                  style: const TextStyle(
                      fontSize: 44,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
            ),
            CustomPaint(
              size: const Size(200, 200),
              painter: CircularGaugePainter(
                  breachedSites.value?.breaches.length.toDouble() ?? 0.0, 100),
            ),
            ListTile(
              title: Text("${email.value}"),
              subtitle: Text(
                  "Status: ${getStatus(breachedSites.value?.breaches.length ?? 0)}"),
              trailing: Icon(
                  getStatus(breachedSites.value?.breaches.length ?? 0) ==
                          "No Breaches"
                      ? Icons.verified_user
                      : Icons.warning),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/breach_analytics');
                },
                child: const Text(
                  "View Detailed Analysis",
                  style: TextStyle(color: Colors.white),
                )),
            getStatus(breachedSites.value?.breaches.length ?? 0) ==
                    "Actions Required"
                ? Card(
                    child: ListTile(
                      title: Text(
                          "Breached Sites: ${breachedSites.value?.breaches.length ?? "0"}"),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    ));
  }
}
