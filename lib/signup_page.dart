import 'package:farozamartapp/base_page.dart';
import 'package:farozamartapp/core/functions.dart';
import 'package:farozamartapp/login_page.dart';
import 'package:farozamartapp/widgets/registration_form.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatelessWidget {
  static String routeName = '/signup';
  const SignupPage({super.key});

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
        child: Column(children: [_signupWidget(context)]),
      );
    } else {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: screenSize.width / 5),
        child: Column(children: [_signupWidget(context)]),
      );
    }
  }

  Widget _signupWidget(BuildContext context) {
    return Column(
      children: [
        RegistrationForm(
          setUser: (luser) {
            Navigator.of(context).pop();
          },
        ),
        const Divider(),
        Container(
          margin: const EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: () {
              goTo(context: context, page: const LoginPage(), permanent: true);
            },
            child: const Text('Login'),
          ),
        ),
      ],
    );
  }
}
