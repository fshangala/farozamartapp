import 'package:farozamartapp/widgets/not_null_future_renderer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Widget getImageFromNetwork(String src) {
  var response = http.head(Uri.parse(src));
  return NotNullFutureRenderer(
    future: response,
    futureRenderer: (responseObject) {
      if (responseObject.statusCode == 200) {
        return Image.network(
          src,
          fit: BoxFit.fill,
        );
      }
      return Image.asset(
        "images/default.png",
        fit: BoxFit.fill,
      );
    },
  );
}
