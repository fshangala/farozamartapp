import 'package:farozamartapp/core/models/listing.dart';
import 'package:flutter/material.dart';

class AddToCartForm extends StatefulWidget {
  final ListingObject product;
  const AddToCartForm({super.key, required this.product});

  @override
  State<StatefulWidget> createState() {
    return _AddToCartFormState();
  }
}

class _AddToCartFormState extends State<AddToCartForm> {
  final _formKey = GlobalKey<FormState>();
  var quantityController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Container(
              padding: const EdgeInsets.all(8),
              child: TextFormField(
                decoration: const InputDecoration(label: Text('Quanatity')),
                keyboardType: TextInputType.number,
                controller: quantityController,
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
              child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _addToCart();
                    }
                  },
                  child: const Text('Add To Cart'))),
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

  void _addToCart() {}
}
