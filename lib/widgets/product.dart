import 'package:flutter/material.dart';

Widget titleSection = Container(
  padding: const EdgeInsets.all(32),
  child: Row(
    children: [
      Expanded(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 8),
            child: const Text(
              'hello world',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            'And hello world',
            style: TextStyle(color: Colors.grey[500]),
          )
        ],
      )),
      Icon(
        Icons.star,
        color: Colors.red[500],
      ),
      const Text('41'),
    ],
  ),
);

Widget _buildButtonColumn(Color color, IconData icon, String label) {
  return TextButton(
      onPressed: () {},
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon),
            Container(
              margin: const EdgeInsets.only(top: 8),
              child: Text(
                label,
                style: TextStyle(
                    fontSize: 12, fontWeight: FontWeight.w400, color: color),
              ),
            )
          ],
        ),
      ));
}

Widget buttonSection = Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    _buildButtonColumn(Colors.red[500]!, Icons.money, 'Buy now'),
    _buildButtonColumn(
        Colors.red[500]!, Icons.add_shopping_cart, 'Add to cart'),
  ],
);

Widget Product() {
  return Column(
    children: [
      Column(
        children: [Image.asset('images/default.png')],
      ),
      titleSection,
      buttonSection
    ],
  );
}
