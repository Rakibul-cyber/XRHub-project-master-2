import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:urlnav2/appState.dart';
import 'package:urlnav2/constants/custom_text.dart';
import 'package:urlnav2/constants/style.dart';
import 'package:urlnav2/helpers/reponsiveness.dart';
import 'package:urlnav2/helpers/services/auth.dart';
import 'package:urlnav2/pages/clients/widgets/clients_new_form2.dart';
import 'package:intl/intl.dart';

class ClientformWeb extends StatefulWidget {
  final AppState appState;
  ClientformWeb({Key key, this.appState}) : super(key: key);

  @override
  State<ClientformWeb> createState() => _ClientformWebState();
}

class _ClientformWebState extends State<ClientformWeb> {
  CollectionReference addmyclient;
  Stream<QuerySnapshot> currclients;

  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  bool status = true;
  List<Widget> _newPersonList = [];
  //var compnameValue = "";
  //var comregnumValue = "";
  //var compphnnumValue = "";
  //var compfaxnumValue = "";
  //var fnameValue = "";
  //var lnameValue = "";
  //var emailValue = "";
  //var mnumberValue = "";
  //var altnumberValue = "";
  //var addressValue = "";
  //var postcodeValue = "";
  var clientrunnumber = "";
  var countryValue = "";
  var stateValue = "";
  var cityValue = "";

  final compname = TextEditingController();
  final comregnum = TextEditingController();
  final compphnnum = TextEditingController();
  final compfaxnum = TextEditingController();

  final clientname = TextEditingController();
  final clientusername = TextEditingController();
  ClientGender clientGender = ClientGender.male;
  final clientemail = TextEditingController();
  final clientpassword = TextEditingController();
  final clientconfirmpassword = TextEditingController();
  final clientmnumber = TextEditingController();
  final clientaltnumber = TextEditingController();
  final clientaddress = TextEditingController();
  final clientpostcode = TextEditingController();

  List<TextEditingController> refnamecontroller = [];
  List<TextEditingController> refnumcontroller = [];
  List<TextEditingController> refemailcontroller = [];
  List<TextEditingController> refaddresscontroller = [];

