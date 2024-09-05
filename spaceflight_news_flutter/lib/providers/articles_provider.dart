import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spaceflight_news_flutter/models/article.dart';

part 'articles_provider.g.dart';

final dio = Dio();

@riverpod
class ArticlesNotifier extends _$ArticlesNotifier {
  @override
  Set<Article> build() {
    return {};
  }

  Future<void> request() async {
    try {
      final response =
          await dio.get("https://api.spaceflightnewsapi.net/v3/articles");
      // Dio automatically decodes JSON when possible, no need for jsonDecode here
      final List<dynamic> articles = response.data;
      state = articles.map((article) => Article.fromJson(article)).toSet();
    } catch (e) {
      // Handle error, maybe log it or update the state to reflect the error state
      debugPrint("Error fetching articles: $e");
    }
  }
}

@riverpod
Future<Set<Article>> fetchArticles() async {
  try {
    final response =
        await dio.get("https://api.spaceflightnewsapi.net/v3/articles");
    final List<dynamic> articles = response.data;
    return articles.map((article) => Article.fromJson(article)).toSet();
  } catch (e) {
    // Handle error, e.g., return an empty set or throw an error to be handled by the caller
    debugPrint("Error fetching articles: $e");
    return {}; // or throw e;
  }
}
