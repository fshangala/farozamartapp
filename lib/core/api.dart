import 'dart:convert';
import 'package:farozamartapp/core/models/listing.dart';
import 'package:http/http.dart' as http;

class FarozamartApi {
  String baseUrl = 'http://localhost:8000';
  Future<List<Listing>> listing() async {
    var response = await http.get(Uri.parse('$baseUrl/api/v1/store/listing/'));
    List<Map<String, dynamic>> data = (jsonDecode(response.body) as List)
        .map((e) => e as Map<String, dynamic>)
        .toList();
    return data
        .map((e) => Listing(
            id: e['id'],
            name: e['inventory']['name'],
            price: e['get_sale_price'],
            currency: e['currency']['code'],
            picture: e['inventory']['picture']))
        .toList();
  }
}