  @override
  void initState() {
    addmyclient = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.appState.myid)
        .collection('clients');
    currclients = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.appState.myid)
        .collection('clients')
        .snapshots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: ResponsiveWidget.isSmallScreen(context)
            ? const EdgeInsets.symmetric(horizontal: 0, vertical: 5)
            : const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
        child: ListView(
          children: [
            SizedBox(
              height: 10,
            ),
            getcurrentnum(),
            FlutterSwitch(
              activeText: "Individual",
              inactiveText: "Company",
              activeColor: legistblue,
              inactiveColor: Colors.amber,
              activeTextColor: legistwhitefont,
              inactiveTextColor: legistblackfont,
              width: 125.0,
              height: 40.0,
              valueFontSize: 15.0,
              toggleSize: 20.0,
              value: status,
              borderRadius: 20.0,
              padding: 8.0,
              showOnOff: true,
              onToggle: (val) {
                setState(() {
                  status = val;
                });
              },
            ),
            SizedBox(
              height: 10,
            ),
            if (status == false)
              Column(
                children: [
                  Row(
                    children: [
                      Flexible(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: TextFormField(
                              controller: compname,
                              decoration: InputDecoration(
                                  labelText: "Company Name",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                          )),
                      Flexible(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: TextFormField(
                              controller: comregnum,
                              decoration: InputDecoration(
                                  labelText: "Company Registeration Number",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                          )),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Flexible(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: TextFormField(
                              controller: compphnnum,
                              decoration: InputDecoration(
                                  labelText: "Office Phone Number",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                          )),
                      Flexible(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: TextFormField(
                              controller: compfaxnum,
                              decoration: InputDecoration(
                                  labelText: "Fax Number",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                          )),
                    ],
                  ),
                ],
              ),
            SizedBox(height: 10),
            Row(
              children: [
                Flexible(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        controller: clientname,
                        decoration: InputDecoration(
                            labelText: status == true
                                ? "Full Name"
                                : "Person incharge name",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    )),
                Flexible(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        controller: clientusername,
                        decoration: InputDecoration(
                            labelText: status == true
                                ? "Username"
                                : "Person incharge username",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    )),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                /*Flexible(
                          flex: 2,
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: ListTile(
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Radio(
                                    activeColor: active,
                                    value: 0,
                                    groupValue: genderValue,
                                    onChanged1: (value) {
                                      setState(() {
                                        genderValue = value;
                                      });
                                    },
                                  ),
                                  Text('Male',
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption),
                                  Radio(
                                    activeColor: active,
                                    value: 1,
                                    groupValue: genderValue,
                                    onChanged1: (value) {
                                      setState(() {
                                        genderValue = value;
                                      });
                                    },
                                  ),
                                  Text("Female",
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption),
                                ],
                              ),
                            ),
                          )),*/
                Flexible(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: ResponsiveWidget.isSmallScreen(context)
                          ? MainAxisAlignment.center
                          : MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: ResponsiveWidget.isSmallScreen(context)
                              ? const EdgeInsets.all(5)
                              : const EdgeInsets.only(
                                  left: 10, right: 0, top: 0, bottom: 0),
                          child: Row(
                            children: [
                              Radio<ClientGender>(
                                value: ClientGender.male,
                                groupValue: clientGender,
                                onChanged: (ClientGender value) {
                                  setState(() {
                                    clientGender = value;
                                  });
                                },
                              ),
                              CustomText(
                                text: "Male",
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: ResponsiveWidget.isSmallScreen(context)
                              ? const EdgeInsets.all(5)
                              : const EdgeInsets.only(
                                  left: 10, right: 0, top: 0, bottom: 0),
                          child: Row(
                            children: [
                              Radio<ClientGender>(
                                value: ClientGender.female,
                                groupValue: clientGender,
                                onChanged: (ClientGender value) {
                                  setState(() {
                                    clientGender = value;
                                  });
                                },
                              ),
                              CustomText(
                                text: "Female",
                              )
                            ],
                          ),
                        ),
                      ],
                    )),
                Flexible(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        controller: clientemail,
                        style: greyTextStyle(),
                        decoration: InputDecoration(
                            labelText: "Email",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    )),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Flexible(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        controller: clientpassword,
                        decoration: InputDecoration(
                            labelText: "Password",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    )),
                Flexible(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        controller: clientconfirmpassword,
                        decoration: InputDecoration(
                            labelText: "Confirm Password",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    )),
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
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        controller: clientmnumber,
                        decoration: InputDecoration(
                            labelText: "Mobile Number",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    )),
                Flexible(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        controller: clientaltnumber,
                        decoration: InputDecoration(
                            labelText: "Alternate Number",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Flexible(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        controller: clientaddress,
                        decoration: InputDecoration(
                            labelText: "Address",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    )),
                Flexible(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        controller: clientpostcode,
                        decoration: InputDecoration(
                            labelText: "PostCode",
                            hintText: "11000",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  ///Adding CSC Picker Widget in app
                  CSCPicker(
                    ///Enable disable state dropdown [OPTIONAL PARAMETER]
                    showStates: true,

                    /// Enable disable city drop down [OPTIONAL PARAMETER]
                    showCities: true,

                    ///Enable (get flag with country name) / Disable (Disable flag) / ShowInDropdownOnly (display flag in dropdown only) [OPTIONAL PARAMETER]
                    flagState: CountryFlag.DISABLE,

                    ///Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER] (USE with disabledDropdownDecoration)
                    dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.transparent,
                        border:
                            Border.all(color: Colors.grey.shade300, width: 1)),

                    ///Disabled Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER]  (USE with disabled dropdownDecoration)
                    disabledDropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.grey.shade300,
                        border:
                            Border.all(color: Colors.grey.shade300, width: 1)),

                    ///placeholders for dropdown search field
                    countrySearchPlaceholder: "Country",
                    stateSearchPlaceholder: "State",
                    citySearchPlaceholder: "City",

                    ///labels for dropdown
                    countryDropdownLabel: "*Country",
                    stateDropdownLabel: "*State",
                    cityDropdownLabel: "*City",

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
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: _newPersonList.length.toDouble() * 250,
              child: ListView.builder(
                itemCount: _newPersonList.length,
                itemBuilder: (context, index) {
                  //return _newPersonList[index];

                  return Dismissible(
                    key: Key(_newPersonList[index].toString()),
                    onDismissed: (direction) {
                      setState(() {
                        _newPersonList.removeAt(index);
                      });
                    },
                    child: _newPersonList[index],
                  );
                },
              ),
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      _addnewPersonWidget();
                    },
                    icon: const Icon(
                      Icons.add_circle,
                      color: Colors.green,
                    )),
                const SizedBox(width: 10),
                Text(
                  "Add new person",
                  style: GoogleFonts.poppins(fontSize: 15, color: Colors.black),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            //Text("${_newPersonList.length}"),
            SizedBox(
              height: 10,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  //createclientuser(clientemail.text, clientpassword.text);
                  createuser(clientemail.text, clientpassword.text);
                },
                child: Text('Submit'),
              ),
            ),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }

  Widget getcurrentnum() {
    return StreamBuilder<QuerySnapshot>(
        stream: currclients,
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

          return Container(
            child: runningclient(getcasenum(data.size)),
          );
        });
  }

  Widget runningclient(String casenum) {
    return CustomText(
      text: casenum,
      color: grey,
    );
  }

  String getcasenum(int num) {
    if (num.toString().length == 1) {
      clientrunnumber =
          "client000${num}_${DateFormat("ddMMyy").format(DateTime.now()).toString()}";
      return clientrunnumber;
    } else if (num.toString().length == 2) {
      clientrunnumber =
          "client00${num}_${DateFormat("ddMMyy").format(DateTime.now()).toString()}";
      return clientrunnumber;
    } else if (num.toString().length == 3) {
      clientrunnumber =
          "client0${num}_${DateFormat("ddMMyy").format(DateTime.now()).toString()}";
      return clientrunnumber;
    } else if (num.toString().length == 1) {
      clientrunnumber =
          "client${num}_${DateFormat("ddMMyy").format(DateTime.now()).toString()}";
      return clientrunnumber;
    } else {
      return "loading";
    }
  }

  void createclientuser(String email, String password, String userid2) async {
    try {
      if (status) {
        isIndividual(clientrunnumber, userid2);
      } else {
        isCompany(clientrunnumber, userid2);
      }
      cleartext();

      //createuser(email, password);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  void createuser(String email, String password) async {
    //FirebaseAuth auth = FirebaseAuth.instance;

    FirebaseApp secondaryApp = Firebase.app('SecondaryApp');
    FirebaseAuth auth2 = FirebaseAuth.instanceFor(app: secondaryApp);

    auth2
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((firebaseUser) {
      print("User " + firebaseUser.user.uid + " created successfully!");
      //I don't know if the next statement is necessary
      createclientuser(email, password, firebaseUser.user.uid);
      auth2.signOut();
    });
  }

  void createuser2(String email, String password) async {
    //UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);

    Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyCWEoA-O6ZrU5VTV5dkh3zN8FbUeUcCt9g",
            authDomain: "socialmedia-a8f16.firebaseapp.com",
            projectId: "socialmedia-a8f16",
            storageBucket: "socialmedia-a8f16.appspot.com",
            messagingSenderId: "823849998943",
            appId: "1:823849998943:web:bf9d418d8fffe24577d9ea",
            measurementId: "G-GRJX8EYXDR"));

    //final FirebaseAuth _auth = FirebaseAuth.instance;
    var authService = AuthService();

    var _auth = FirebaseAuth.instance;

    _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((firebaseUser) {
      print("User " + firebaseUser.user.uid + " created successfully!");
      //I don't know if the next statement is necessary
      _auth.signOut();
      authService
          .signInWithEmailAndPassword("test4@test.com", "12345678")
          .then((result) async {});
    });
  }

  void cleartext() {
    compname.text = "";
    comregnum.text = "";
    compphnnum.text = "";
    compfaxnum.text = "";
    clientname.text = "";
    clientusername.text = "";
    clientemail.text = "";
    clientpassword.text = "";
    clientconfirmpassword.text = "";
    clientmnumber.text = "";
    clientaltnumber.text = "";
    clientaddress.text = "";
    clientpostcode.text = "";
  }

  void isIndividual(String userid, String userid2) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Creating new Client in database...'),
    ));

    addmyclient.doc(userid).set({
      'firstname': clientname.text,
      'username': clientusername.text,
      'email': clientemail.text,
      'gender': clientGender.name,
      'mobilenum': clientmnumber.text,
      'altnum': clientaltnumber.text,
      'address': clientaddress.text,
      'postcode': clientpostcode.text,
      "isuser": true,
      'country': countryValue,
      'state': stateValue,
      'city': cityValue,
      'userid': userid,
      'userid2': userid2,
      'iscompany': false
    }).then((value) {
      for (int i = 0; i < _newPersonList.length; i++) {
        addreftodatabase(i, userid);
      }
    }).catchError((error) => print('Failed to create new client: $error'));

    adduserdatabase(userid, userid2);
    addmoredetailstoclient(userid2);
  }

  void isCompany(String userid, String userid2) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Creating new Company in database...'),
    ));
    addmyclient.doc(userid).set({
      'firstname': clientname.text,
      'username': clientusername.text,
      'email': clientemail.text,
      'gender': clientGender.name,
      'mobilenum': clientmnumber.text,
      'altnum': clientaltnumber.text,
      'address': clientaddress.text,
      'postcode': clientpostcode.text,
      'country': countryValue,
      'state': stateValue,
      "isuser": true,
      'city': cityValue,
      'userid': userid,
      'userid2': userid2,
      'iscompany': true
    }).then((value) {
      for (int i = 0; i < _newPersonList.length; i++) {
        addreftodatabase(i, userid);
      }
      addcompanydetails(userid);
    }).catchError((error) => print('Failed to create new client: $error'));

    addusercompanydatabase(userid, userid2);
    addmoredetailstoclient(userid2);
  }

  void addcompanydetails(String clientsid) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Adding Company Details'),
    ));

    addmyclient.doc(clientsid).collection("companydetails").add({
      'companyname': compname.text,
      'companyregnum': comregnum.text,
      'companyphnnum': compphnnum.text,
      'companyfax': compfaxnum.text,
    }).catchError((e) {
      print(e.toString());
    });
  }

  void adduserdatabase(String userid, String userid2) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Creating new Client in database...'),
    ));

    FirebaseFirestore.instance.collection('users').doc(userid2).set({
      'firstname': clientname.text,
      'username': clientusername.text,
      'email': clientemail.text,
      'gender': clientGender.name,
      'mobilenum': clientmnumber.text,
      'altnum': clientaltnumber.text,
      'address': clientaddress.text,
      'postcode': clientpostcode.text,
      'country': countryValue,
      "isuser": true,
      'state': stateValue,
      'city': cityValue,
      'userid': userid,
      'lawyerid': widget.appState.myid,
      'userid2': userid2,
      'iscompany': false
    }).then((value) {
      for (int i = 0; i < _newPersonList.length; i++) {
        addreftoclientdatabase(i, userid2);
      }
    }).catchError((error) => print('Failed to create new client: $error'));
  }

  void addusercompanydatabase(String userid, String userid2) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Creating new Client in database...'),
    ));

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Creating new Company in database...'),
    ));
    FirebaseFirestore.instance.collection('users').doc(userid2).set({
      'firstname': clientname.text,
      'username': clientusername.text,
      'email': clientemail.text,
      'gender': clientGender.name,
      'mobilenum': clientmnumber.text,
      'altnum': clientaltnumber.text,
      'address': clientaddress.text,
      'postcode': clientpostcode.text,
      'country': countryValue,
      "isuser": true,
      'state': stateValue,
      'city': cityValue,
      'userid': userid,
      'lawyerid': widget.appState.myid,
      'userid2': userid2,
      'iscompany': true
    }).then((value) {
      for (int i = 0; i < _newPersonList.length; i++) {
        addreftoclientdatabase(i, userid2);
      }
      addcompanydetailstoclient(userid2);
    }).catchError((error) => print('Failed to create new client: $error'));
  }

  void addcompanydetailstoclient(String clientsid) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Adding Company Details'),
    ));

    FirebaseFirestore.instance
        .collection('users')
        .doc(clientsid)
        .collection("companydetails")
        .add({
      'companyname': compname.text,
      'companyregnum': comregnum.text,
      'companyphnnum': compphnnum.text,
      'companyfax': compfaxnum.text,
    }).catchError((e) {
      print(e.toString());
    });
  }

  void addmoredetailstoclient(String clientsid) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Adding Client Data'),
    ));

    FirebaseFirestore.instance
        .collection('users')
        .doc(clientsid)
        .collection("details")
        .add({
      'firstname': clientname.text,
      'lawyerid': widget.appState.myid,
      'userid2': clientsid,
    }).catchError((e) {
      print(e.toString());
    });
  }

  void _addnewPersonWidget() {
    setState(() {
      refnamecontroller.add(new TextEditingController());
      refnumcontroller.add(new TextEditingController());
      refemailcontroller.add(new TextEditingController());
      refaddresscontroller.add(new TextEditingController());
      _newPersonList.add(newPerson(_newPersonList.length));
    });
  }

  void _deletenewPersonWidget(int i) {
    setState(() {
      _newPersonList.removeAt(i);
    });
  }

  Widget newPerson(int currentnum) {
    return Container(
      child: Column(
        children: [
          const SizedBox(
            child: Divider(
              height: 10,
              color: lightGrey,
              indent: 10,
              endIndent: 10,
            ),
            height: 25,
          ),
          CustomText(
            text: "Reference #${_newPersonList.length + 1}",
          ),
          Row(
            children: [
              Flexible(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      validator: (val) {
                        return RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(val)
                            ? null
                            : "Please Enter Correct Email";
                      },
                      controller: refnamecontroller[_newPersonList.length],
                      style: greyTextStyle(),
                      decoration: InputDecoration(
                          labelText: "Name",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  )),
              Flexible(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      validator: (val) {
                        return RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(val)
                            ? null
                            : "Please Enter Correct Email";
                      },
                      controller: refnumcontroller[_newPersonList.length],
                      style: greyTextStyle(),
                      decoration: InputDecoration(
                          labelText: "Mobile Number",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  )),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Flexible(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      validator: (val) {
                        return RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(val)
                            ? null
                            : "Please Enter Correct Email";
                      },
                      controller: refemailcontroller[_newPersonList.length],
                      style: greyTextStyle(),
                      decoration: InputDecoration(
                          labelText: "Email",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  )),
              Flexible(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      validator: (val) {
                        return RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(val)
                            ? null
                            : "Please Enter Correct Email";
                      },
                      controller: refaddresscontroller[_newPersonList.length],
                      style: greyTextStyle(),
                      decoration: InputDecoration(
                          labelText: "Address",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  )),
            ],
          ),
          //if (_newPersonList.length == currentnum)
          IconButton(
              onPressed: () {
                _deletenewPersonWidget(_newPersonList.length - 1);
              },
              icon: const Icon(
                Icons.delete_outline,
                color: Colors.red,
              )),
        ],
      ),
    );
  }

  void addreftodatabase(int index, String clientsid) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Adding References...'),
    ));

    addmyclient.doc(clientsid).collection("references").add({
      'refname': refnamecontroller[index].text,
      'refmobile': refnumcontroller[index].text,
      'refemail': refemailcontroller[index].text,
      'refaddress': refaddresscontroller[index].text,
    }).catchError((e) {
      print(e.toString());
    });
  }

  void addreftoclientdatabase(int index, String clientsid) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Adding References...'),
    ));

    FirebaseFirestore.instance
        .collection('users')
        .doc(clientsid)
        .collection("references")
        .add({
      'refname': refnamecontroller[index].text,
      'refmobile': refnumcontroller[index].text,
      'refemail': refemailcontroller[index].text,
      'refaddress': refaddresscontroller[index].text,
    }).catchError((e) {
      print(e.toString());
    });
  }
}
