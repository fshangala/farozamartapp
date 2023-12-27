import 'package:farozamartapp/base_page.dart';
import 'package:farozamartapp/core/auth_state.dart';
import 'package:farozamartapp/core/models/cart.dart';
import 'package:farozamartapp/widgets/null_future_renderer.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});
  static String routeName = '/cart/';

  @override
  State<StatefulWidget> createState() => _CartPageState();
}

class _CartPageState extends AuthState<CartPage> {
  var cartApi = Cart();
  Future<CartObject?> cartFuture = Future.value(null);

  @override
  void afterInit() {
    cartFuture = cartApi.getCart();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Cart',
      body: RefreshIndicator(
        onRefresh: () async {
          getUser();
          cartFuture = cartApi.getCart();
        },
        child: ListView(
          children: [layout()],
        ),
      ),
    );
  }

  Widget layout() {
    var screenSize = MediaQuery.of(context).size;
    Widget largeScreens = NullFutureRenderer(
      future: cartFuture,
      futureRenderer: (cartObject) {
        return Column(
          children: [
            Card(
              child: Column(
                children: [const Text('Cart'), cartItems(cartObject)],
              ),
            ),
            Card(
              child: Column(
                children: [const Text('Cart Summery'), cartSummery(cartObject)],
              ),
            )
          ],
        );
      },
    );
    if (screenSize.width < 800) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: largeScreens,
      );
    } else {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: screenSize.width / 5),
        child: largeScreens,
      );
    }
  }

  Widget cartItems(CartObject cart) {
    return DataTable(
      columns: const [
        DataColumn(label: Text('ID')),
        DataColumn(label: Text('Name')),
        DataColumn(label: Text('Quantity')),
        DataColumn(label: Text('Unit Price')),
      ],
      rows: cart.sales
          .map((e) => DataRow(
                cells: [
                  DataCell(Text(e.id.toString())),
                  DataCell(Text(e.name)),
                  DataCell(Text('...')),
                  DataCell(Text(e.getSalePrice)),
                ],
              ))
          .toList(),
    );
  }

  Widget cartSummery(CartObject cart) {
    return DataTable(
      columns: const [
        DataColumn(label: Text('...')),
        DataColumn(label: Text('...')),
      ],
      rows: [
        DataRow(
          cells: [
            const DataCell(Text('Total')),
            DataCell(Text(cart.totalCost)),
          ],
        ),
      ],
    );
  }
}
