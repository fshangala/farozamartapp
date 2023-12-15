import 'package:flutter/material.dart';

class BasePage extends StatelessWidget {
  final Widget body;
  const BasePage({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.surface,
          title: const Text('Farozamart'),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.shopping_cart)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.person)),
          ],
        ),
        body: body);
  }
}
