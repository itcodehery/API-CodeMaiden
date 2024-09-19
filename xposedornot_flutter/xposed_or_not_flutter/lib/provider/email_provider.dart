import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'email_provider.g.dart';

@riverpod
Future<String> fetchEmail(ref) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? email = prefs.getString('user_email');
  return email ?? '';
}
