import 'package:farozamartapp/core/functions.dart';
import 'package:farozamartapp/widgets/display_regular_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:farozamartapp/core/models/user.dart';
import 'package:farozamartapp/login_page.dart';

abstract class AuthState<T extends StatefulWidget> extends State<T> {
  User userApi = User();
  late Future<UserObject?> userFuture;

  void afterInit() {}

  @override
  initState() {
    super.initState();
    getUser();
    userFuture.then((value) {
      if (value == null) {
        displayRegularSnackBar(context, userApi.responseError.toString());
        goTo(context: context, page: const LoginPage());
      }
    });
    afterInit();
  }

  getUser() {
    userFuture = userApi.getTokenUser();
  }
}
