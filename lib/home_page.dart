import 'package:flutter/material.dart';
import 'package:farozamartapp/base_page.dart';

class Home extends StatelessWidget {
  static String routeName = '/';
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var layout = _layoutBig(screenSize, context);
    if (screenSize.width < 800) {
      layout = _layoutSmall(screenSize, context);
    }
    return BasePage(
      body: ListView(
        children: [layout],
      ),
    );
  }
}

Widget _layoutBig(Size size, BuildContext context) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: size.width / 5),
    child: Column(children: products(size, context)),
  );
}

Widget _layoutSmall(Size screenSize, BuildContext context) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16),
    child: Column(children: products(screenSize, context)),
  );
}

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

List<Widget> products(Size screenSize, BuildContext context) {
  return List.generate(
      100,
      (index) => Card(
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
                  children: [Text('Product $index'), Text('Category $index')],
                )),
                Row(
                  children: [
                    _buildButtonColumn(Theme.of(context).colorScheme.primary,
                        Icons.add_shopping_cart, 'Add to cart')
                  ],
                )
              ],
            ),
          ));
}
