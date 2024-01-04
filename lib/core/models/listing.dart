import 'package:farozamartapp/core/api.dart';
import 'package:farozamartapp/core/models/sales.dart';

class ListingObject {
  int id;
  String name;
  String description;
  String price;
  String currency;
  String picture;

  ListingObject(
      {required this.id,
      required this.name,
      required this.description,
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
      description: data['inventory']['description'],
      price: data['get_sale_price'],
      currency: data['currency']['code'],
      picture: data['inventory']['picture'],
    );
  }

  Future<List<ListingObject>> listing() async {
    var response = await get(endpoint: '/api/v1/store/listing/');
    if (response == null) {
      return [];
    } else {
      List<Map<String, dynamic>> data =
          (response as List).map((e) => e as Map<String, dynamic>).toList();
      return data.map((e) => mapToObject(e)).toList();
    }
  }

  Future<ListingObject?> singleListing(int id) async {
    var response = await get(endpoint: '/api/v1/store/listing/$id/');
    if (response == null) {
      return null;
    } else {
      ListingObject data = mapToObject(response as Map<String, dynamic>);
      return data;
    }
  }

  Future<List<SaleObject>> addToCart(
      int listingId, Map<String, dynamic> data) async {
    var token = await getToken();
    var response = await post(
        endpoint: '/api/v1/store/listing/$listingId/add_to_cart/',
        data: data,
        token: token);
    if (response == null) {
      return [];
    } else {
      List<Map<String, dynamic>> data =
          (response as List).map((e) => e as Map<String, dynamic>).toList();
      return data.map((e) => Sale().mapToObject(e)).toList();
    }
  }
}
