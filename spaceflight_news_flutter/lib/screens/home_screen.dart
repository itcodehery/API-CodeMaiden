import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:spaceflight_news_flutter/models/article.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Article> articles = [];

  @override
  void initState() {
    super.initState();
    fetch();
  }

  Future fetch() async {
    try {
      final response = await http
          .get(Uri.https('api.spaceflightnewsapi.net', '/v4/articles/'));
      final jsonDecoded = jsonDecode(response.body);
      for (var article in jsonDecoded['results']) {
        final arti = Article.fromJson(article);
        setState(() {
          articles.add(arti);
        });
      }
    } catch (e) {
      // Handle error, maybe log it or update the state to reflect the error state
      debugPrint("Error fetching articles: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 4))
        .then((c) => print(articles.length));

    return Scaffold(
        appBar: AppBar(
          title: const Text("SpaceFlight News"),
        ),
        // body: FutureBuilder(
        //     future: fetch(),
        //     builder: (c, s) {
        //       if (s.connectionState == ConnectionState.done) {
        //         return ListView.builder(
        //             itemCount: articles.length,
        //             itemBuilder: (c, i) {
        //               return Card(
        //                 margin: const EdgeInsets.symmetric(
        //                     vertical: 4, horizontal: 8),
        //                 child: ListTile(
        //                   title: Text(articles.elementAt(i).title),
        //                   subtitle: Text(articles.elementAt(i).summary),
        //                 ),
        //               );
        //             });
        //       } else {
        //         return const Center(
        //           child: CircularProgressIndicator(),
        //         );
        //       }
        //     }));
        body: articles.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: articles.length,
                itemBuilder: (c, i) {
                  return Card(
                    margin:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    child: ListTile(
                      title: Text(articles.elementAt(i).title),
                      subtitle:
                          Text(articles.elementAt(i).publishedAt.toString()),
                    ),
                  );
                }));
  }
}
