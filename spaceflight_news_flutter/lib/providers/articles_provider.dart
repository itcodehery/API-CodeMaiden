import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spaceflight_news_flutter/models/article.dart';

part 'articles_provider.g.dart';

@riverpod
class ArticlesNotifier extends _$ArticlesNotifier {
  @override
  Set<Article> build() {
    return {};
  }

  void addArticle(Article article) {
    state = {...state, article};
  }

  void removeArticle(Article article) {
    state = {...state}..remove(article);
  }
}
