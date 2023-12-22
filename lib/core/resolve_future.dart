import 'package:farozamartapp/core/show_loading.dart';
import 'package:farozamartapp/widgets/display_regular_snackbar.dart';
import 'package:flutter/material.dart';

void resolveFuture<T>(
    BuildContext context, Future<T> future, void Function(T value) callback) {
  showLoading(context);
  future.then((value) {
    Navigator.pop(context);
    if (value == null) {
      displayRegularSnackBar(context, 'Failed!');
    } else {
      callback(value);
    }
  }).onError((error, stackTrace) {
    Navigator.pop(context);
    displayRegularSnackBar(context, 'Error: $error');
  });
}
