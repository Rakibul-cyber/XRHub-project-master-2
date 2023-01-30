import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urlnav2/constants/custom_text.dart';
import 'package:urlnav2/constants/style.dart';
import 'package:urlnav2/helpers/helperfunctions.dart';
import 'package:urlnav2/helpers/reponsiveness.dart';
import 'package:urlnav2/helpers/services/auth.dart';
import 'package:urlnav2/helpers/services/database.dart';
import 'package:urlnav2/pages/authentication/authenticate.dart';

class CVKFirmSignIn extends StatefulWidget {
  final Function toggleView;

  CVKFirmSignIn(this.toggleView);

  @override
  _CVKFirmSignIn createState() => _CVKFirmSignIn();
}

class _CVKFirmSignIn extends State<CVKFirmSignIn> {
  TextEditingController emailEditingController = new TextEditingController();
  TextEditingController passwordEditingController = new TextEditingController();
  bool _passwordVisible;

  AuthService authService = new AuthService();

  final formKey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  signIn() async {
    if (formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });

      await authService
          .signInWithEmailAndPassword(
              emailEditingController.text, passwordEditingController.text)
          .then((result) async {
        if (result != null) {
          QuerySnapshot userInfoSnapshot =
              await DatabaseMethods().getUserInfo(emailEditingController.text);

          HelperFunctions.saveUserLoggedInSharedPreference(true);
          HelperFunctions.saveUserNameSharedPreference(
              userInfoSnapshot.docs[0]["userName"]);
          HelperFunctions.saveUserEmailSharedPreference(
              userInfoSnapshot.docs[0]["userEmail"]);

          Get.offAllNamed("/");
        } else {
          setState(() {
            isLoading = false;
            //show snackbar
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Container(
              child: Center(child: CircularProgressIndicator()),
            )
          : Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("images/login_background.jpg"),
                      fit: BoxFit.cover)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      if (!ResponsiveWidget.isSmallScreen(context))
                        Flexible(
                            flex:
                                ResponsiveWidget.isLargeScreen(context) ? 3 : 1,
                            child: Container()),
                      middlecolumn(),
                      if (!ResponsiveWidget.isSmallScreen(context))
                        Flexible(
                            flex:
                                ResponsiveWidget.isLargeScreen(context) ? 3 : 1,
                            child: Container()),
                    ],
                  ),
                ],
              ),
            ),
    );
  }

  Widget middlecolumn() {
    return Flexible(
      flex: 2,
      child: Container(
        decoration: ResponsiveWidget.isSmallScreen(context)
            ? BoxDecoration(
                color: light,
              )
            : BoxDecoration(
                color: legistwhite,
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 6), color: lightGrey, blurRadius: 10)
                ],
                borderRadius: BorderRadius.circular(8),
              ),
        height: MediaQuery.of(context).size.height * 0.75,
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Image.asset("assets/icons/logo.png"),
            ]),
            CustomText(
                text: "Firm Sign in",
                color: dark,
                weight: FontWeight.w500,
                size: 25),
            SizedBox(
              height: 5,
            ),
            CustomText(
                text: "Manage your Firm like a pro",
                color: dark,
                weight: FontWeight.w500,
                size: 12),
            SizedBox(
              height: 20,
            ),
            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    validator: (val) {
                      return RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(val)
                          ? null
                          : "Please Enter Correct Email";
                    },
                    controller: emailEditingController,
                    style: greyTextStyle(),
                    decoration: InputDecoration(
                        labelText: "Admin Email",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    obscureText: !_passwordVisible,
                    validator: (val) {
                      return val.length > 5
                          ? null
                          : "Enter Password 6+ characters";
                    },
                    style: greyTextStyle(),
                    controller: passwordEditingController,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        tooltip: "Show Password",
                        icon: Icon(
                          _passwordVisible
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                      labelText: "Password",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    //Navigator.push(
                    //    context,
                    //   MaterialPageRoute(
                    //      builder: (context) => ForgotPassword()));
                  },
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: CustomText(
                          text: "Forgot Password?",
                          color: legistblue,
                          weight: FontWeight.bold,
                          size: 12)),
                )
              ],
            ),
            SizedBox(
              height: 16,
            ),
            GestureDetector(
              onTap: () {
                signIn();
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30), color: legistblue),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "Sign In",
                  style: biggerTextStyle(),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              child: Divider(
                height: 10,
                color: lightGrey,
                indent: 10,
                endIndent: 10,
              ),
              height: 25,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                  border: Border.all(color: dark),
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white),
              width: MediaQuery.of(context).size.width,
              child: Text(
                "Sign In with Google",
                style: TextStyle(fontSize: 17, color: dark),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                    text: "New to CVK?",
                    color: dark,
                    weight: FontWeight.bold,
                    size: 12),
                SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () {
                    widget.toggleView();
                  },
                  child: CustomText(
                      text: "Join Now",
                      color: legistblue,
                      weight: FontWeight.bold,
                      size: 12),
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Authenticate()));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  decoration: BoxDecoration(
                      border: Border.all(color: dark),
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white),
                  //width: MediaQuery.of(context).size.width,
                  child: Text(
                    "Sign In as an Individual",
                    style: TextStyle(fontSize: 12, color: dark),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 25,
            )
          ],
        ),
      ),
    );
  }
}
