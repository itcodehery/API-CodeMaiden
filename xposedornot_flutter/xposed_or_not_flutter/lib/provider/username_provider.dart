import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'username_provider.g.dart';

@riverpod
// Future<String> fetchName(ref) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   String? name = prefs.getString('user_name');
//   return name ?? '';
// }
class UsernameNotifier extends _$UsernameNotifier {
  // initial value
  @override
  Future<String> build() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? name = prefs.getString('user_name');
    return name ?? '';
  }

  // update the value
  void updateName(String name) {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString('user_name', name);
      state = AsyncValue.data(name);
    });
  }

  // clear the value
  void clearName() {
    SharedPreferences.getInstance().then((prefs) {
      prefs.remove('user_name');
      state = const AsyncValue.data('');
    });
  }
}
