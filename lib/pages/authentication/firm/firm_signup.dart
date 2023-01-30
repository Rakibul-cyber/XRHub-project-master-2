import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:urlnav2/constants/custom_text.dart';
import 'package:urlnav2/constants/style.dart';
import 'package:urlnav2/helpers/helperfunctions.dart';
import 'package:urlnav2/helpers/reponsiveness.dart';
import 'package:urlnav2/helpers/services/auth.dart';
import 'package:urlnav2/helpers/services/database.dart';
import 'package:urlnav2/helpers/services/firebase_api.dart';
import 'package:urlnav2/pages/authentication/widget/user_card.dart';
import 'package:path/path.dart' as Path;

class CVKFirmSignUp extends StatefulWidget {
  const CVKFirmSignUp({Key key}) : super(key: key);

  @override
  _CVKFirmSignUp createState() => _CVKFirmSignUp();
}

class _CVKFirmSignUp extends State<CVKFirmSignUp> {
  final Stream<QuerySnapshot> cases =
      FirebaseFirestore.instance.collection('users').snapshots();

  final CollectionReference users =
      FirebaseFirestore.instance.collection('firms');
  int currentStep = 0;

  File _image;
  UploadTask task;
  Uint8List bytes;
  PlatformFile byte_file;
  String myfilename = "";

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _passwordVisible;

  final firmnameController = TextEditingController();
  final vatController = TextEditingController();
  final regnumController = TextEditingController();
  final urlController = TextEditingController();

  final addresscontroller = TextEditingController();
  final postcodeController = TextEditingController();
  var countryValue = "";
  var stateValue = "";
  var cityValue = "";
  final phnumController = TextEditingController();
  final faxnumController = TextEditingController();

  final adminnameController = TextEditingController();
  final jobtitleController = TextEditingController();
  final TextEditingController _currencyController = TextEditingController();
  String _currency = 'Currency';
  String jobstartdate =
      DateFormat('EEE, d/M/y').format(DateTime.now()).toString();

  String dpurl = "";

  AuthService authService = new AuthService();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  String dropdownvalue = 'Greenwich Mean Time GMT';
  var timezone = [
    'Greenwich Mean Time GMT',
    'Universal Coordinated Time UTC',
    'European Central Time GMT+1:00',
    'Eastern European Time GMT+2:00',
    '(Arabic) Egypt Standard Time GMT+2:00',
    'Eastern African Time GMT+3:00',
    'Middle East Time GMT+3:30',
    'Near East Time GMT+4:00',
    'Pakistan Lahore Time GMT+5:00',
    'India Standard Time GMT+5:30',
    'Bangladesh Standard Time GMT+6:00',
    'Vietnam Standard Time GMT+7:00',
    'China Taiwan Time GMT+8:00',
    'Japan Standard Time GMT+9:00',
    'Australia Central Time GMT+9:30',
    'Australia Eastern Time GMT+10:00',
    'Solomon Standard Time GMT+11:00',
    'New Zealand Standard Time GMT+12:00',
    'Midway Islands Time GMT-11:00',
    'Hawaii Standard Time	GMT-10:00',
    'Alaska Standard Time GMT-9:00',
    'Pacific Standard Time GMT-8:00',
    'Phoenix Standard Time GMT-7:00',
    'Mountain Standard Time GMT-7:00',
    'Central Standard Time GMT-6:00',
    'Eastern Standard Time	GMT-5:00',
    'Indiana Eastern Standard Time	GMT-5:00',
    'Puerto Rico and US Virgin Islands Time GMT-4:00',
    'Canada Newfoundland Time GMT-3:30',
    'Argentina Standard Time GMT-3:00',
    'Brazil Eastern Time GMT-3:00',
    'Central African Time	GMT-1:00'
  ];

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  singUp() async {
    if (formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });

