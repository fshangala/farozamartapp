import 'package:farozamartapp/core/api.dart';

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

  Future<ListingObject?> singleListing(int id) async {
    var token = await getToken();
    var response =
        await get(endpoint: '/api/v1/store/listing/$id/', token: token);
    if (response == null) {
      return null;
    } else {
      ListingObject data = mapToObject(response as Map<String, dynamic>);
      return data;
    }
  }
}
