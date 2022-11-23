import 'package:flutter/material.dart';

void snackbar ({required BuildContext context, required String message}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message)
    )
  );
}