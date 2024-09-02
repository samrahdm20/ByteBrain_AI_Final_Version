import 'package:flutter/material.dart';

void showSnackBarMessage(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(content),
    // backgroundColor: const Color.fromARGB(255, 0, 166, 126),
    backgroundColor: Colors.red,
  ));
}
