import 'dart:html';

import 'package:conch/main.dart';
import 'package:conch/util/alerts.dart';
import 'package:conch/util/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  bool isObscured = true;
  IconData passwordVisibilityIcon = Icons.visibility;
  String errorText = "";

  String resetPasswordEmail = "";
  bool forgotPasswordHovered = false;
  bool rememberMe = true;

  late User currentUser;

  Future register ({required String email, required String password}) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      currentUser = _auth.currentUser!;
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
      currentUser = _auth.currentUser!;
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

  Future forgotPassword ({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      snackbar(context: context, message: "An email with instructions to reset your password has been sent to $resetPasswordEmail. Make sure to check your spam folder if you do not receive the email within a few minutes.");
    } on FirebaseAuthException catch (e) {
      print(e.message);
      snackbar(context: context, message: "(Error: ${e.code}) ${e.message} Please try again.");
    } catch (e) {
      print(e);
      snackbar(context: context, message: "Error: $e. Please try again.");
    }
  }

  void saveLogin () async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("remember_me", true);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      backgroundColor: const Color(0xfffbf6f2),
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.35,
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
                  obscureText: isObscured,
                  textVisibilityIcon: Icon(
                    passwordVisibilityIcon,
                    color: Colors.grey.shade700,
                  ),
                  revealText: () {
                    setState (() {
                      isObscured = !isObscured;
                      isObscured ? (passwordVisibilityIcon = Icons.visibility) : (passwordVisibilityIcon = Icons.visibility_off);
                    });
                  },
                  onChanged: (String s) {
                    setState(() {
                      passwordBorderColor = Colors.grey;
                      errorText = "";
                    });
                    typedPassword = s;
                  },
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
                      GestureDetector(
                        onTap: () {
                          alert(
                              context: context,
                              title: "Enter your email to receive a link to reset your password.",
                              message: TextField(
                                onChanged: (String s) {
                                  resetPasswordEmail = s;
                                },
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                              ),
                            actions: [
                              AlertButton(
                                title: "Send",
                                onPressed: () {
                                  forgotPassword(email: resetPasswordEmail);
                                  Navigator.pop(context);
                                },
                              ),
                              AlertButton(title: "Exit")
                            ],
                          );
                        },
                        child: MouseRegion(
                          onEnter: (p) {
                            setState(() {
                              forgotPasswordHovered = true;
                            });
                          },
                          onExit: (p) {
                            setState(() {
                              forgotPasswordHovered = false;
                            });
                          },
                          child: Text(
                            "Forgot password?",
                            style: TextStyle(
                              fontSize: 15,
                              decoration: forgotPasswordHovered ? TextDecoration.underline : TextDecoration.none,
                              decorationThickness: 2
                            ),
                          ),
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                      Checkbox(
                        value: rememberMe,
                        onChanged: (bool? value) {
                          setState(() {
                            rememberMe = value ?? true;
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
                              if(rememberMe) {
                                saveLogin();
                              }
                              Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(user: currentUser,)));
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
                              Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(user: currentUser,)));
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
