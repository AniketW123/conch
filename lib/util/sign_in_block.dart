import 'package:conch/util/textboxes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:google_fonts/google_fonts.dart';
import 'buttons.dart';

class SignInBlock extends StatelessWidget {
  final String heading;

  SignInBlock({required this.heading});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              heading,
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          RoundedTextBox(
            hintText: "Email address",
          ),
          RoundedTextBox(
            hintText: "Password (8+ characters)",
            obscureText: true,
          ),
          RoundedButton(
            text: "Sign in",
            onPressed: () {

            },
          ),
          Expanded(
            child: GoogleButton(
                text: "$heading with Google",
                onPressed: () {

                },
            ),
          ),
        ],
      ),
    );
  }
}

