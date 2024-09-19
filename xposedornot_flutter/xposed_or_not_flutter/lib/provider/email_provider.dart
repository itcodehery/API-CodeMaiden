import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'email_provider.g.dart';

@riverpod
class EmailNotifier extends _$EmailNotifier {
  // initial value
  @override
  Future<String> build() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('user_email');
    return email ?? '';
  }

  // update the value
  void updateEmail(String email) {
    debugPrint("inside updateEmail");
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString('user_email', email);
      state = AsyncValue.data(email);
    });
  }

  // clear the value
  void clearEmail() {
    debugPrint("inside clearEmail");
    SharedPreferences.getInstance().then((prefs) {
      prefs.remove('user_email');
      state = const AsyncValue.data('');
    });
  }
}
