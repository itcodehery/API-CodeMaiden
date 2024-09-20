import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xposed_or_not_flutter/models/breach_analytics.dart';
import 'package:xposed_or_not_flutter/provider/email_provider.dart';

part 'breach_analytics_provider.g.dart';

@riverpod
Future<BreachAnalytics> fetchBreachAnalytics(ref) async {
  final email = ref.watch(emailNotifierProvider);
  try {
    debugPrint("inside fetchBreachAnalytics");
    var response = await http.get(Uri.parse(
        "https://api.xposedornot.com/v1/breach-analytics?email=$email"));
    if (response.statusCode == 200) {
      debugPrint(response.body);
      return BreachAnalytics.fromJson(jsonDecode(response.body));
    } else {
      debugPrint(response.body);
      throw Exception('Failed to load response data!');
    }
  } catch (e) {
    debugPrint(e.toString());
    throw Exception('Failed to load breach analytics!');
  }
}
