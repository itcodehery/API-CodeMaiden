import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spaceflight_news_flutter/providers/articles_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final articlesNotifier = ref.watch(articlesNotifierProvider.notifier);
    final articles = ref.watch(articlesNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("SpaceFlight News"),
        actions: [
          IconButton(
            onPressed: () async {
              await articlesNotifier
                  .request(); // Trigger article fetch on button press
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: articles.isNotEmpty
          ? ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final article = articles.elementAt(index);
                return ListTile(
                  title: Text(article.title),
                  subtitle: Text(article.summary),
                );
              },
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
