import 'package:flutter/material.dart';
import 'package:urlnav2/pages/authentication/Individual/cvk_signin_new.dart';
import 'package:urlnav2/pages/authentication/Individual/cvk_signup_main.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return CVKSignIn(toggleView);
    } else {
      return CVKSignUpMain(
        toggleView,
      );
    }
  }
}
