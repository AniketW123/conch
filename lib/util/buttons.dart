import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  RoundedButton({required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 100),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 20
            ),
          ),
      ),
    );
  }
}

class GoogleButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  GoogleButton({required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:70, horizontal: 20),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            text,
          ),
        ),
      ),
    );
  }
}

