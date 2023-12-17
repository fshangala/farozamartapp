import 'package:farozamartapp/base_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  static String routeName = '/';
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Login',
      body: ListView(
        children: [layout(context)],
      ),
    );
  }
}

Widget layout(BuildContext context) {
  if (MediaQuery.of(context).size.width < 800) {
    return Column();
  } else {
    return Column();
  }
}
