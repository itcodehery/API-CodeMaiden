import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'username_provider.g.dart';

@riverpod
Future<String> fetchName(ref) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? name = prefs.getString('user_name');
  return name ?? '';
}
