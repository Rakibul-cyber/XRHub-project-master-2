import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:urlnav2/constants/custom_text.dart';
import 'package:urlnav2/constants/style.dart';
import 'package:urlnav2/helpers/helperfunctions.dart';
import 'package:urlnav2/helpers/reponsiveness.dart';
import 'package:urlnav2/helpers/services/auth.dart';
import 'package:urlnav2/helpers/services/database.dart';
import 'package:urlnav2/pages/authentication/firm/authenticatefirm.dart';

class CVKSignIn extends StatefulWidget {
  final Function toggleView;

  CVKSignIn(this.toggleView);

  @override
  _CVKSignIn createState() => _CVKSignIn();
}

class _CVKSignIn extends State<CVKSignIn> {
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
          User user = FirebaseAuth.instance.currentUser;
          QuerySnapshot userInfoSnapshot =
              await DatabaseMethods().getUserInfo(emailEditingController.text);

          HelperFunctions.saveUserLoggedInSharedPreference(true);
          HelperFunctions.saveUserIDSharedPreference(user.uid);
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
            : !ResponsiveWidget.isSmallScreen(context)
                ? Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          // decoration: BoxDecoration(
                          //   image: DecorationImage(
                          //       image:
                          //           AssetImage("assets/images/backgroundImage.png"),
                          //       fit: BoxFit.cover,

                          //       ),
                          // ),
                          color: light,
                          child: ListView(
                            children: [
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 10,
                              ),
                              Row(
                                children: [
                                  Flexible(
                                      flex: ResponsiveWidget.isLargeScreen(
                                              context)
                                          ? 2
                                          : 1,
                                      child: Center(child: Container())),
                                  middlecolumn(),
                                  Flexible(
                                      flex: ResponsiveWidget.isLargeScreen(
                                              context)
                                          ? 2
                                          : 1,
                                      child: Center(child: Container())),
                                ],
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              opacity: 0.8,
                              image: AssetImage("assets/images/abc.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: ListView(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(100.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Make the most of your professional life!',
                                      style: TextStyle(
                                        fontSize: 40,
                                        color: Color(0xFFE7E7E7),
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 50,
                                    ),
                                    TextButton.icon(
                                      onPressed: () {
                                        widget.toggleView();
                                      },
                                      icon: Icon(
                                        MaterialIcons.arrow_right_alt,
                                        color: Colors.white,
                                      ),
                                      label: Text(
                                        'Register Now',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    // Row(
                                    //   children: [
                                    //     Text('Register Now', style: TextStyle(
                                    //             fontSize: 16, color: white, fontWeight: FontWeight.bold,
                                    //     ),),
                                    //     SizedBox(width: 5,),
                                    //     Icon(MaterialIcons.arrow_right_alt, color: Colors.white,)
                                    //   ],
                                    // ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      opacity: 0.8,
                      image: AssetImage("assets/images/abc.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: ListView(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 10,
                      ),
                      Row(
                        children: [
                          Flexible(
                              flex: ResponsiveWidget.isLargeScreen(context)
                                  ? 2
                                  : 1,
                              child: Center(child: Container())),
                          middlecolumn(),
                          Flexible(
                              flex: ResponsiveWidget.isLargeScreen(context)
                                  ? 2
                                  : 1,
                              child: Center(child: Container())),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 10,
                      ),
                    ],
                  ),
                ),
      ),
    );
  }

