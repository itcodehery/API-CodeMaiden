import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xposed_or_not_flutter/models/breached_sites.dart';
import 'package:xposed_or_not_flutter/provider/email_provider.dart';

part 'breached_sites_provider.g.dart';

@riverpod
Future<BreachedSites> fetchBreachedSites(ref) async {
  final email = ref.watch(emailNotifierProvider);
  try {
    debugPrint("inside fetchBreachedSites");
    var response = await http
        .get(Uri.parse("https://api.xposedornot.com/v1/check-email/$email"));
    if (response.statusCode == 200) {
      debugPrint(response.body);
      return BreachedSites.fromJson(jsonDecode(response.body));
    } else {
      debugPrint(response.body);
      return BreachedSites(breaches: []);
    }
  } catch (e) {
    debugPrint(e.toString());
    return BreachedSites(breaches: []);
  }
}
