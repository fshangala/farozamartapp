import 'dart:developer';

import 'package:farozamartapp/core/api.dart';
import 'package:farozamartapp/core/models/sales.dart';
import 'package:farozamartapp/core/models/user.dart';

class CartObject {
  int id;
  bool draft;
  UserObject user;
  String? transaction;
  List<SaleObject> sales;
  String totalCost;

  CartObject({
    required this.id,
    required this.draft,
    required this.user,
    required this.transaction,
    required this.sales,
    required this.totalCost,
  });
}

class Cart extends FarozamartApi<CartObject> {
  @override
  CartObject mapToObject(Map<String, dynamic> data) {
    return CartObject(
      id: data['id'],
      draft: data['draft'],
      user: User().mapToObject(data['user']),
      transaction: data['transaction'],
      sales: (data['sales'] as List)
          .map((e) => Sale().mapToObject(e as Map<String, dynamic>))
          .toList(),
      totalCost: data['total_cost'],
    );
  }

  Future<CartObject?> getCart() async {
    var token = await getToken();
    var response =
        await get(endpoint: '/api/v1/store/cart/get_cart/', token: token);
    if (response == null) {
      return null;
    } else {
      Map<String, dynamic> data = response as Map<String, dynamic>;
      log(data.toString());
      return mapToObject(data);
    }
  }

  Future<CartObject?> cODPayment(int orderId) async {
    var token = await getToken();
    var response = await get(
        endpoint: '/api/v1/store/cart/$orderId/get_cart/', token: token);
    if (response == null) {
      return null;
    } else {
      Map<String, dynamic> data = response as Map<String, dynamic>;
      return mapToObject(data);
    }
  }
}
