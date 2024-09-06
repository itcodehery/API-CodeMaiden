import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spaceflight_news_flutter/models/article.dart';
import 'package:http/http.dart' as http;

part 'articles_provider.g.dart';

@riverpod
Future<Set<Article>> allArticles(ref) async {
  Set<Article> articles = {};
  try {
    final response = await http
        .get(Uri.https('api.spaceflightnewsapi.net', '/v4/articles/'));
    final jsonDecoded = jsonDecode(response.body);
    for (var article in jsonDecoded['results']) {
      final arti = Article.fromJson(article);
      articles.add(arti);
    }
    return articles;
  } catch (e) {
    // Handle error, maybe log it or update the state to reflect the error state
    debugPrint("Error fetching articles: $e");
    return articles;
  }
}
