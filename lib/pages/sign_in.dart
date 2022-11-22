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

  String typedEmail = "";
  String typedPassword = "";

  Color emailBorderColor = Colors.grey;
  Color passwordBorderColor = Colors.grey;
  String errorText = "";

  bool rememberMe = false;

  Future register ({required String email, required String password}) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        setState(() {
          passwordBorderColor = Colors.red;
          errorText = "The password is too weak. Make sure your password has more than 6 characters.";
        });
      }
      else if (e.code == "email-already-in-use") {
        setState(() {
          emailBorderColor = Colors.red;
          errorText = "The provided email is already in use. Press sign in if you already have an account.";
        });
      }
      return e.message;
    } catch (e) {
      setState(() {
        errorText = "$e Please try again.";
      });
      return e;
    }
  }

  Future signIn ({required String email, required String password}) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        setState(() {
          emailBorderColor = Colors.red;
          errorText = "The provided email could not be found. Press register to create a new account.";
        });
      } else if (e.code == "wrong-password") {
        setState(() {
          passwordBorderColor = Colors.red;
          errorText = "Incorrect password. Please try again.";
        });
      }
      return e.message;
    } catch (e) {
      setState(() {
        errorText = "$e Please try again.";
      });
      return e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      backgroundColor: Color(0xfffbf6f2),
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.4,
          heightFactor: 0.75,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    "Register/Sign in",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                RoundedTextBox(
                  label: "Email",
                  borderColor: emailBorderColor,
                  padding: const EdgeInsets.fromLTRB(5, 10, 5, 5),
                  onChanged: (String s) {
                    setState(() {
                      emailBorderColor = Colors.grey;
                      errorText = "";
                    });
                    typedEmail = s;
                  },
                ),
                RoundedTextBox(
                  label: "Password (6+ characters)",
                  borderColor: passwordBorderColor,
                  padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
                  onChanged: (String s) {
                    setState(() {
                      passwordBorderColor = Colors.grey;
                      errorText = "";
                    });
                    typedPassword = s;
                  },
                  obscureText: true,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    errorText,
                    style: const TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 20, 10),
                  child: Row(
                    children: [
                      const Text(
                        "Forgot password?",
                        style: TextStyle(
                          fontSize: 15,
                          decoration: TextDecoration.underline,
                          decorationThickness: 2
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                      Checkbox(
                        value: rememberMe,
                        onChanged: (bool? value) {
                          setState(() {
                            rememberMe = value!;
                          });
                        },
                      ),
                      const Text("Remember me"),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: RoundedButton(
                        text: "Register",
                        onPressed: () {
                          register(email: typedEmail, password: typedPassword).then((result) {
                            if (result == null) {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
                            }
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: RoundedButton(
                        text: "Sign in",
                        onPressed: () {
                          signIn(email: typedEmail, password: typedPassword).then((result) {
                            if (result == null) {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
                            }
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: const [
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          color: Colors.grey,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(7),
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
                        child: Divider(
                          thickness: 1,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                GoogleButton(
                  text: "Continue with Google",
                  onPressed: () {

                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
