import 'package:farozamartapp/cart_page.dart';
import 'package:farozamartapp/core/functions.dart';
import 'package:farozamartapp/profile_page.dart';
import 'package:flutter/material.dart';

class BasePage extends StatelessWidget {
  final String title;
  final Widget body;
  const BasePage({super.key, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.surface,
          title: Text('Farozamart | $title'),
          actions: [
            IconButton(
                onPressed: () {
                  goTo(context: context, page: const CartPage());
                },
                icon: const Icon(Icons.shopping_cart)),
            IconButton(
                onPressed: () {
                  goTo(context: context, page: const ProfilePage());
                },
                icon: const Icon(Icons.person)),
          ],
        ),
        body: body);
  }
}
