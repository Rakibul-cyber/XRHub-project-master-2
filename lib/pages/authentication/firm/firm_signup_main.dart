import 'package:flutter/material.dart';
import 'package:urlnav2/constants/custom_text.dart';
import 'package:urlnav2/constants/style.dart';
import 'package:urlnav2/helpers/reponsiveness.dart';
import 'package:urlnav2/pages/authentication/firm/firm_signup.dart';

class CVKFirmSignUpMain extends StatefulWidget {
  final Function toggleView;

  CVKFirmSignUpMain(this.toggleView);

  @override
  _CVKFirmSignUpMain createState() => _CVKFirmSignUpMain();
}

class _CVKFirmSignUpMain extends State<CVKFirmSignUpMain> {
  final formKey = GlobalKey<FormState>();

  bool isLoading = false;

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
                      Flexible(
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
                                        offset: Offset(0, 6),
                                        color: lightGrey.withOpacity(0.5),
                                        blurRadius: 5)
                                  ],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                          height: MediaQuery.of(context).size.height * 0.75,
                          padding: EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset("assets/icons/logo.png"),
                                  ]),
                              CustomText(
                                  text: "Firm Sign up",
                                  color: dark,
                                  weight: FontWeight.w500,
                                  size: 25),
                              SizedBox(
                                height: 5,
                              ),
                              CustomText(
                                  text:
                                      "Create an account to manage your law firm",
                                  color: dark,
                                  weight: FontWeight.w500,
                                  size: 12),
                              SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CVKFirmSignUp()));
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: legistblue),
                                  width: MediaQuery.of(context).size.width,
                                  child: Text(
                                    "Continue with email",
                                    style: biggerTextStyle(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              SizedBox(
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
                                  "Continue with Google",
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
                                      text: "Already on CVK?",
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
                                        text: "Sign In",
                                        color: legistblue,
                                        weight: FontWeight.bold,
                                        size: 12),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 50,
                              )
                            ],
                          ),
                        ),
                      ),
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
}
