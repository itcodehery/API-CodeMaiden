import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xposed_or_not_flutter/models/breach_analytics.dart';
import 'package:xposed_or_not_flutter/provider/breach_analytics_provider.dart';
import 'package:xposed_or_not_flutter/provider/email_provider.dart'; // Assuming the class you provided is in models

class BreachAnalyticsPage extends ConsumerWidget {
  const BreachAnalyticsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final breachAnalyticsAsync = ref.watch(fetchBreachAnalyticsProvider);
    final email = ref.watch(emailNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          title: const Text("Breach Analytics"),
          subtitle: Text("for ${email.value}"),
        ),
      ),
      body: breachAnalyticsAsync.when(
        data: (breachAnalytics) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                _buildBreachSummary(breachAnalytics.breachesSummary),
                _buildPastesSummary(breachAnalytics.pastesSummary),
                const SizedBox(height: 20),
                const Text(
                  "Additional Metrics",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Divider(),
                _buildBreachMetrics(breachAnalytics.breachMetrics),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(
            child: SizedBox(
          width: 300,
          child: Text("Oops! We couldn't find data with your email!",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.indigo.shade200, fontSize: 20)),
        )),
      ),
    );
  }

  Widget _buildBreachSummary(BreachesSummary summary) {
    return Card(
      elevation: 2,
      child: ListTile(
        title: const Text("Breaches Summary"),
        subtitle: Text("Site: ${summary.site}"),
      ),
    );
  }

  Widget _buildPastesSummary(PastesSummary summary) {
    return Card(
      elevation: 2,
      child: ListTile(
        title: const Text("Pastes Summary"),
        subtitle: Text(
            "Domain: ${summary.domain}\nCount: ${summary.cnt}\nTimestamp: ${summary.tmpstmp}"),
      ),
    );
  }

  Widget _buildBreachMetrics(BreachMetrics metrics) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Yearwise Breach Details:",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        for (var yearDetail in metrics.yearwiseDetails)
          Text(yearDetail.toString()),
        const SizedBox(height: 10),
        const Text(
          "Password Strength:",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        for (var strength in metrics.passwordsStrength)
          Text(
              "Easy to Crack: ${strength.easyToCrack}, Strong Hash: ${strength.strongHash}, Unknown: ${strength.unknown}"),
        const SizedBox(height: 10),
        const Text(
          "Risk Analysis:",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        for (var risk in metrics.risk)
          Text("${risk.riskLabel}: ${risk.riskScore}"),
      ],
    );
  }
}
