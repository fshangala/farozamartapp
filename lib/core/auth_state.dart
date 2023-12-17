import 'package:farozamartapp/core/functions.dart';
import 'package:flutter/material.dart';
import 'package:farozamartapp/core/models/user.dart';
import 'package:farozamartapp/login_page.dart';

abstract class AuthState<T extends StatefulWidget> extends State<T> {
  late Future<User?> user;

  void afterInit() {}

  @override
  initState() {
    super.initState();
    user = User().loggedInUser();
    user.then((value) {
      if (value == null) {
        goTo(context: context, page: const LoginPage());
      }
    });
    afterInit();
  }
}
