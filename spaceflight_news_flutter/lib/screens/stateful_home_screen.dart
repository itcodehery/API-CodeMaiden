import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spaceflight_news_flutter/providers/articles_provider.dart';

class StatefulHomeScreen extends ConsumerWidget {
  const StatefulHomeScreen({super.key});
  // final _tabController = TabController(length: 2, vsync: AnimatedGridState());

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SpaceFlight News"),
      ),
      body: const MainArticlesWidget(),
    );
  }
}

class MainArticlesWidget extends ConsumerWidget {
  const MainArticlesWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allArticles = ref.watch(allArticlesProvider);
    return switch (allArticles) {
      AsyncData(:final value) => ListView.builder(
          itemCount: value.length,
          itemBuilder: (context, index) => Card(
                margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: ListTile(
                  title: Text(value.elementAt(index).title),
                  subtitle: Text(value.elementAt(index).publishedAt.toString()),
                ),
              )),
      AsyncError(:final error) =>
        Center(child: Text("Couldn't fetch data! $error")),
      _ => const Center(
          child: CircularProgressIndicator(),
        )
    };
  }
}
