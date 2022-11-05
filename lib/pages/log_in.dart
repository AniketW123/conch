import 'package:conch/util/sign_in_block.dart';
import 'package:flutter/material.dart';
import 'home.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
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
                Expanded(child: SignInBlock(heading: "Sign up")),
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
                Expanded(child: SignInBlock(heading: "Sign in")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
