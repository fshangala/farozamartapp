import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

abstract class FarozamartApi<OBJ> {
  //String baseUrl = 'http://localhost:8000';
  String baseUrl = 'https://farozamart.com';
  dynamic responseError;

  OBJ mapToObject(Map<String, dynamic> data);

  Future<String?> getToken() async {
    var instance = await SharedPreferences.getInstance();
    var token = instance.getString('token');
    return token;
  }

  Future<bool> saveToken({required String token}) async {
    var instance = await SharedPreferences.getInstance();
    return instance.setString('token', token);
  }

  dynamic handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    responseError = response.body;
    return null;
  }

  Future<dynamic> get({required String endpoint, String? token}) async {
    late http.Response response;
    try {
      if (token == null) {
        response = await http.get(Uri.parse('$baseUrl$endpoint'));
      } else {
        response = await http.get(Uri.parse('$baseUrl$endpoint'), headers: {
          HttpHeaders.authorizationHeader: 'Token $token',
          HttpHeaders.contentTypeHeader: 'application/json',
        });
      }
    } catch (e) {
      responseError = e.toString();
      return null;
    }
    return handleResponse(response);
  }

  Future<dynamic> post(
      {required String endpoint,
      required Map<String, dynamic> data,
      String? token}) async {
    late http.Response response;
    try {
      if (token == null) {
        response = await http.post(Uri.parse('$baseUrl$endpoint'), body: data);
      } else {
        response = await http.post(Uri.parse('$baseUrl$endpoint'),
            headers: {'Authorization': 'Token $token'}, body: data);
      }
    } catch (e) {
      return null;
    }
    return handleResponse(response);
  }
}
