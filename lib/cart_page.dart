import 'package:farozamartapp/base_page.dart';
import 'package:farozamartapp/core/auth_state.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});
  static String routeName = '/cart/';

  @override
  State<StatefulWidget> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return BasePage(title: 'Cart', body: layout(context));
  }
}

Widget layout(BuildContext context) {
  var screenSize = MediaQuery.of(context).size;
  Widget largeScreens = ListView(
    children: [
      Card(
        child: Row(
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                  maxHeight: screenSize.height / 4,
                  maxWidth: screenSize.width / 4),
              child: Image.asset(
                'images/default.png',
                fit: BoxFit.fill,
              ),
            ),
            Expanded(
                child: Column(
              children: [Text('Username'), Text('Full name')],
            ))
          ],
        ),
      ),
      Card(
        child: Column(children: [Text('Cart'), cartItems()]),
      ),
      Card(
        child: Column(children: [Text('Cart Summery'), cartItems()]),
      )
    ],
  );
  if (screenSize.width < 800) {
    return largeScreens;
  } else {
    return largeScreens;
  }
}

Widget cartItems() {
  return Column(
    children: [
      Row(children: [Text('Product'), Text('Quantity')])
    ],
  );
}
