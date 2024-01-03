import 'package:farozamartapp/core/functions.dart';
import 'package:farozamartapp/core/models/user.dart';
import 'package:farozamartapp/core/resolve_future.dart';
import 'package:farozamartapp/login_page.dart';
import 'package:farozamartapp/widgets/display_regular_snackbar.dart';
import 'package:flutter/material.dart';

class RegistrationForm extends StatefulWidget {
  final void Function(UserObject luser)? setUser;
  const RegistrationForm({super.key, this.setUser});

  @override
  State<StatefulWidget> createState() {
    return _RegistrationFormState();
  }
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  var usernameController = TextEditingController(text: '');
  var emailController = TextEditingController(text: '');
  var phoneController = TextEditingController(text: '');
  var firstNameController = TextEditingController(text: '');
  var lastNameController = TextEditingController(text: '');
  var gender = 'Male';
  var genderOptions = ['Male', 'Female'];
  var addressController = TextEditingController(text: '');
  var passwordController = TextEditingController(text: '');
  var repeatPasswordController = TextEditingController(text: '');

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
                decoration: const InputDecoration(label: Text('E-mail')),
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
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
                decoration: const InputDecoration(label: Text('Phone')),
                keyboardType: TextInputType.phone,
                controller: phoneController,
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
                decoration: const InputDecoration(label: Text('First Name')),
                keyboardType: TextInputType.name,
                controller: firstNameController,
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
                decoration: const InputDecoration(label: Text('Last Name')),
                keyboardType: TextInputType.name,
                controller: lastNameController,
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
            child: Column(
              children: [
                const Text('Gender'),
                DropdownButton(
                    value: gender,
                    items: genderOptions
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        gender = value!;
                      });
                    }),
              ],
            ),
          ),
          Container(
              padding: const EdgeInsets.all(8),
              child: TextFormField(
                decoration: const InputDecoration(label: Text('Address')),
                keyboardType: TextInputType.streetAddress,
                controller: addressController,
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
            child: TextFormField(
              obscureText: true,
              decoration: const InputDecoration(label: Text('Repeat Password')),
              controller: repeatPasswordController,
            ),
          ),
          Container(
              padding: const EdgeInsets.all(8),
              child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _signup();
                    }
                  },
                  child: const Text('Register'))),
        ],
      ),
    );
  }

  void _signup() {
    var request = User();
    var requestFuture = request.register(
      username: usernameController.text,
      email: emailController.text,
      phone: phoneController.text,
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      gender: gender,
      address: addressController.text,
      password: passwordController.text,
      repeatPassword: repeatPasswordController.text,
    );
    resolveFuture(context, requestFuture, (value) {
      if (value == true) {
        displayRegularSnackBar(context, 'User registration successfull!');
        goTo(context: context, page: const LoginPage(), permanent: true);
      } else {
        displayRegularSnackBar(context, request.responseError.toString());
      }
    });
  }
}
