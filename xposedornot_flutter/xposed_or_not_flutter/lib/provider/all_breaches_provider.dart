import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xposed_or_not_flutter/models/all_breaches.dart';
import 'package:xposed_or_not_flutter/provider/email_provider.dart';

@riverpod
Future<AllBreaches> fetchAllBreaches(ref) async {
  try {
    debugPrint("inside fetchAllBreaches");
    var response =
        await http.get(Uri.parse("https://api.xposedornot.com/v1/breaches"));
    final headers = {
      'x-api-key': 'your-api-key-here', // Replace with your actual API key
      'Content-Length': '0',
    };
    if (response.statusCode == 200) {
      debugPrint(response.body);
      return allBreachesFromJson(response.body);
    } else {
      debugPrint(response.body);
      throw Exception('Failed to load response data!');
    }
  } catch (e) {
    debugPrint(e.toString());
    throw Exception('Failed to load all breaches!');
  }
}
