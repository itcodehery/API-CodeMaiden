import 'package:flutter/material.dart';

class Cards {
  Widget buildActionCard(String title, String subtitle, String bodyText,
      void Function() onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Card(
        color: const Color.fromARGB(255, 255, 182, 146),
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 32)),
              Text(subtitle, style: const TextStyle(fontSize: 16)),
              const Divider(
                color: Colors.black26,
              ),
              Text(bodyText, style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 16),
              TextButton(
                onPressed: onPressed,
                child: const Text('Read More'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
