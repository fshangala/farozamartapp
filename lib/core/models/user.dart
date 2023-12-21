import 'package:farozamartapp/core/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserObject {
  int id;
  String username;
  String firstName;
  String lastName;
  UserObject(
      {required this.id,
      required this.username,
      required this.firstName,
      required this.lastName});
}

class User extends FarozamartApi<UserObject> {
  @override
  UserObject mapToObject(Map<String, dynamic> data) {
    return UserObject(
        id: data['id'],
        username: data['username'],
        firstName: data['first_name'],
        lastName: data['last_name']);
  }

  Future<UserObject?> getTokenUser() async {
    var token = await getToken();
    var data = await get(
      endpoint: '/api/v1/accounts/token-user/',
      token: token.toString(),
    );
    if (data == null) {
      return null;
    }
    return mapToObject(data as Map<String, dynamic>);
  }

  Future<UserObject?> login(String username, String password) async {
    var data = await post(
      endpoint: '/api/auth/login/',
      data: {'username': username, 'password': password},
    ) as Map<String, dynamic>;
    if (data['token'] != null) {
      saveToken(token: data['token']);
      return await getTokenUser();
    } else {
      return null;
    }
  }

  Future<bool> logout() async {
    var instance = await SharedPreferences.getInstance();
    return await instance.remove('token');
  }
}
