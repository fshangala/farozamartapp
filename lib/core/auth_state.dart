import 'package:farozamartapp/core/functions.dart';
import 'package:farozamartapp/widgets/display_regular_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:farozamartapp/core/models/user.dart';
import 'package:farozamartapp/login_page.dart';

abstract class AuthState<T extends StatefulWidget> extends State<T> {
  late Future<UserObject?> userFuture;

  void afterInit() {}

  @override
  initState() {
    super.initState();
    var request = User();
    userFuture = request.getTokenUser();
    userFuture.then((value) {
      if (value == null) {
        displayRegularSnackBar(context, request.responseError.toString());
        goTo(context: context, page: const LoginPage());
      }
    });
    afterInit();
  }
}
