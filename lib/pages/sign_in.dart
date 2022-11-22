import 'package:conch/util/alerts.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../util/buttons.dart';
import '../util/textboxes.dart';
import 'home.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String signUpEmail = "";
  String signUpPassword = "";
  String signInEmail = "";
  String signInPassword = "";

  Future signUp (String email, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        alert(
            context: context,
            title: "The password is too weak.",
            message: const Text("Make sure your password has more than 6 characters."),
            actions: [AlertButton(title: "OK")]
        );
      }
      else if (e.code == 'email-already-in-use') {
        alert(
          context: context,
          title: "The provided email is already in use.",
          message: const Text("Use the sign in button to sign in to an existing account."),
          actions: [AlertButton(title: "OK")]
        );
      }
      return e.message;
    } catch (e) {
      print(e);
      return e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffbf6f2),
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {  
          Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
        },
      ),
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.6,
          heightFactor: 0.75,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)
            ),
            padding: EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Sign up",
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        RoundedTextBox(
                          onChanged: (String s) {
                            signUpEmail = s;
                          },
                          hintText: "Email address",
                        ),
                        RoundedTextBox(
                          onChanged: (String s) {
                            signUpPassword = s;
                          },
                          hintText: "Password (6+ characters)",
                          obscureText: true,
                        ),
                        RoundedButton(
                          text: "Sign up",
                          onPressed: () {
                            signUp(signUpEmail, signUpPassword).then((result) {
                              if (result == null) {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
                              } else {
                                alert(context: context, title: "An unexpected error happened.", message: Text("Please try again."));
                              }
                            });
                          },
                        ),
                        Expanded(
                          child: GoogleButton(
                            text: "Sign up with Google",
                            onPressed: () {

                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: const [
                    Expanded(
                      child: VerticalDivider(
                        width: 20,
                        color: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        "OR",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                          color: Colors.grey
                        ),
                      ),
                    ),
                    Expanded(
                      child: VerticalDivider(
                        width: 20,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Sign in",
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        RoundedTextBox(
                          onChanged: (String s) {

                          },
                          hintText: "Email address",
                        ),
                        RoundedTextBox(
                          onChanged: (String s) {

                          },
                          hintText: "Password (6+ characters)",
                          obscureText: true,
                        ),
                        RoundedButton(
                          text: "Sign in",
                          onPressed: () {

                          },
                        ),
                        Expanded(
                          child: GoogleButton(
                            text: "Sign in with Google",
                            onPressed: () {

                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
