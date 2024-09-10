import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:translator_libre_flutter/models/lang_resp_model.dart';
import 'package:translator_libre_flutter/providers/language_provider.dart';
import 'package:translator_libre_flutter/providers/translate_provider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  LRM? languageList;
  int _selectedTextIndex = 0;
  int _selectedResultIndex = 0;
  final TextEditingController _inputController = TextEditingController();
  String? translatedText;

  @override
  Widget build(BuildContext context) {
    final ll = ref.watch(fetchLanguagesProvider);
    final tsl = ref.watch(translateProvider);
    ll.when(
      data: (data) {
        languageList = data;
      },
      loading: () => const CircularProgressIndicator(),
      error: (error, stack) => Text("Error: $error"),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text("LibreTranslate"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Language Dropdown

              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 200,
                child: Column(
                  children: [
                    DropdownButton<String>(
                      isExpanded: true,
                      hint: const Text("Select Language"),
                      value: languageList?.targets[_selectedTextIndex],
                      items: languageList?.targets
                              .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e),
                                  ))
                              .toList() ??
                          [],
                      onChanged: (value) {
                        debugPrint(value!);
                        setState(() {
                          _selectedTextIndex =
                              languageList!.targets.indexOf(value);
                        });
                      },
                    ),
                    TextField(
                      controller: _inputController,
                      decoration: const InputDecoration(
                        hintText: "Text to Translate",
                        border: InputBorder.none,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 200,
                child: Column(
                  children: [
                    DropdownButton<String>(
                      isExpanded: true,
                      hint: const Text("Select Language"),
                      value: languageList?.targets[_selectedResultIndex],
                      items: languageList?.targets
                              .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e),
                                  ))
                              .toList() ??
                          [],
                      onChanged: (value) {
                        debugPrint(value!);
                        setState(() {
                          _selectedResultIndex =
                              languageList!.targets.indexOf(value);
                        });
                      },
                    ),
                    ListTile(
                      title: SelectableText(
                          translatedText ?? "Translated Text will appear here",
                          style: const TextStyle(fontSize: 20)),
                    ),
                  ],
                ),
              ),
              ListTile(
                title: TextButton(
                    onPressed: () {
                      tsl
                          .translate(
                              _inputController.text,
                              languageList!.targets[_selectedTextIndex],
                              languageList!.targets[_selectedResultIndex])
                          .then((value) {
                        setState(() {
                          translatedText = jsonDecode(value)['translatedText'];
                        });
                      });
                    },
                    child: const Text("Translate")),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('History', style: TextStyle(fontSize: 20)),
              ),
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return const ListTile(
                      title: Text("Language"),
                      subtitle: Text("Language Name"),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
