import 'package:farozamartapp/base_page.dart';
import 'package:farozamartapp/core/functions.dart';
import 'package:farozamartapp/signup_page.dart';
import 'package:farozamartapp/widgets/login_form.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  static String routeName = '/';
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Login',
      body: ListView(
        children: [_layout(context)],
      ),
    );
  }

  Widget _layout(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    if (screenSize.width < 800) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(children: [_loginWidget(context)]),
      );
    } else {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: screenSize.width / 5),
        child: Column(children: [_loginWidget(context)]),
      );
    }
  }

  Widget _loginWidget(BuildContext context) {
    return Column(
      children: [
        LoginForm(
          setUser: (luser) {
            Navigator.of(context).pop();
          },
        ),
        const Divider(),
        Container(
          margin: const EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: () {
              goTo(context: context, page: const SignupPage(), permanent: true);
            },
            child: const Text('Create an account'),
          ),
        ),
      ],
    );
  }
}
