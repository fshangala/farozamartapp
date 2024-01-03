import 'package:farozamartapp/core/models/user.dart';
import 'package:farozamartapp/core/resolve_future.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;

class LoginForm extends StatefulWidget {
  final void Function(UserObject luser)? setUser;
  const LoginForm({super.key, this.setUser});

  @override
  State<StatefulWidget> createState() {
    return _LoginFormState();
  }
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  var usernameController = TextEditingController(text: '');
  var passwordController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Container(
              padding: const EdgeInsets.all(8),
              child: TextFormField(
                decoration: const InputDecoration(label: Text('Username')),
                keyboardType: TextInputType.name,
                controller: usernameController,
                validator: (value) {
                  if (value == '') {
                    return 'Please enter some value';
                  } else {
                    return null;
                  }
                },
              )),
          Container(
            padding: const EdgeInsets.all(8),
            child: TextFormField(
              obscureText: true,
              decoration: const InputDecoration(label: Text('Password')),
              controller: passwordController,
            ),
          ),
          Container(
              padding: const EdgeInsets.all(8),
              child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _login(usernameController.text, passwordController.text);
                    }
                  },
                  child: const Text('Login'))),
          /*Container(
              padding: const EdgeInsets.all(8),
              child: TextButton(
                  onPressed: () {
                    goTo(
                        context: context,
                        routeName: RegisterScreen.routeName,
                        permanent: widget.permanetGoTo);
                  },
                  child: const Text('Create Account'))),*/
        ],
      ),
    );
  }

  void _login(String username, String password) {
    var request = User();
    resolveFuture(context, request.login(username, password), (value) {
      if (value == null) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(request.responseError.toString())));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Welcome ${value.username}')));
        if (widget.setUser != null) {
          widget.setUser!(value);
        }
      }
    });
  }
}
