import 'package:flutter/material.dart';
import 'package:urlnav2/pages/authentication/firm/firm_signin_main.dart';
import 'package:urlnav2/pages/authentication/firm/firm_signup_main.dart';

class AuthenticateFirm extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<AuthenticateFirm> {
  bool showSignIn = true;

  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return CVKFirmSignIn(toggleView);
    } else {
      return CVKFirmSignUpMain(
        toggleView,
      );
    }
  }
}
