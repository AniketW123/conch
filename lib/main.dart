import 'package:conch/pages/sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/home.dart';
import 'pages/sign_in.dart';

void main() async {
  await Firebase.initializeApp();
  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {

  bool logged_in = false;

  void logged_in_checker() async {
    final prefs = await SharedPreferences.getInstance();
    final bool? l = prefs.getBool("logged_in");
    logged_in = l ?? false;
  }

  @override
  void initState() {
    super.initState();
    logged_in_checker();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // fontFamily: GoogleFonts.mPlusRounded1c().fontFamily
      ),
      home: logged_in ? Home() : SignInPage()
    );
  }
}