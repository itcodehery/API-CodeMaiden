import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:translator_libre_flutter/models/lang_resp_model.dart';

part 'language_provider.g.dart';

@riverpod
Future<LRM> fetchLanguages(ref) async {
  LRM languageList = LRM(
    code: "",
    name: "",
    targets: [],
  );
  final response = await http.get(
    Uri.parse("https://libretranslate.com/languages"),
  );
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    languageList = LRM.fromJson(data[0]);

    debugPrint(data[0]['targets'].toString());
  } else {
    debugPrint("Error");
  }
  return languageList;
}
