import 'package:flutter/material.dart';

class RoundedTextBox extends StatelessWidget {
  final String? label;

  final String? hintText;
  final bool? obscureText;
  final Color? borderColor;

  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;

  final EdgeInsetsGeometry? padding;

  RoundedTextBox({this.padding, this.label, this.borderColor, this.hintText, this.obscureText, this.onChanged, this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          label != null ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(label ?? "", style: const TextStyle(fontWeight: FontWeight.bold),),
          ) : const SizedBox(),
          TextField(
            obscureText: obscureText ?? false,
            onChanged: onChanged,
            style: const TextStyle(
              fontSize: 20,
            ),
            onSubmitted:(String value) => onSubmitted,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: borderColor ?? Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: borderColor ?? Colors.grey),
              ),
              hintText: hintText,
            ),
          ),
        ],
      ),
    );
  }
}
