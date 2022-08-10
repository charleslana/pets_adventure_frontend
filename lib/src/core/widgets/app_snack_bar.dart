import 'package:flutter/material.dart';

enum SnackBarEnum {
  success,
  error,
}

void showSnackBar(
    BuildContext context, String message, SnackBarEnum snackBarEnum) {
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  final snackBar = SnackBar(
    duration: const Duration(seconds: 3),
    content: Text(message),
    backgroundColor:
        snackBarEnum == SnackBarEnum.error ? Colors.red : Colors.green,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
