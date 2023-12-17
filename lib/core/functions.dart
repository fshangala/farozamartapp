import 'package:flutter/material.dart';

void goTo(
    {required BuildContext context,
    required Widget page,
    bool permanent = false}) {
  if (permanent) {
    Navigator.pop(context);
  }
  Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => page, maintainState: false));
}
