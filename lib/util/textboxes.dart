import 'package:flutter/material.dart';

class RoundedTextBox extends StatelessWidget {
  final String? hintText;
  final bool? obscureText;

  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;

  RoundedTextBox({this.hintText, this.obscureText, this.onChanged, this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
        obscureText: obscureText ?? false,
        onChanged: onChanged,
        onSubmitted:(String value) => onSubmitted,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25)
          ),
          hintText: hintText,
        ),
      )
    );
  }
}