      await authService
          .signUpWithEmailAndPassword(
              emailController.text, passwordController.text)
          .then((result) {
        if (result != null) {
          User user = FirebaseAuth.instance.currentUser;
          uploadtodatabase(user.uid);

          //HelperFunctions.saveUserLoggedInSharedPreference(true);
          //HelperFunctions.saveUserNameSharedPreference(firmnameController.text);
          //HelperFunctions.saveUserEmailSharedPreference(emailController.text);

          Get.offAllNamed("/");
        }
      });
    }
  }

  /*Future getImage() async {
    var images = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      _image = File(images.path);
    });
  }*/

  List<Step> getSteps() => [
        Step(
            state: currentStep > 0 ? StepState.complete : StepState.indexed,
            title: Text("Account"),
            content: Column(
              children: [
                Row(
                  children: [
                    if (ResponsiveWidget.isLargeScreen(context))
                      Flexible(flex: 3, child: Container()),
                    Flexible(
                      flex: 2,
                      child: Center(
                        heightFactor: 2,
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: legistwhite,
                            border: Border.all(
                                color: legistblue.withOpacity(.4), width: .5),
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0, 6),
                                  color: lightGrey.withOpacity(.1),
                                  blurRadius: 12)
                            ],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            children: [
                              Image.asset(
                                "assets/icons/logo.png",
                                width: 100,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              CustomText(
                                text: "Please enter Email and Password",
                                color: dark,
                                size: 15,
                                weight: FontWeight.bold,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Form(
                                key: formKey,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      controller: emailController,
                                      decoration: InputDecoration(
                                          labelText: "Work Email",
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10))),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      controller: passwordController,
                                      obscureText: !_passwordVisible,
                                      decoration: InputDecoration(
                                          labelText: "Password",
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                                _passwordVisible
                                                    ? Icons.visibility_outlined
                                                    : Icons
                                                        .visibility_off_outlined,
                                                color: grey),
                                            onPressed: () {
                                              setState(() {
                                                _passwordVisible =
                                                    !_passwordVisible;
                                              });
                                            },
                                          ),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10))),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (ResponsiveWidget.isLargeScreen(context))
                      Flexible(flex: 3, child: Container()),
                  ],
                ),
              ],
            ),
            isActive: currentStep >= 0),
        Step(
            state: currentStep > 1 ? StepState.complete : StepState.indexed,
            title: Text("Firm Information"),
            content: Column(
              children: [
                Row(
                  children: [
                    if (ResponsiveWidget.isLargeScreen(context))
                      Flexible(flex: 1, child: Container()),
                    Flexible(
                      flex: 2,
                      child: Center(
                        heightFactor: 2,
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: legistwhite,
                            border: Border.all(
                                color: legistblue.withOpacity(.4), width: .5),
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0, 6),
                                  color: lightGrey.withOpacity(.1),
                                  blurRadius: 12)
                            ],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            children: [
                              Image.asset(
                                "assets/icons/logo.png",
                                width: 100,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              CustomText(
                                text: "Firm Information",
                                color: dark,
                                size: 15,
                                weight: FontWeight.bold,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        controller: firmnameController,
                                        decoration: InputDecoration(
                                            labelText: "Firm Name",
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10))),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        controller: vatController,
                                        decoration: InputDecoration(
                                            labelText: "VAT ID",
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10))),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        controller: regnumController,
                                        decoration: InputDecoration(
                                            labelText: "Registration Number",
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10))),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        controller: urlController,
                                        decoration: InputDecoration(
                                            labelText: "Website URL",
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10))),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (ResponsiveWidget.isLargeScreen(context))
                      Flexible(flex: 1, child: Container()),
                  ],
                ),
              ],
            ),
            isActive: currentStep >= 1),
        Step(
            title: Text("Contact Information"),
            content: Column(
              children: [
                Row(
                  children: [
                    if (ResponsiveWidget.isLargeScreen(context))
                      Flexible(flex: 2, child: Container()),
                    Flexible(
                      flex: 2,
                      child: Center(
                        heightFactor: 2,
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: legistwhite,
                            border: Border.all(
                                color: legistblue.withOpacity(.4), width: .5),
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0, 6),
                                  color: lightGrey.withOpacity(.1),
                                  blurRadius: 12)
                            ],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            children: [
                              Image.asset(
                                "assets/icons/logo.png",
                                width: 100,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              CustomText(
                                text: "Please provide your contact information",
                                color: dark,
                                size: 15,
                                weight: FontWeight.bold,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          right: 4, bottom: 8),
                                      child: TextFormField(
                                        controller: addresscontroller,
                                        decoration: InputDecoration(
                                            labelText: "Address",
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10))),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          right: 4, bottom: 8),
                                      child: TextFormField(
                                        controller: postcodeController,
                                        decoration: InputDecoration(
                                            labelText: "Postcode",
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10))),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              CSCPicker(
                                ///Enable disable state dropdown [OPTIONAL PARAMETER]
                                showStates: true,

                                /// Enable disable city drop down [OPTIONAL PARAMETER]
                                showCities: true,

                                ///Enable (get flag with country name) / Disable (Disable flag) / ShowInDropdownOnly (display flag in dropdown only) [OPTIONAL PARAMETER]
                                flagState: CountryFlag.DISABLE,

                                ///Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER] (USE with disabledDropdownDecoration)
                                dropdownDecoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Colors.grey.shade300, width: 1)),

                                ///Disabled Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER]  (USE with disabled dropdownDecoration)
                                disabledDropdownDecoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    color: Colors.grey.shade300,
                                    border: Border.all(
                                        color: Colors.grey.shade300, width: 1)),

                                ///placeholders for dropdown search field
                                countrySearchPlaceholder: "Country",
                                stateSearchPlaceholder: "State",
                                citySearchPlaceholder: "City",

                                ///labels for dropdown
                                countryDropdownLabel: "Country",
                                stateDropdownLabel: "State",
                                cityDropdownLabel: "City",

                                ///Default Country
                                //defaultCountry: DefaultCountry.India,

                                ///Disable country dropdown (Note: use it with default country)
                                //disableCountry: true,

                                ///selected item style [OPTIONAL PARAMETER]
                                selectedItemStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),

                                ///DropdownDialog Heading style [OPTIONAL PARAMETER]
                                dropdownHeadingStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),

                                ///DropdownDialog Item style [OPTIONAL PARAMETER]
                                dropdownItemStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),

                                ///Dialog box radius [OPTIONAL PARAMETER]
                                dropdownDialogRadius: 10.0,

                                ///Search bar radius [OPTIONAL PARAMETER]
                                searchBarRadius: 10.0,

                                ///triggers once country selected in dropdown
                                onCountryChanged: (value) {
                                  setState(() {
                                    ///store value in country variable
                                    countryValue = value;
                                  });
                                },

                                ///triggers once state selected in dropdown
                                onStateChanged: (value) {
                                  setState(() {
                                    ///store value in state variable
                                    stateValue = value;
                                  });
                                },

                                ///triggers once city selected in dropdown
                                onCityChanged: (value) {
                                  setState(() {
                                    ///store value in city variable
                                    cityValue = value;
                                  });
                                },
                              ),
                              Row(
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          right: 4, top: 8),
                                      child: TextFormField(
                                        controller: phnumController,
                                        decoration: InputDecoration(
                                            labelText: "Phone number",
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10))),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          right: 4, top: 8),
                                      child: TextFormField(
                                        controller: faxnumController,
                                        decoration: InputDecoration(
                                            labelText: "Fax number",
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10))),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (ResponsiveWidget.isLargeScreen(context))
                      Flexible(flex: 2, child: Container()),
                  ],
                ),
              ],
            ),
            isActive: currentStep >= 2),
        Step(
            title: Text("Regional Information"),
            content: Column(
              children: [
                Row(
                  children: [
                    if (ResponsiveWidget.isLargeScreen(context))
                      Flexible(flex: 3, child: Container()),
                    Flexible(
                      flex: 2,
                      child: Center(
                        heightFactor: 2,
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: legistwhite,
                            border: Border.all(
                                color: legistblue.withOpacity(.4), width: .5),
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0, 6),
                                  color: lightGrey.withOpacity(.1),
                                  blurRadius: 12)
                            ],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            children: [
                              Image.asset(
                                "assets/icons/logo.png",
                                width: 100,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              CustomText(
                                text: "Please enter your Job Position",
                                color: dark,
                                size: 15,
                                weight: FontWeight.bold,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          right: 4, top: 8),
                                      child: TextFormField(
                                        controller: adminnameController,
                                        decoration: InputDecoration(
                                            labelText: "Admin Name",
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10))),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          right: 4, top: 8),
                                      child: TextFormField(
                                        controller: jobtitleController,
                                        decoration: InputDecoration(
                                            labelText: "Job Title",
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10))),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              y10,
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: legistwhite,
                                  border:
                                      Border.all(color: lightGrey, width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    CustomText(
                                      text: "$jobstartdate",
                                      size: 14,
                                      weight: FontWeight.normal,
                                    ),
                                    Expanded(child: Container()),
                                    ElevatedButton(
                                        onPressed: () {
                                          showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime(1999),
                                                  lastDate: DateTime(2023))
                                              .then((value) {
                                            setState(() {
                                              jobstartdate =
                                                  DateFormat('EEE, d/M/y')
                                                      .format(value)
                                                      .toString();
                                            });
                                          });
                                        },
                                        child: Text("Starting Date")),
                                  ],
                                ),
                              ),
                              y10,
                              buildCurrencyTF(context),
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (ResponsiveWidget.isLargeScreen(context))
                      Flexible(flex: 3, child: Container()),
                  ],
                ),
              ],
            ),
            isActive: currentStep >= 3),
        Step(
            title: Text("Profile Picture"),
            content: Column(
              children: [
                Row(
                  children: [
                    if (ResponsiveWidget.isLargeScreen(context))
                      Flexible(flex: 3, child: Container()),
                    Flexible(
                      flex: 2,
                      child: Center(
                        heightFactor: 2,
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: legistwhite,
                            border: Border.all(
                                color: legistblue.withOpacity(.4), width: .5),
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0, 6),
                                  color: lightGrey.withOpacity(.1),
                                  blurRadius: 12)
                            ],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 100.0,
                                backgroundColor: legistblue,
                                child: ClipOval(
                                  child: SizedBox(
                                    width: 180.0,
                                    height: 180.0,
                                    child: _image != null
                                        ? Image.network(
                                            _image.path,
                                            fit: BoxFit.fill,
                                          )
                                        : Image.network(
                                            "https://www.seekpng.com/png/detail/847-8474751_download-empty-profile.png",
                                            fit: BoxFit.fill,
                                          ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    selectFile();
                                  },
                                  child: CustomText(
                                    text: "Add Photo",
                                    color: legistwhitefont,
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (ResponsiveWidget.isLargeScreen(context))
                      Flexible(flex: 3, child: Container()),
                  ],
                ),
              ],
            ),
            isActive: currentStep >= 4),
        Step(
            title: Text("Connect"),
            content: Column(
              children: [
                CustomText(
                  text: "Manage My Network",
                  weight: FontWeight.bold,
                  size: 20,
                ),
                Row(
                  children: [
                    if (ResponsiveWidget.isLargeScreen(context))
                      Flexible(flex: 2, child: Container()),
                    Flexible(
                      flex: 3,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.75,
                        child: StreamBuilder<QuerySnapshot>(
                            stream: cases,
                            builder: (
                              BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot,
                            ) {
                              if (snapshot.hasError) {
                                return Text(snapshot.error.toString());
                              }
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              }
                              final data = snapshot.requireData;

                              /*return ListView.builder(
                                itemCount: data.size,
                                itemBuilder: (context, index) {
                                  return Text(
                                      'My name is ${data.docs[index]['userName']}');
                                },
                              );*/
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [userlist(context, data)],
                              );
                            }),
                      ),
                    ),
                    if (ResponsiveWidget.isLargeScreen(context))
                      Flexible(flex: 2, child: Container()),
                  ],
                ),
              ],
            ),
            isActive: currentStep >= 5),
        Step(
            title: Text("App"),
            content: Container(
              child: Column(
                children: [
                  CustomText(
                    text: "Get the app to stay ahead",
                    weight: FontWeight.bold,
                    size: 20,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomText(
                    text: "Organize your cases and chat with clients on-the-go",
                    weight: FontWeight.w200,
                    size: 15,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Image.asset(
                    "assets/images/qrcode.png",
                    width: 250,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            isActive: currentStep >= 6),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Container(
              child: Center(child: CircularProgressIndicator()),
            )
          : Stepper(
              type: ResponsiveWidget.isSmallScreen(context)
                  ? StepperType.vertical
                  : StepperType.horizontal,
              currentStep: currentStep,
              onStepCancel: () {
                if (currentStep == 0) {
                } else {
                  setState(() {
                    currentStep -= 1;
                  });
                }
              },
              onStepContinue: () {
                final isLastStep = currentStep == getSteps().length - 1;

                if (isLastStep) {
                  singUp();
                  //uploadtodatabase();
                  //firebase
                } else {
                  setState(() {
                    currentStep += 1;
                  });
                }
              },
              onStepTapped: (int index) {
                setState(() {
                  currentStep = index;
                });
              },
              steps: getSteps(),
              controlsBuilder: (BuildContext context, ControlsDetails details) {
                return Container(
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      TextButton(
                        style: continueButtonStyle,
                        child: CustomText(
                          text: currentStep == 6 ? "Finish" : "Continue",
                          color: legistwhitefont,
                        ),
                        onPressed: details.onStepContinue,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      if (currentStep < 6)
                        TextButton(
                          style: backButtonStyle,
                          child: CustomText(
                            text: "Cancel",
                            color: legistblackfont,
                          ),
                          onPressed: details.onStepCancel,
                        )
                    ],
                  ),
                );
              },
            ),
    );
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() => _image = imageTemporary);
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print('Failed to pick images.');
      }
    }
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null)
      return;
    else if (result.files.single.bytes != null ||
        FilePicker.platform.toString() == "Instance of 'FilePickerWeb'") {
      setState(() {
        bytes = result.files.single.bytes;
        byte_file = result.files.single;
      });

      dpwidget(byte_file.name);
    } else {
      final path = result.files.single.path;
      setState(() => _image = File(path));

      dpwidget(Path.basename(_image.path));
    }

    if (task == null) return;

    final snapshot = await task.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
  }

  Widget dpwidget(String currentfilename) {
    return CircleAvatar(
      radius: 100.0,
      backgroundColor: legistblue,
      child: ClipOval(
        child: SizedBox(
          width: 180.0,
          height: 180.0,
          child: currentfilename != null
              ? Image.network(
                  currentfilename,
                  fit: BoxFit.fill,
                )
              : Image.network(
                  "https://www.seekpng.com/png/detail/847-8474751_download-empty-profile.png",
                  fit: BoxFit.fill,
                ),
        ),
      ),
    );
  }

  Future uploadFile() async {
    //isloading = true;

    if (_image == null && bytes == null) {
      return;
    } else if (_image != null) {
      final fileName = Path.basename(_image.path);
      final destination = 'profilepic/$fileName';

      task = uploadFiles(destination, _image);

      setState(() {
        myfilename = fileName;
      });
    } else {
      //if (bytes != null){
      final fileName = byte_file.name;
      final destination = 'profilepic/$fileName';
      task = uploadBytes(destination, bytes);
      setState(() {
        myfilename = fileName;
      });
    }

    if (task == null) return;

    final snapshot = await task.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    dpurl = urlDownload;
    //isloading = false;
  }

  static UploadTask uploadFiles(String destination, File file) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putFile(file);
    } on FirebaseException catch (e) {
      return null;
    }
  }

  static UploadTask uploadBytes(String destination, Uint8List data) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putData(data);
    } on FirebaseException catch (e) {
      return null;
    }
  }

  Widget userlist(BuildContext context, QuerySnapshot<Object> data) {
    return Expanded(
        child: GridView.builder(
            itemCount: data.size,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //mainAxisSpacing: 10,
              //crossAxisSpacing: 20,
              crossAxisCount: ResponsiveWidget.isLargeScreen(context)
                  ? 4
                  : ResponsiveWidget.isMediumScreen(context)
                      ? 3
                      : 2,
            ),
            itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: UserCard(
                    index: index,
                    username: data.docs[index]['firstname'],
                    jobtitle: data.docs[index]['jobtitle'],
                    location: getuserlocation(data.docs[index]['location']),
                  ),
                )));
  }

  String getuserlocation(String location) {
    return location.split(",")[0];
  }

  void uploadtodatabase(String userid) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Creating new User in database...'),
    ));

    //FirebaseApi.uploadFolder(emailController.text);
    uploadFile();

    users
        .doc(userid)
        .collection("details")
        .doc()
        .set({
          'email': emailController.text,
          'password': passwordController.text,
          'firmname': firmnameController.text,
          'vatid': vatController.text,
          'regnum': regnumController.text,
          'weburl': urlController.text,
          'address': addresscontroller.text,
          'address2':
              "${postcodeController.text}, $cityValue, $stateValue, $countryValue",
          'phonenumber': phnumController.text,
          'faxnumber': faxnumController.text,
          'currency': _currency,
          'adminname': adminnameController.text,
          'jobtitle': jobtitleController.text,
          'jobstartingdt': jobstartdate.toString(),
          'dpurl': dpurl,
        })
        .then((value) => print('User added successfully'))
        .catchError((error) => print('Failed to create new user: $error'));
    uploadextratodatabase(userid);
  }

  void uploadextratodatabase(String userid) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Creating new User in database...'),
    ));

    //FirebaseApi.uploadFolder(emailController.text);
    //uploadFile();

    users
        .doc(userid)
        .set({
          'email': emailController.text,
          'password': passwordController.text,
          'firmname': firmnameController.text,
          'vatid': vatController.text,
          'regnum': regnumController.text,
          'weburl': urlController.text,
          'address': addresscontroller.text,
          'address2':
              "${postcodeController.text}, $cityValue, $stateValue, $countryValue",
          'phonenumber': phnumController.text,
          'faxnumber': faxnumController.text,
          'currency': _currency,
          'adminname': adminnameController.text,
          'jobtitle': jobtitleController.text,
          'jobstartingdt': jobstartdate.toString(),
          'dpurl': dpurl,
        })
        .then((value) => print('User added successfully'))
        .catchError((error) => print('Failed to create new user: $error'));
  }

  final ButtonStyle continueButtonStyle = ElevatedButton.styleFrom(
    onPrimary: dark,
    primary: legistblue,
    fixedSize: Size(250, 40),
    minimumSize: Size(88, 36),
    //padding: EdgeInsets.symmetric(horizontal: 26),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
  );

  final ButtonStyle backButtonStyle = ElevatedButton.styleFrom(
    onPrimary: dark,
    primary: lightGrey.withOpacity(0.3),
    fixedSize: Size(250, 40),
    minimumSize: Size(88, 36),
    //padding: EdgeInsets.symmetric(horizontal: 26, vertical: 10),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
  );

  Future pickCurrency(BuildContext context) async {
    showCurrencyPicker(
      context: context,
      showFlag: true,
      showCurrencyName: true,
      showCurrencyCode: true,
      onSelect: (Currency currency) {
        setState(() {
          _currency = currency.name;
        });
      },
      favorite: ['MYR'],
    );
  }

  Widget buildCurrencyTF(BuildContext context) {
    return TextFormField(
      autofocus: true,
      readOnly: true,
      decoration: InputDecoration(
          hintText: _currency,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 5),
            child: IconButton(
              icon: const Icon(Icons.currency_exchange_rounded,
                  color: Colors.blue),
              onPressed: () {
                pickCurrency(context);
              },
            ),
          )),
      validator: (value) {
        if (value.isEmpty) {
          return 'Please fill up this field.';
        }
        return null;
      },
      controller: _currencyController,
      //keyboardType: TextInputType.datetime,
      inputFormatters: [FilteringTextInputFormatter.singleLineFormatter],
    );
  }
}
