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

String _getNormalDate(DateTime date) {
  return "${date.day}/${date.month}/${date.year}";
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
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog.fullscreen(
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Stack(children: [
                                  SizedBox(
                                      height: 400,
                                      width: double.infinity,
                                      child: Image.network(
                                        value.elementAt(index).imgUrl,
                                        fit: BoxFit.cover,
                                      )),
                                  Positioned(
                                    child: IconButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      icon: const Icon(Icons.close),
                                    ),
                                  )
                                ]),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        value.elementAt(index).title,
                                        style: const TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                          "${_getNormalDate(value.elementAt(index).publishedAt)} | ${value.elementAt(index).newsSite} ${value.elementAt(index).isFeatured ? "| Featured" : ""}"),
                                      const Divider(),
                                      Text(value.elementAt(index).summary),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
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
