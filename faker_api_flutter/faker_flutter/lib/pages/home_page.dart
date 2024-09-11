import 'package:faker_flutter/pages/detail_page.dart';
import 'package:faker_flutter/providers/book_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final books = ref.watch(fetchBooksProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Faker Flutter'),
      ),
      body: books.when(
        data: (books) => ListView.builder(
          itemCount: books.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(books[index].title),
              subtitle: Text(books[index].author),
              onTap: () {
                // Navigate to the detail page
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return DetailPage(book: books[index]);
                }));
              },
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