  Widget middlecolumn() {
    return Flexible(
      flex: 5,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: legistwhite,
            boxShadow: [
              BoxShadow(offset: Offset(0, 6), color: lightGrey, blurRadius: 10)
            ],
            borderRadius: BorderRadius.circular(4),
          ),
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Column(
                    children: [
                      // Image.asset(
                      //   "assets/icons/logo.png",
                      //   width: 150,
                      // ),
                      // SizedBox(
                      //   height: 20,
                      // ),
                      Image.asset(
                        "assets/images/logo.png",
                        width: 200,
                      ),
                    ],
                  ),
                ]),
                SizedBox(
                  height: 50,
                ),
                // Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                //   Padding(
                //       padding: const EdgeInsets.all(10.0),
                //       child: CustomText(
                //         text: "TECZO XRHUB",
                //         size: 50,
                //         weight: FontWeight.bold,
                //       )),
                // ]),
                Row(
                  children: [
                    //if (!ResponsiveWidget.isSmallScreen(context))
                    // Expanded(
                    //   flex: 1,
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Image.asset(
                    //         'assets/images/login.png',
                    //         width: 450,
                    //         height: 500,
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomText(
                              text: "Sign in",
                              color: skyblue,
                              weight: FontWeight.w500,
                              size: 25),
                          SizedBox(
                            height: 5,
                          ),
                          CustomText(
                              text: "Stay updated in your professional world",
                              color: dark,
                              weight: FontWeight.w500,
                              size: 12),
                          SizedBox(
                            height: 50,
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
                                      labelText: "Email",
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4))),
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
                                        borderRadius: BorderRadius.circular(4)),
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
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                    child: CustomText(
                                        text: "Forgot Password?",
                                        color: skyblue,
                                        weight: FontWeight.bold,
                                        size: 12)),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          InkWell(
                            onHover: (value) {},
                            onTap: () {
                              signIn();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: skyblue),
                              width: MediaQuery.of(context).size.width,
                              child: Text(
                                "Sign In",
                                style: biggerTextStyle(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          // SizedBox(
                          //   child: Divider(
                          //     height: 10,
                          //     color: lightGrey,
                          //     indent: 10,
                          //     endIndent: 10,
                          //   ),
                          //   height: 25,
                          // ),
                          // InkWell(
                          //   onHover: (value) {},
                          //   onTap: () {
                          //     //checkcreateuser();
                          //   },
                          //   child: Container(
                          //     padding: EdgeInsets.symmetric(vertical: 16),
                          //     decoration: BoxDecoration(
                          //         border: Border.all(color: dark),
                          //         borderRadius: BorderRadius.circular(30),
                          //         color: Colors.white),
                          //     width: MediaQuery.of(context).size.width,
                          //     child: Row(
                          //       mainAxisAlignment: MainAxisAlignment.center,
                          //       children: [
                          //         SizedBox(
                          //             width: 32,
                          //             height: 24,
                          //             child: Image.asset(
                          //                 'assets/images/google_icon.png')),
                          //         Text(
                          //           "Sign In with Google",
                          //           style: TextStyle(fontSize: 17, color: dark),
                          //           textAlign: TextAlign.center,
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
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
                              InkWell(
                                onHover: (value) {},
                                onTap: () {
                                  widget.toggleView();
                                },
                                child: CustomText(
                                    text: "Join Now",
                                    color: skyblue,
                                    weight: FontWeight.bold,
                                    size: 12),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          /*Center(
                            child: InkWell(
                              onHover: (value) {},
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AuthenticateFirm()));
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 8),
                                decoration: BoxDecoration(
                                    border: Border.all(color: dark),
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.white),
                                //width: MediaQuery.of(context).size.width,
                                child: Text(
                                  "Sign In as a Firm",
                                  style: TextStyle(fontSize: 12, color: dark),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),*/
                          SizedBox(
                            height: 25,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void checkcreateusertets() async {
    if (formKey.currentState.validate()) {
      await authService
          .signUpWithEmailAndPassword("unique23@test.com", "12345678")
          .then((result) async {
        if (result != null) {
          User user = FirebaseAuth.instance.currentUser;

          uploadextratodatabaseters(user.uid);

          //Get.offAllNamed("/");
          //Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
          //setState(() {});
        }
      });
    }
  }

  void uploadextratodatabaseters(String userid) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Creating new User in database'),
    ));

    //FirebaseApi.uploadFolder(emailController.text);

    FirebaseFirestore.instance
        .collection('mytestuser')
        .doc(userid)
        .collection("details")
        .doc()
        .set({
          'email': "emailController.text",
          'password': "passwordController.text",
          'firmname': "firmNameController.text",
          'firstname': "fnameController.text",
          'lastname': "lnameController.text",
          'location': "",
          'jobtitle': "jobtitleController.text",
          'jobstartingdt': "jobstartdate.toString()",
          'dpurl': "imagepath",
        })
        .then((value) => print('Details added successfully'))
        .catchError((error) => print('Failed to create new user: $error'));
  }
}
