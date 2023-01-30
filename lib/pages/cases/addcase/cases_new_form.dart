import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:urlnav2/appState.dart';
import 'package:urlnav2/constants/custom_text.dart';
import 'package:urlnav2/constants/style.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:urlnav2/pages/chat/widget/constants.dart';

class CasesAddForm extends StatefulWidget {
  final AppState appState;
  CasesAddForm({Key key, this.appState}) : super(key: key);

  @override
  _CasesFormState createState() => _CasesFormState();
}

class _CasesFormState extends State<CasesAddForm> {
  Stream<QuerySnapshot> clients;
  Stream<QuerySnapshot> casedetails;
  Stream<QuerySnapshot> currcases;
  Stream<QuerySnapshot> users;
  CollectionReference cases;
  CollectionReference tasks;
  CollectionReference addcasedetails;

  QuerySnapshot nameSnapshot;

  TextEditingController _titleController = TextEditingController();

  List<Widget> _caseList = [];

  var mytemp;
  var selectedClient;
  var selectedClient2;
  var selectedUser;
  var respondantname = "";
  var respondantadv = "";
  var casenumber = "";
  var casename = "";
  var casedesp = "";
  var casetypes;
  var casesubtypes;
  var stageofcase;
  var acts;
  var firsthearingdt = "";
  var filinnumber = "";
  var filingdate = "";
  var regnum = "";
  var regdate = "";
  var cnrnumber = "";
  var casedescription = "";
  var courtnum = "";
  var courttype;
  var court;
  var jdgtype;
  var jdgname = "";
  var remarks = "";
  var usrassign = "";
  var clientuserid = "";

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    getUserInfogetChats();
    clients = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.appState.myid)
        .collection('clients')
        .snapshots();
    currcases = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.appState.myid)
        .collection('cases')
        .snapshots();
    cases = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.appState.myid)
        .collection('cases');
    tasks = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.appState.myid)
        .collection('tasks');
    addcasedetails = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.appState.myid)
        .collection('casedetails');
    mytemp = "";
    super.initState();
  }

  getUserInfogetChats() async {
    await getmyusername().then((snapshot) {
      setState(() {
        nameSnapshot = snapshot;
      });
    });
    Constants.myName = nameSnapshot.docs[0]["firstname"];
    Constants.myID = nameSnapshot.docs[0]["email"];
  }

  getmyusername() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(widget.appState.myid)
        .collection('details')
        .get();
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(paddingMain),
        child: Column(
          children: [
            Expanded(
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          getcurrentnum(),
                          CustomText(
                            text: clientuserid,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const CustomText(
                            text: 'Client Details',
                            talign: TextAlign.center,
                          ),
                          StreamBuilder<QuerySnapshot>(
                            stream: clients,
                            builder: (
                              BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot,
                            ) {
                              if (!snapshot.hasData) {
                                return const CircularProgressIndicator();
                              } else {
                                List<DropdownMenuItem> currencyItems = [];
                                for (int i = 0;
                                    i < snapshot.data.docs.length;
                                    i++) {
                                  DocumentSnapshot snap = snapshot.data.docs[i];
                                  currencyItems.add(DropdownMenuItem(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Text(
                                        snap['firstname'],
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                    ),
                                    value: "${snap['firstname']}",
                                  ));
                                }
                                return Row(
                                  children: <Widget>[
                                    Flexible(
                                        flex: 1,
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton2(
                                              buttonDecoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                  color: lightGrey,
                                                ),
                                                color: Colors.transparent,
                                              ),
                                              items: currencyItems,
                                              onChanged: (clientValue) {
                                                setState(() {
                                                  selectedClient = clientValue;
                                                  getRelatedTasks(clientValue);
                                                });
                                              },
                                              value: selectedClient,
                                              isExpanded: true,
                                              hint: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                child: CustomText(
                                                    text: 'Select Client',
                                                    color:
                                                        dark.withOpacity(.8)),
                                              ),
                                            ),
                                          ),
                                        )),
                                  ],
                                );
                              }
                            },
                          ),
                          Row(
                            children: <Widget>[
                              //dropdowncontainer(),
                              Flexible(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    //child: dropdowncontainer(),
                                    child: TextField(
                                      decoration: InputDecoration(
                                          labelText: "Respondant Name",
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10))),
                                      onChanged: (value) {
                                        respondantname = value;
                                      },
                                    ),
                                  )),
                              Flexible(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: TextField(
                                      decoration: InputDecoration(
                                          labelText: "Respondant Advocate",
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10))),
                                      onChanged: (value) {
                                        respondantadv = value;
                                      },
                                    ),
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Column(
                        children: [
                          const Divider(
                            color: lightGrey,
                            height: 10,
                            thickness: 1.0,
                            indent: 20,
                            endIndent: 20,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const CustomText(
                            text: 'Case Details',
                            talign: TextAlign.center,
                          ),
                          Row(
                            children: [
                              Flexible(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: TextField(
                                      decoration: InputDecoration(
                                          labelText: "Case Name",
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10))),
                                      onChanged: (value) {
                                        casename = value;
                                      },
                                    ),
                                  )),
                              Flexible(
                                flex: 1,
                                child: StreamBuilder<QuerySnapshot>(
                                  stream: addcasedetails
                                      .where('type', isEqualTo: "stage")
                                      .snapshots(),
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
                                    } else {
                                      List<DropdownMenuItem> caseItems = [];
                                      for (int i = 0;
                                          i < snapshot.data.docs.length;
                                          i++) {
                                        DocumentSnapshot snap =
                                            snapshot.data.docs[i];
                                        caseItems.add(DropdownMenuItem(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Text(
                                              snap['title'],
                                              style: const TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                          value: "${snap['title']}",
                                        ));
                                      }
                                      caseItems.add(DropdownMenuItem(
                                        enabled: false,
                                        child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: ElevatedButton(
                                              onPressed: () async {
                                                await showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return StatefulBuilder(
                                                          builder: (context,
                                                              setState) {
                                                        return AlertDialog(
                                                          content: myskillss(
                                                              "Stage of Case"),
                                                          actions: <Widget>[
                                                            mypresswidget(
                                                                "stage",
                                                                context),
                                                          ],
                                                        );
                                                      });
                                                    });
                                              },
                                              child: const CustomText(
                                                color: legistwhitefont,
                                                text: "Add More",
                                              ),
                                            )),
                                        value: "",
                                      ));
                                      return Row(
                                        children: <Widget>[
                                          Flexible(
                                              flex: 1,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child:
                                                    DropdownButtonHideUnderline(
                                                  child: DropdownButton2(
                                                    buttonDecoration:
                                                        BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      border: Border.all(
                                                        color: lightGrey,
                                                      ),
                                                      color: Colors.transparent,
                                                    ),
                                                    items: caseItems,
                                                    onChanged: (clientValue) {
                                                      setState(() {
                                                        stageofcase =
                                                            clientValue;
                                                      });
                                                    },
                                                    value: stageofcase,
                                                    isExpanded: true,
                                                    hint: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 10),
                                                      child: CustomText(
                                                          text: 'Stage of Case',
                                                          color: dark
                                                              .withOpacity(.8)),
                                                    ),
                                                  ),
                                                ),
                                              )),
                                        ],
                                      );
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Flexible(
                                flex: 1,
                                child: StreamBuilder<QuerySnapshot>(
                                  stream: addcasedetails
                                      .where('type', isEqualTo: "casetype")
                                      .snapshots(),
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
                                    } else {
                                      List<DropdownMenuItem> caseItems = [];
                                      for (int i = 0;
                                          i < snapshot.data.docs.length;
                                          i++) {
                                        DocumentSnapshot snap =
                                            snapshot.data.docs[i];
                                        caseItems.add(DropdownMenuItem(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Text(
                                              snap['title'],
                                              style: const TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                          value: "${snap['title']}",
                                        ));
                                      }
                                      caseItems.add(DropdownMenuItem(
                                        enabled: false,
                                        child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: ElevatedButton(
                                              onPressed: () async {
                                                await showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return StatefulBuilder(
                                                          builder: (context,
                                                              setState) {
                                                        return AlertDialog(
                                                          content: myskillss(
                                                              "Case Type"),
                                                          actions: <Widget>[
                                                            mypresswidget(
                                                                "casetype",
                                                                context),
                                                          ],
                                                        );
                                                      });
                                                    });
                                              },
                                              child: const CustomText(
                                                color: legistwhitefont,
                                                text: "Add Case Type",
                                              ),
                                            )),
                                        value: "",
                                      ));
                                      return Row(
                                        children: <Widget>[
                                          Flexible(
                                              flex: 1,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child:
                                                    DropdownButtonHideUnderline(
                                                  child: DropdownButton2(
                                                    buttonDecoration:
                                                        BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      border: Border.all(
                                                        color: lightGrey,
                                                      ),
                                                      color: Colors.transparent,
                                                    ),
                                                    items: caseItems,
                                                    onChanged: (clientValue) {
                                                      setState(() {
                                                        casetypes = clientValue;
                                                      });
                                                    },
                                                    value: casetypes,
                                                    isExpanded: true,
                                                    hint: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 10),
                                                      child: CustomText(
                                                          text: 'Case Type',
                                                          color: dark
                                                              .withOpacity(.8)),
                                                    ),
                                                  ),
                                                ),
                                              )),
                                        ],
                                      );
                                    }
                                  },
                                ),
                              ),
                              Flexible(
                                  flex: 1,
                                  child: StreamBuilder<QuerySnapshot>(
                                    stream: addcasedetails
                                        .where('type', isEqualTo: "casesubtype")
                                        .snapshots(),
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
                                      } else {
                                        List<DropdownMenuItem> caseItems = [];
                                        for (int i = 0;
                                            i < snapshot.data.docs.length;
                                            i++) {
                                          DocumentSnapshot snap =
                                              snapshot.data.docs[i];
                                          caseItems.add(DropdownMenuItem(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: Text(
                                                snap['title'],
                                                style: const TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ),
                                            value: "${snap['title']}",
                                          ));
                                        }
                                        caseItems.add(DropdownMenuItem(
                                          enabled: false,
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: ElevatedButton(
                                                onPressed: () async {
                                                  await showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return StatefulBuilder(
                                                            builder: (context,
                                                                setState) {
                                                          return AlertDialog(
                                                            content: myskillss(
                                                                "Case Sub Type"),
                                                            actions: <Widget>[
                                                              mypresswidget(
                                                                  "casesubtype",
                                                                  context),
                                                            ],
                                                          );
                                                        });
                                                      });
                                                },
                                                child: const CustomText(
                                                  color: legistwhitefont,
                                                  text: "Add Case Sub Type",
                                                ),
                                              )),
                                          value: "",
                                        ));
                                        return Row(
                                          children: <Widget>[
                                            Flexible(
                                                flex: 1,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child:
                                                      DropdownButtonHideUnderline(
                                                    child: DropdownButton2(
                                                      buttonDecoration:
                                                          BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        border: Border.all(
                                                          color: lightGrey,
                                                        ),
                                                        color:
                                                            Colors.transparent,
                                                      ),
                                                      items: caseItems,
                                                      onChanged: (clientValue) {
                                                        setState(() {
                                                          casesubtypes =
                                                              clientValue;
                                                        });
                                                      },
                                                      value: casesubtypes,
                                                      isExpanded: true,
                                                      hint: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 10),
                                                        child: CustomText(
                                                            text:
                                                                'Case Sub Type',
                                                            color: dark
                                                                .withOpacity(
                                                                    .8)),
                                                      ),
                                                    ),
                                                  ),
                                                )),
                                          ],
                                        );
                                      }
                                    },
                                  )),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(children: [
                            Flexible(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: TextField(
                                    maxLines: 5,
                                    decoration: InputDecoration(
                                        label: CustomText(
                                          color: dark.withOpacity(.8),
                                          text: "Case Description",
                                        ),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                    onChanged: (value) {
                                      casedesp = value;
                                    },
                                  ),
                                )),
                          ]),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Flexible(
                                  flex: 1,
                                  child: StreamBuilder<QuerySnapshot>(
                                    stream: addcasedetails
                                        .where('type', isEqualTo: "acts")
                                        .snapshots(),
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
                                      } else {
                                        List<DropdownMenuItem> caseItems = [];
                                        for (int i = 0;
                                            i < snapshot.data.docs.length;
                                            i++) {
                                          DocumentSnapshot snap =
                                              snapshot.data.docs[i];
                                          caseItems.add(DropdownMenuItem(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: Text(
                                                snap['title'],
                                                style: const TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ),
                                            value: "${snap['title']}",
                                          ));
                                        }
                                        caseItems.add(DropdownMenuItem(
                                          enabled: false,
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: ElevatedButton(
                                                onPressed: () async {
                                                  await showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return StatefulBuilder(
                                                            builder: (context,
                                                                setState) {
                                                          return AlertDialog(
                                                            content: myskillss(
                                                                "Acts"),
                                                            actions: <Widget>[
                                                              mypresswidget(
                                                                  "acts",
                                                                  context),
                                                            ],
                                                          );
                                                        });
                                                      });
                                                },
                                                child: const CustomText(
                                                  color: legistwhitefont,
                                                  text: "Add Acts",
                                                ),
                                              )),
                                          value: "",
                                        ));
                                        return Row(
                                          children: <Widget>[
                                            Flexible(
                                                flex: 1,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child:
                                                      DropdownButtonHideUnderline(
                                                    child: DropdownButton2(
                                                      buttonDecoration:
                                                          BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        border: Border.all(
                                                          color: lightGrey,
                                                        ),
                                                        color:
                                                            Colors.transparent,
                                                      ),
                                                      items: caseItems,
                                                      onChanged: (clientValue) {
                                                        setState(() {
                                                          acts = clientValue;
                                                        });
                                                      },
                                                      value: acts,
                                                      isExpanded: true,
                                                      hint: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 10),
                                                        child: CustomText(
                                                            text: 'Act',
                                                            color: dark
                                                                .withOpacity(
                                                                    .8)),
                                                      ),
                                                    ),
                                                  ),
                                                )),
                                          ],
                                        );
                                      }
                                    },
                                  )),
                              Flexible(
                                  flex: 1,
                                  child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: InkWell(
                                        onTap: () {
                                          showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime(1999),
                                                  lastDate: DateTime(2023))
                                              .then((value) {
                                            setState(() {
                                              firsthearingdt =
                                                  DateFormat('EEE, d/M/y')
                                                      .format(value)
                                                      .toString();
                                            });
                                          });
                                        },
                                        child: Container(
                                          height: 50,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            border: Border.all(
                                                color: dark.withOpacity(.5),
                                                width: 1),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Center(
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10.0),
                                                  child: CustomText(
                                                      color:
                                                          dark.withOpacity(.8),
                                                      text: firsthearingdt == ""
                                                          ? "First Hearing Date"
                                                          : firsthearingdt),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ))),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Flexible(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: TextField(
                                      decoration: InputDecoration(
                                          labelText: "Filing Number",
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10))),
                                      onChanged: (value) {
                                        filinnumber = value;
                                      },
                                    ),
                                  )),
                              Flexible(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: InkWell(
                                      onTap: () {
                                        showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(1999),
                                                lastDate: DateTime(2023))
                                            .then((value) {
                                          setState(() {
                                            filingdate =
                                                DateFormat('EEE, d/M/y')
                                                    .format(value)
                                                    .toString();
                                          });
                                        });
                                      },
                                      child: Container(
                                        height: 50,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          border: Border.all(
                                              color: dark.withOpacity(.5),
                                              width: 1),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Center(
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0),
                                                child: CustomText(
                                                    color: dark.withOpacity(.8),
                                                    text: filingdate == ""
                                                        ? "Filing Date"
                                                        : filingdate),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Flexible(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: TextField(
                                      decoration: InputDecoration(
                                          labelText: "Registration Number",
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10))),
                                      onChanged: (value) {
                                        regnum = value;
                                      },
                                    ),
                                  )),
                              Flexible(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: InkWell(
                                      onTap: () {
                                        showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(1999),
                                                lastDate: DateTime(2023))
                                            .then((value) {
                                          setState(() {
                                            regdate = DateFormat('EEE, d/M/y')
                                                .format(value)
                                                .toString();
                                          });
                                        });
                                      },
                                      child: Container(
                                        height: 50,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          border: Border.all(
                                              color: dark.withOpacity(.5),
                                              width: 1),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Center(
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0),
                                                child: CustomText(
                                                    color: dark.withOpacity(.8),
                                                    text: regdate == ""
                                                        ? "Registration Date"
                                                        : regdate),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Flexible(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: TextField(
                                      decoration: InputDecoration(
                                          labelText: "CNR Number",
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10))),
                                      onChanged: (value) {
                                        cnrnumber = value;
                                      },
                                    ),
                                  )),
                              Flexible(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: TextField(
                                      decoration: InputDecoration(
                                          labelText: "Description",
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10))),
                                      onChanged: (value) {
                                        casedescription = value;
                                      },
                                    ),
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Column(
                        children: [
                          const Divider(
                            color: lightGrey,
                            height: 10,
                            thickness: 1.0,
                            indent: 20,
                            endIndent: 20,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const CustomText(
                            text: 'Court Details',
                            talign: TextAlign.center,
                          ),
                          Row(
                            children: [
                              Flexible(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: TextField(
                                      decoration: InputDecoration(
                                          labelText: "Court Number",
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10))),
                                      onChanged: (value) {
                                        courtnum = value;
                                      },
                                    ),
                                  )),
                              Flexible(
                                  flex: 1,
                                  child: StreamBuilder<QuerySnapshot>(
                                    stream: addcasedetails
                                        .where('type', isEqualTo: "courttype")
                                        .snapshots(),
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
                                      } else {
                                        List<DropdownMenuItem> caseItems = [];
                                        for (int i = 0;
                                            i < snapshot.data.docs.length;
                                            i++) {
                                          DocumentSnapshot snap =
                                              snapshot.data.docs[i];
                                          caseItems.add(DropdownMenuItem(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: Text(
                                                snap['title'],
                                                style: const TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ),
                                            value: "${snap['title']}",
                                          ));
                                        }
                                        caseItems.add(DropdownMenuItem(
                                          enabled: false,
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: ElevatedButton(
                                                onPressed: () async {
                                                  await showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return StatefulBuilder(
                                                            builder: (context,
                                                                setState) {
                                                          return AlertDialog(
                                                            content: myskillss(
                                                                "Court Type"),
                                                            actions: <Widget>[
                                                              mypresswidget(
                                                                  "courttype",
                                                                  context),
                                                            ],
                                                          );
                                                        });
                                                      });
                                                },
                                                child: const CustomText(
                                                  color: legistwhitefont,
                                                  text: "Add Court Type",
                                                ),
                                              )),
                                          value: "",
                                        ));
                                        return Row(
                                          children: <Widget>[
                                            Flexible(
                                                flex: 1,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child:
                                                      DropdownButtonHideUnderline(
                                                    child: DropdownButton2(
                                                      buttonDecoration:
                                                          BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        border: Border.all(
                                                          color: lightGrey,
                                                        ),
                                                        color:
                                                            Colors.transparent,
                                                      ),
                                                      items: caseItems,
                                                      onChanged: (clientValue) {
                                                        setState(() {
                                                          courttype =
                                                              clientValue;
                                                        });
                                                      },
                                                      value: courttype,
                                                      isExpanded: true,
                                                      hint: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 10),
                                                        child: CustomText(
                                                            text: 'Court Type',
                                                            color: dark
                                                                .withOpacity(
                                                                    .8)),
                                                      ),
                                                    ),
                                                  ),
                                                )),
                                          ],
                                        );
                                      }
                                    },
                                  )),
                              Flexible(
                                  flex: 1,
                                  child: StreamBuilder<QuerySnapshot>(
                                    stream: addcasedetails
                                        .where('type', isEqualTo: "court")
                                        .snapshots(),
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
                                      } else {
                                        List<DropdownMenuItem> caseItems = [];
                                        for (int i = 0;
                                            i < snapshot.data.docs.length;
                                            i++) {
                                          DocumentSnapshot snap =
                                              snapshot.data.docs[i];
                                          caseItems.add(DropdownMenuItem(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: Text(
                                                snap['title'],
                                                style: const TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ),
                                            value: "${snap['title']}",
                                          ));
                                        }
                                        caseItems.add(DropdownMenuItem(
                                          enabled: false,
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: ElevatedButton(
                                                onPressed: () async {
                                                  await showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return StatefulBuilder(
                                                            builder: (context,
                                                                setState) {
                                                          return AlertDialog(
                                                            content: myskillss(
                                                                "Court"),
                                                            actions: <Widget>[
                                                              mypresswidget(
                                                                  "court",
                                                                  context),
                                                            ],
                                                          );
                                                        });
                                                      });
                                                },
                                                child: const CustomText(
                                                  color: legistwhitefont,
                                                  text: "Add Court",
                                                ),
                                              )),
                                          value: "",
                                        ));
                                        return Row(
                                          children: <Widget>[
                                            Flexible(
                                                flex: 1,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child:
                                                      DropdownButtonHideUnderline(
                                                    child: DropdownButton2(
                                                      buttonDecoration:
                                                          BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        border: Border.all(
                                                          color: lightGrey,
                                                        ),
                                                        color:
                                                            Colors.transparent,
                                                      ),
                                                      items: caseItems,
                                                      onChanged: (clientValue) {
                                                        setState(() {
                                                          court = clientValue;
                                                        });
                                                      },
                                                      value: court,
                                                      isExpanded: true,
                                                      hint: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 10),
                                                        child: CustomText(
                                                            text: 'Court',
                                                            color: dark
                                                                .withOpacity(
                                                                    .8)),
                                                      ),
                                                    ),
                                                  ),
                                                )),
                                          ],
                                        );
                                      }
                                    },
                                  )),
                            ],
                          ),
                          Row(
                            children: [
                              Flexible(
                                  flex: 1,
                                  child: StreamBuilder<QuerySnapshot>(
                                    stream: addcasedetails
                                        .where('type', isEqualTo: "judgetype")
                                        .snapshots(),
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
                                      } else {
                                        List<DropdownMenuItem> caseItems = [];
                                        for (int i = 0;
                                            i < snapshot.data.docs.length;
                                            i++) {
                                          DocumentSnapshot snap =
                                              snapshot.data.docs[i];
                                          caseItems.add(DropdownMenuItem(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: Text(
                                                snap['title'],
                                                style: const TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ),
                                            value: "${snap['title']}",
                                          ));
                                        }
                                        caseItems.add(DropdownMenuItem(
                                          enabled: false,
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: ElevatedButton(
                                                onPressed: () async {
                                                  await showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return StatefulBuilder(
                                                            builder: (context,
                                                                setState) {
                                                          return AlertDialog(
                                                            content: myskillss(
                                                                "Judge Type"),
                                                            actions: <Widget>[
                                                              mypresswidget(
                                                                  "judgetype",
                                                                  context),
                                                            ],
                                                          );
                                                        });
                                                      });
                                                },
                                                child: const CustomText(
                                                  color: legistwhitefont,
                                                  text: "Add Judge Type",
                                                ),
                                              )),
                                          value: "",
                                        ));
                                        return Row(
                                          children: <Widget>[
                                            Flexible(
                                                flex: 1,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child:
                                                      DropdownButtonHideUnderline(
                                                    child: DropdownButton2(
                                                      buttonDecoration:
                                                          BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        border: Border.all(
                                                          color: lightGrey,
                                                        ),
                                                        color:
                                                            Colors.transparent,
                                                      ),
                                                      items: caseItems,
                                                      onChanged: (clientValue) {
                                                        setState(() {
                                                          jdgtype = clientValue;
                                                        });
                                                      },
                                                      value: jdgtype,
                                                      isExpanded: true,
                                                      hint: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 10),
                                                        child: CustomText(
                                                            text: 'Judge Type',
                                                            color: dark
                                                                .withOpacity(
                                                                    .8)),
                                                      ),
                                                    ),
                                                  ),
                                                )),
                                          ],
                                        );
                                      }
                                    },
                                  )),
                              Flexible(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: TextField(
                                      decoration: InputDecoration(
                                          labelText: "Judge Name",
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10))),
                                      onChanged: (value) {
                                        jdgname = value;
                                      },
                                    ),
                                  )),
                            ],
                          ),
                          Row(
                            children: [
                              Flexible(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: TextField(
                                      decoration: InputDecoration(
                                          labelText: "Remarks",
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10))),
                                      onChanged: (value) {
                                        remarks = value;
                                      },
                                    ),
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Creating new Case in database...'),
                          ));

                          //FirebaseApi.uploadFolder(casename);

                          cases
                              .add({
                                'clientname': selectedClient ?? "",
                                'respondantname': respondantname ?? "",
                                'respondantadv': respondantadv ?? "",
                                'casenumber': casenumber ?? "",
                                'casename': casename ?? "",
                                'casedesp': casedesp ?? "",
                                'casetypes': casetypes ?? "",
                                'casesubtypes': casesubtypes ?? "",
                                'stageofcase': stageofcase ?? "",
                                'acts': acts ?? "",
                                'firsthearingdt': firsthearingdt ?? "",
                                'filinnumber': filinnumber ?? "",
                                'filingdate': filingdate ?? "",
                                'regnum': regnum ?? "",
                                'regdate': regdate ?? "",
                                'cnrnumber': cnrnumber ?? "",
                                'casedescription': casedescription ?? "",
                                'courtnum': courtnum ?? "",
                                'courttype': courttype ?? "",
                                'court': court ?? "",
                                'jdgtype': jdgtype ?? "",
                                'jdgname': jdgname ?? "",
                                'remarks': remarks ?? "",
                                'usrassign': selectedClient2 ?? "",
                              })
                              .then((value) {})
                              .catchError((error) =>
                                  print('Failed to create new client: $error'));

                          createemptyfolder(casenumber);
                          addfolderinfo(casenumber);

                          tasks
                              .doc(casenumber)
                              .set({
                                'case': casename,
                                'num': casenumber,
                                'inprogress': 0,
                                'todo': 0,
                                'completed': 0,
                              })
                              .then((value) {})
                              .catchError((error) =>
                                  print('Failed to create task: $error'));

                          cleartexts();
                        },
                        child: const Text('Submit'),
                      ),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void addfolderinfo(String foldername) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(widget.appState.myid)
        .collection('folders')
        .add({
          'foldernam': foldername,
          'datecreated': DateTime.now().millisecondsSinceEpoch,
        })
        .then((value) {})
        .catchError((error) => print('Failed to create new client: $error'));
  }

  static UploadTask createemptyfolder(String folderName) {
    try {
      final ref =
          FirebaseStorage.instance.ref('files/${Constants.myID}/$folderName');

      return ref.child('README.txt').putString("""
\t<<< This is an auto-generated file for the folder name, $folderName >>>\n
< It's not advised to delete/modify this file as that'd lead to the folder being removed permanently.>\n
""");
    } on FirebaseException {
      return null;
    }
  }

  void getRelatedTasks(String clientname) async {
    QuerySnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.appState.myid)
        .collection('clients')
        .get();

    for (var document in snap.docs) {
      if (clientname == document['firstname']) {
        setState(() {
          clientuserid = document["userid2"];
        });
      }
    }
  }

  Widget myskillss(String title) {
    return Form(
        //key: _formKey,
        child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: "Add $title",
          weight: FontWeight.bold,
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: _titleController,
          validator: (value) {
            return value.isNotEmpty ? null : "Invalid Field";
          },
          decoration: InputDecoration(hintText: "Enter Notes"),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    ));
  }

  Widget mypresswidget(String title, BuildContext context) {
    return TextButton(
      child: Text('Okay'),
      onPressed: () {
        if (_titleController.text.isNotEmpty) {
          addcasedetails
              .add({
                'title': "${_titleController.text.toString()}",
                'type': title,
              })
              .then((value) => print('Notes added successfully'))
              .catchError(
                  (error) => print('Failed to create new Notes: $error'));
          Navigator.pop(context);
          _titleController.text = "";
          return;
        }
      },
    );
  }

  Widget dropdowndatabaseref(
      BuildContext _context,
      Stream<QuerySnapshot<Object>> stream,
      String snapshotname,
      String mydata) {
    return StreamBuilder<QuerySnapshot>(
      stream: stream,
      builder: (
        _context,
        AsyncSnapshot<QuerySnapshot> snapshot,
      ) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        } else {
          List<DropdownMenuItem> currencyItems = [];
          for (int i = 0; i < snapshot.data.docs.length; i++) {
            DocumentSnapshot snap = snapshot.data.docs[i];
            currencyItems.add(DropdownMenuItem(
              child: Text(
                snap[snapshotname],
                style: const TextStyle(color: Colors.black),
              ),
              value: "${snap[snapshotname]}",
            ));
          }
          return Row(
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: DropdownButton(
                      items: currencyItems,
                      onChanged: (ClientValue) {
                        setState(() {
                          mytemp = ClientValue;
                          mydata = ClientValue;
                        });
                      },
                      value: mydata,
                      isExpanded: true,
                      hint: const Text(
                        'Choose User',
                        style: TextStyle(color: Colors.black),
                      ),
                    )),
              ),
            ],
          );
        }
      },
    );
  }

  Widget getcurrentnum() {
    return StreamBuilder<QuerySnapshot>(
        stream: currcases,
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
            child: _case1(getcasenum(data.size)),
          );
        });
  }

  Widget _case1(String casenum) {
    return Text(
      casenum,
      style: TextStyle(color: Colors.black, fontSize: 15),
    );
  }

  String getcasenum(int num) {
    if (num.toString().length == 1) {
      casenumber =
          "case000${num}_${DateFormat("ddMMyy").format(DateTime.now()).toString()}";
      return casenumber;
    } else if (num.toString().length == 2) {
      casenumber =
          "case00${num}_${DateFormat("ddMMyy").format(DateTime.now()).toString()}";
      return casenumber;
    } else if (num.toString().length == 3) {
      casenumber =
          "case0${num}_${DateFormat("ddMMyy").format(DateTime.now()).toString()}";
      return casenumber;
    } else if (num.toString().length == 1) {
      casenumber =
          "case${num}_${DateFormat("ddMMyy").format(DateTime.now()).toString()}";
      return casenumber;
    } else {
      return "loading";
    }
  }

  void setcasenum(String casenum) {
    casenumber = casenum;
  }

  void cleartexts() {
    _formKey.currentState?.reset();
    setState(() {
      selectedClient = null;
      stageofcase = null;
      casetypes = null;
      casename = "";
      filinnumber = "";
      regnum = "";
      jdgname = "";
      remarks = "";
      courtnum = "";
      casedescription = "";
      casesubtypes = null;
      acts = null;
      firsthearingdt = "";
      filingdate = "";
      regdate = "";
      courttype = null;
      court = null;
      jdgtype = null;
    });
  }

  Widget mytaskassignee() {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Container(
                padding: const EdgeInsets.all(16),
                child: const Text(
                  'Task Assign',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ))
          ],
        ),
        const Divider(
          height: 10,
          thickness: 1.0,
          indent: 20,
          endIndent: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: StreamBuilder<QuerySnapshot>(
            stream: users,
            builder: (
              _context,
              AsyncSnapshot<QuerySnapshot> snapshot,
            ) {
              if (!snapshot.hasData) {
                return const CircularProgressIndicator();
              } else {
                List<DropdownMenuItem> currencyItems = [];
                for (int i = 0; i < snapshot.data.docs.length; i++) {
                  DocumentSnapshot snap = snapshot.data.docs[i];
                  currencyItems.add(DropdownMenuItem(
                    child: Text(
                      snap["userName"],
                      style: const TextStyle(color: Colors.black),
                    ),
                    value: "${snap["userName"]}",
                  ));
                }
                return Row(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: DropdownButton(
                            items: currencyItems,
                            onChanged: (ClientValue) {
                              setState(() {
                                selectedClient2 = ClientValue;
                              });
                              print('$ClientValue');
                            },
                            value: selectedClient2,
                            isExpanded: true,
                            hint: const Text(
                              'Choose User',
                              style: TextStyle(color: Colors.black),
                            ),
                          )),
                    ),
                  ],
                );
              }
            },
          ),
        )
        /*Row(
                          children: [
                            Flexible(
                                flex: 1,
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: TextField(
                                    decoration: InputDecoration(
                                        labelText: "User Assigned",
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                    onChanged: (value) {
                                      usrassign = value;
                                    },
                                  ),
                                )),
                          ],
                        ),*/
      ],
    );
  }
}
