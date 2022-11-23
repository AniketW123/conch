import 'package:flutter/material.dart';

class RoundedTextBox extends StatelessWidget {
  final EdgeInsetsGeometry? padding;

  final String? label;

  final Color? borderColor;
  final String? hintText;

  final bool? obscureText;
  final Widget? textVisibilityIcon;
  final VoidCallback? revealText;

  final void Function(String)? onChanged;

  RoundedTextBox({this.padding, this.label, this.borderColor, this.hintText, this.obscureText, this.textVisibilityIcon, this.revealText, this.onChanged});

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
          TextFormField(
            obscureText: obscureText ?? false,
            onChanged: onChanged,
            style: const TextStyle(
              fontSize: 20,
            ),
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: borderColor ?? Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: borderColor ?? Colors.grey),
              ),
              suffixIcon: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: (obscureText != null) ? IconButton(
                  icon: textVisibilityIcon ?? Icon(Icons.visibility),
                  onPressed: revealText,
                ) : const SizedBox(),
              ),
              hintText: hintText,
            ),
          ),
        ],
      ),
    );
  }
}
