import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as Path;
import 'package:urlnav2/constants/custom_text.dart';
import 'package:urlnav2/constants/style.dart';
import 'package:urlnav2/helpers/helperfunctions.dart';
import 'package:urlnav2/helpers/reponsiveness.dart';
import 'package:urlnav2/helpers/services/auth.dart';
import 'package:urlnav2/helpers/services/database.dart';
import 'package:urlnav2/helpers/services/firebase_api.dart';
import 'package:urlnav2/main.dart';
import 'package:urlnav2/pages/authentication/authenticate.dart';
import 'package:urlnav2/pages/authentication/widget/qrcodeapp.dart';
import 'package:urlnav2/pages/authentication/widget/user_card.dart';

class CVKSignUp extends StatefulWidget {
  const CVKSignUp({Key key}) : super(key: key);

  @override
  _CVKSignUp createState() => _CVKSignUp();
}

class _CVKSignUp extends State<CVKSignUp> {
  final Stream<QuerySnapshot> userparent = FirebaseFirestore.instance
      .collection('users')
      .where("isuser", isEqualTo: false)
      .snapshots();

  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  int currentStep = 0;

  UploadTask task;
  File file;
  Uint8List bytes;
  PlatformFile byte_file;
  String myfilename = "";
  String defaultpic =
      "https://www.seekpng.com/png/detail/847-8474751_download-empty-profile.png";

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _passwordVisible;

  final fnameController = TextEditingController();
  final lnameController = TextEditingController();
  final firmNameController = TextEditingController();
  final jobtitleController = TextEditingController();

  var countryValue = "";
  var stateValue = "";
  var cityValue = "";
  DateTime jobstartdate2 = DateTime.now();
  String jobstartdate =
      DateFormat('EEE, d/M/y').format(DateTime.now()).toString();

