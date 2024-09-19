import 'package:flutter/material.dart';
import 'package:security_api_flutter/components/cards.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('My Profile', style: TextStyle(fontSize: 16)),
          ),
          TextButton(
            onPressed: () {},
            child: const Text("Quit"),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Cards().buildActionCard(
              "ABC of Account Security",
              "Interactive Article",
              "You will learn how to be better prepared for the next big step in your personal security.",
              () {}),
          Cards().buildActionCard(
              "Secure Your Email",
              "Interactive Article",
              "Learn how to secure your email and keep your personal information safe.",
              () {}),
        ],
      ),
      bottomNavigationBar: const BottomAppBar(
        child: Center(
          child: ListTile(
            title: Text('Hello, Hari!'),
            subtitle: Text("Your email is secure. Last scan 5 mins ago."),
            trailing: Icon(
              Icons.check,
              color: Colors.greenAccent,
            ),
          ),
        ),
      ),
    );
  }
}
