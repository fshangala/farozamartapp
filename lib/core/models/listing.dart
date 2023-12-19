import 'package:farozamartapp/core/api.dart';

class ListingObject {
  int id;
  String name;
  String price;
  String currency;
  String picture;

  ListingObject(
      {required this.id,
      required this.name,
      required this.price,
      required this.currency,
      required this.picture});
}

class Listing extends FarozamartApi<ListingObject> {
  @override
  ListingObject mapToObject(Map<String, dynamic> data) {
    return ListingObject(
      id: data['id'],
      name: data['inventory']['name'],
      price: data['get_sale_price'],
      currency: data['currency']['code'],
      picture: data['inventory']['picture'],
    );
  }

  Future<List<ListingObject>> listing() async {
    var token = await getToken();
    var response = await get(endpoint: '/api/v1/store/listing/', token: token);
    if (response == null) {
      return [];
    } else {
      List<Map<String, dynamic>> data =
          (response as List).map((e) => e as Map<String, dynamic>).toList();
      return data.map((e) => mapToObject(e)).toList();
    }
  }
}