  AuthService authService = new AuthService();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  final formKey = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  bool isLoading = false;

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
          .then((result) async {
        if (result != null) {
          User user = FirebaseAuth.instance.currentUser;

          uploadtodatabase(user.uid);

          HelperFunctions.saveUserLoggedInSharedPreference(true);
          HelperFunctions.saveUserIDSharedPreference(user.uid);
          HelperFunctions.saveUserNameSharedPreference(fnameController.text);
          HelperFunctions.saveUserEmailSharedPreference(emailController.text);

          //Get.offAllNamed("/");
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MyApp()));
          //setState(() {});
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

  Future selectFile(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null)
      return;
    else if (result.files.single.bytes != null ||
        FilePicker.platform.toString() == "Instance of 'FilePickerWeb'") {
      setState(() {
        bytes = result.files.single.bytes;
        byte_file = result.files.single;
      });

      //Navigator.of(context).pop();
      //uploadFile();
    } else {
      final path = result.files.single.path;
      setState(() => file = File(path));

      //Navigator.of(context).pop();
      //uploadFile();
    }

    if (task == null) return;

    final snapshot = await task.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
  }

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
                                          labelText: "Email",
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
            title: Text("Personal Details"),
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
                                text: "Please enter your name",
                                color: dark,
                                size: 15,
                                weight: FontWeight.bold,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Form(
                                key: formKey2,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      controller: fnameController,
                                      decoration: InputDecoration(
                                          labelText: "First Name",
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10))),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      controller: lnameController,
                                      decoration: InputDecoration(
                                          labelText: "Last Name",
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
            isActive: currentStep >= 1),
        Step(
            title: Text("Address"),
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
                                text: "Please provide your location",
                                color: dark,
                                size: 15,
                                weight: FontWeight.bold,
                              ),
                              SizedBox(
                                height: 20,
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
            isActive: currentStep >= 2),
        Step(
            title: Text("Job"),
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
                              TextFormField(
                                controller: firmNameController,
                                decoration: InputDecoration(
                                    labelText: "Firm Name",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: jobtitleController,
                                decoration: InputDecoration(
                                    labelText: "Job Title",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                              ),
                              SizedBox(
                                height: 10,
                              ),
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
                              )
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
                                    child: byte_file != null
                                        ? Image.memory(
                                            bytes,
                                            fit: BoxFit.fill,
                                          )
                                        : Image.network(
                                            defaultpic,
                                            fit: BoxFit.fill,
                                          ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),

                              /*ElevatedButton(
                                  onPressed: () {
                                    selectFile(context);
                                  },
                                  child: CustomText(
                                    text: "Add Photo",
                                    color: legistwhitefont,
                                  ))*/
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
                        child: getexistinguserids(),
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
                  Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Image.asset(
                        "assets/images/qrcodeapp.png",
                        width: 350,
                      ),
                      const QRAppScan(),
                    ],
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
    return Builder(builder: (context) {
      return Material(
          child: Scaffold(
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Authenticate()));
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
                    //checkcreateusertets();
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
                controlsBuilder:
                    (BuildContext context, ControlsDetails details) {
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
      ));
    });
  }

  Widget getAllUsers(String docname) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(docname)
            .collection("details")
            .snapshots(),
        builder: (
          BuildContext context,
          AsyncSnapshot<QuerySnapshot> snapshot,
        ) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          final data = snapshot.requireData;
          return UserCard(
            username: data.docs[0]['firstname'],
            jobtitle: data.docs[0]['jobtitle'],
            url: data.docs[0]['dpurl'],
            location: getuserlocation(data.docs[0]['location']),
          );
        });
  }

  Widget getexistinguserids() {
    return StreamBuilder<QuerySnapshot>(
        stream: userparent,
        builder: (
          BuildContext context,
          AsyncSnapshot<QuerySnapshot> snapshot,
        ) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          final data = snapshot.requireData;
          return userlist(context, data);
        });
  }

  Widget userlist(BuildContext context, QuerySnapshot<Object> data) {
    return Column(
      children: [
        Expanded(
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
                      child: getAllUsers(data.docs[index].reference.id),
                    ))),
      ],
    );
  }

  String getuserlocation(String location) {
    return location.split(",")[0];
  }

  void uploadtodatabase(String userid) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Creating new User in database...'),
    ));

    FirebaseApi.uploadFolder(emailController.text);
    uploadFile(userid);
  }

  Future uploadFile(String userid) async {
    if (file == null && bytes == null) {
      uploadextratodatabase(userid, defaultpic);
      uploadextratodatabase2(userid, defaultpic);
      return;
    } else if (file != null) {
      final fileName = Path.basename(file.path);
      final destination = '${emailController.text}/$fileName';

      task = uploadFiles(destination, file);

      setState(() {
        myfilename = fileName;
      });
    } else {
      //if (bytes != null){
      final fileName = byte_file.name;
      final destination = '${emailController.text}/$fileName';
      task = uploadBytes(destination, bytes);
      setState(() {
        myfilename = fileName;
      });
    }

    if (task == null) return;

    final snapshot = await task.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    uploadextratodatabase(userid, urlDownload);
    uploadextratodatabase2(userid, urlDownload);
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

  void uploadextratodatabase(String userid, String imagepath) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Creating new User in database'),
    ));

    //FirebaseApi.uploadFolder(emailController.text);

    users
        .doc(userid)
        .collection("details")
        .doc()
        .set({
          'email': emailController.text,
          'password': passwordController.text,
          'firmname': firmNameController.text,
          'firstname': fnameController.text,
          'lastname': lnameController.text,
          'location': "$cityValue, $stateValue, $countryValue",
          'jobtitle': jobtitleController.text,
          'jobstartingdt': jobstartdate.toString(),
          'dpurl': imagepath,
        })
        .then((value) => print('Details added successfully'))
        .catchError((error) => print('Failed to create new user: $error'));
  }

  void uploadextratodatabase2(String userid, String imagepath) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('adding details...'),
    ));

    users
        .doc(userid)
        .set({
          'email': emailController.text,
          'password': passwordController.text,
          'firmname': firmNameController.text,
          "isuser": false,
          'firstname': fnameController.text,
          'lastname': lnameController.text,
          'location': "$cityValue, $stateValue, $countryValue",
          'jobtitle': jobtitleController.text,
          'jobstartingdt': jobstartdate.toString(),
          'dpurl': imagepath,
        })
        .then((value) => print('Details added successfully'))
        .catchError((error) => print('Failed to create new user: $error'));
  }

  void uploadextratodatabase3(String userid, String imagepath) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('adding details...'),
    ));

    users
        .doc(userid)
        .collection('experience')
        .add({
          'firmname': firmNameController.text,
          'jobtitle': jobtitleController.text,
          'jobstartingdt': jobstartdate.toString(),
          'jobenddate': 'Present',
        })
        .then((value) => print('Details added successfully'))
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

  void checkcreateusertets() async {
    await authService
        .signUpWithEmailAndPassword("unique235@test.com", "12345678")
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
