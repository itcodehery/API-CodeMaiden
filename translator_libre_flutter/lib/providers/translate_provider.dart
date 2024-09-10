import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final translateProvider = Provider((ref) => TranslateProvider());

class TranslateProvider {
  Future<String> translate(
      String text, String sourceLanguage, String targetLanguage) async {
    final url = Uri.parse('https://libretranslate.com/translate');
    final response = await http.post(
      url,
      body: {
        'q': text,
        'source': sourceLanguage,
        'target': targetLanguage,
      },
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception(
          'Failed to translate text, response code: ${response.statusCode}, response body: ${response.body}');
    }
  }
}
