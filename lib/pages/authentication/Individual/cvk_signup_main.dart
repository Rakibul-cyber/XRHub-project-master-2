import 'package:flutter/material.dart';
import 'package:urlnav2/constants/custom_text.dart';
import 'package:urlnav2/constants/style.dart';
import 'package:urlnav2/helpers/reponsiveness.dart';
import 'package:urlnav2/pages/authentication/Individual/cvk_signup_new.dart';

class CVKSignUpMain extends StatefulWidget {
  final Function toggleView;

  CVKSignUpMain(this.toggleView);

  @override
  _CVKSignUpMain createState() => _CVKSignUpMain();
}

class _CVKSignUpMain extends State<CVKSignUpMain> {
  final formKey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      pages: [
        MaterialPage(child: build2(context)),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }
        return true;
      },
    );
  }

  Widget build2(BuildContext context) {
    return Material(
        child: Scaffold(
      body: isLoading
          ? Container(
              child: Center(child: CircularProgressIndicator()),
            )
          : Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("images/back_abc.png"),
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
                      if (ResponsiveWidget.isSmallScreen(context))
                        Flexible(
                            flex: 0,
                            child: Container(
                              width: MediaQuery.of(context).size.width / 8,
                            )),
                      Flexible(
                        flex: 2,
                        child: Container(
                          decoration: ResponsiveWidget.isSmallScreen(context)
                              ? BoxDecoration(
                                  color: lightest,
                                  boxShadow: [
                                    BoxShadow(
                                        offset: Offset(0, 6),
                                        color: lightGrey.withOpacity(0.5),
                                        blurRadius: 5)
                                  ],
                                  borderRadius: BorderRadius.circular(4),
                                )
                              : BoxDecoration(
                                  color: lightest,
                                  boxShadow: [
                                    BoxShadow(
                                        offset: Offset(0, 6),
                                        color: lightGrey.withOpacity(0.5),
                                        blurRadius: 5)
                                  ],
                                  borderRadius: BorderRadius.circular(4),
                                ),
                          //height: MediaQuery.of(context).size.height * 0.95,
                          padding: EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        // Image.asset(
                                        //   "assets/icons/logo.png",
                                        //   width: 150,
                                        // ),
                                        SizedBox(
                                          height: 30,
                                        ),
                                        Image.asset(
                                          "assets/images/logo.png",
                                          width: 200,
                                        ),
                                        SizedBox(
                                          height: 30,
                                        ),
                                      ],
                                    ),
                                  ]),
                              SizedBox(
                                height: 10,
                              ),
                              CustomText(
                                  text: "Sign up",
                                  color: skyblue,
                                  weight: FontWeight.w500,
                                  size: 25),
                              SizedBox(
                                height: 5,
                              ),
                              CustomText(
                                  text:
                                      "Make the most of your professional life",
                                  color: dark,
                                  weight: FontWeight.w500,
                                  size: 12),
                              SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                height: 35,
                              ),
                              Builder(
                                  builder: ((context) => GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      CVKSignUp()));
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 16),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              color: skyblue),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Text(
                                            "Continue with email",
                                            style: biggerTextStyle(),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ))),
                              /*GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CVKSignUp()));
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
                              ),*/
                              // SizedBox(
                              //   height: 25,
                              // ),
                              // Container(
                              //   padding: EdgeInsets.symmetric(vertical: 16),
                              //   decoration: BoxDecoration(
                              //       border: Border.all(color: dark),
                              //       borderRadius: BorderRadius.circular(30),
                              //       color: Colors.white),
                              //   width: MediaQuery.of(context).size.width,
                              //   child: Text(
                              //     "Continue with Google",
                              //     style: TextStyle(fontSize: 17, color: dark),
                              //     textAlign: TextAlign.center,
                              //   ),
                              // ),
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
                                        color: skyblue,
                                        weight: FontWeight.bold,
                                        size: 12),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 70,
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
                      if (ResponsiveWidget.isSmallScreen(context))
                        Flexible(
                            flex: 0,
                            child: Container(
                              width: MediaQuery.of(context).size.width / 8,
                            )),
                    ],
                  ),
                ],
              ),
            ),
    ));
  }
}
