import 'package:farozamartapp/core/models/listing.dart';
import 'package:farozamartapp/core/resolve_future.dart';
import 'package:farozamartapp/widgets/display_regular_snackbar.dart';
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
                decoration: const InputDecoration(
                  label: Text('Quanatity'),
                  constraints: BoxConstraints.tightFor(width: 200),
                ),
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

  void _addToCart() {
    var listing = Listing();
    resolveFuture(
      context,
      listing.addToCart(
        widget.product.id,
        {"quantity": quantityController.text},
      ),
      (value) {
        if (value.isEmpty) {
          displayRegularSnackBar(context, listing.responseError.toString());
        } else {
          displayRegularSnackBar(context, 'Product added to cart');
        }
      },
    );
  }
}
