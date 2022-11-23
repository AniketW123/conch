import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pages/home.dart';
import 'pages/sign_in.dart';

void main() async {
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.blue,
      // fontFamily: GoogleFonts.mPlusRounded1c().fontFamily
    ),
    home: App(),
  ));
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? currentUser;

  void silentLogIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    currentUser = _auth.currentUser;
    if (prefs.getBool("remember_me") ?? true && currentUser != null) {
      print("true");
      if (!mounted) return;
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(user: currentUser!)));
    } else if (currentUser != null) {
      await _auth.signOut();
    }
    if (!mounted) return;
    Navigator.push(context, MaterialPageRoute(builder: (context) => const SignInPage()));
  }


  @override
  void initState() {
    super.initState();
    silentLogIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Padding(
              padding: EdgeInsets.all(50),
              child: Text("Conch", style: TextStyle(fontSize: 100),),
            ),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}