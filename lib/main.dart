import 'package:flutter/material.dart';
import 'screens/home.dart';

void main() {
  runApp(const Conch());
}

class Conch extends StatelessWidget {
  const Conch({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}
