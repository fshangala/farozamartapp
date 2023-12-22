import 'package:farozamartapp/core/api.dart';

class SaleObject {
  int id;
  String username;
  String name;
  String getSalePrice;
  String picture;

  SaleObject({
    required this.id,
    required this.username,
    required this.name,
    required this.getSalePrice,
    required this.picture,
  });
}

class Sale extends FarozamartApi<SaleObject> {
  @override
  SaleObject mapToObject(Map<String, dynamic> data) {
    return SaleObject(
      id: data['id'],
      username: data['user']['username'],
      name: data['purchase']['inventory']['name'],
      getSalePrice: data['get_sale_price'],
      picture: data['purchase']['inventory']['picture'],
    );
  }
}
