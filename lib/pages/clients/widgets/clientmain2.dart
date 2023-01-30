import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:urlnav2/appState.dart';
import 'package:urlnav2/constants/custom_text.dart';
import 'package:urlnav2/constants/myconstants.dart';
import 'package:urlnav2/constants/style.dart';
import 'package:urlnav2/helpers/reponsiveness.dart';
import 'package:urlnav2/pages/clients/widgets/clients_new_form2.dart';
import 'package:urlnav2/pages/clients/widgets/reflist.dart';

class ClientPageMain2 extends StatefulWidget {
  final QuerySnapshot<Object> data;
  final String myID;
  final AppState appState;
  const ClientPageMain2(this.data, this.myID, this.appState);

  @override
  _ClientPageMain2State createState() => _ClientPageMain2State();
}

class _ClientPageMain2State extends State<ClientPageMain2> {
  TextEditingController clientSearchController = new TextEditingController();
  int myindex = 0;
  double gapnumber = 20.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    clientSearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Container(
                margin: ResponsiveWidget.isSmallScreen(context)
                    ? const EdgeInsets.all(10)
                    : const EdgeInsets.all(20),
                /*decoration: BoxDecoration(
                  color: legistwhite,
                  border: Border.all(color: lightGrey, width: .5),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 6), color: lightGrey, blurRadius: 12)
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),*/
                child: Row(
                  children: [
                    Flexible(
                        flex: ResponsiveWidget.isLargeScreen(context) ? 1 : 2,
                        child: Column(
                          children: [
                            clientsearch(),
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: clientRoomsListmain(),
                            ))
                          ],
                        )),
                    if (!ResponsiveWidget.isSmallScreen(context)) ...[
                      Container(
                        width: 0.5,
                        color: lightGrey,
                      ),
                      Flexible(flex: 4, child: getuserinfo(myindex)),
                    ]
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          backgroundColor: Colors.blue,
          onPressed: () {
            sideMenuController.changeActiveItemTo("NewClients");
            widget.appState.selectedIndex = 6;
          }),
    );
  }

  Widget clientsearch() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                  padding: EdgeInsets.all(2),
                  margin: EdgeInsets.all(2),
                  child: CustomText(
                    text: "Clients",
                    color: dark,
                    weight: FontWeight.bold,
                  )),
              Expanded(child: Container()),
              Icon(
                Icons.menu,
                color: dark,
              )
            ],
          ),
          Container(
            padding: const EdgeInsets.all(5),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
              decoration: BoxDecoration(
                border: Border.all(color: lightGrey, width: .5),
                color: light,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.search,
                    color: lightGrey,
                  ),
                  Expanded(
                    child: TextField(
                      controller: clientSearchController,
                      style: TextStyle(color: lightGrey, fontSize: 15),
                      decoration: InputDecoration(
                          hintText: "Search clients",
                          hintStyle: TextStyle(
                            color: lightGrey,
                            fontSize: 15,
                          ),
                          border: InputBorder.none),
                    ),
                  )
                ],
              ),
            ),
          ),
          Divider(
            height: 10,
            thickness: 1.0,
            indent: 5,
            endIndent: 5,
          )
        ],
      ),
    );
  }

  Widget clientRoomsListmain() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 12),
      child: clientRoomsList(),
    );
  }

  Widget clientRoomsList() {
    if (widget.data.docs.isEmpty) {
      return CustomText(
        text: "Please Add a Client",
        weight: FontWeight.bold,
        size: 14,
      );
    } else {
      return ListView.builder(
          itemCount: widget.data.docs.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return clientRoomsTile(index);
          });
    }
  }

  Widget clientRoomsTile(int index) {
    return InkWell(
      onTap: () {
        if (ResponsiveWidget.isSmallScreen(context)) {
        } else {
          setState(() {
            myindex = index;
          });
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      color: legistblue,
                      borderRadius: BorderRadius.circular(30)),
                  child: Text(
                      widget.data.docs[index]['firstname']
                          .substring(0, 1)
                          .toUpperCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'OverpassRegular',
                          fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  width: 12,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.data.docs[index]['firstname'],
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: dark,
                            fontSize: 16,
                            fontFamily: 'OverpassRegular',
                            fontWeight: FontWeight.w500)),
                    SizedBox(
                      height: gapnumber,
                    ),
                    Text(widget.data.docs[index]['email'],
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: grey,
                            fontSize: 14,
                            fontFamily: 'OverpassRegular',
                            fontWeight: FontWeight.w100)),
                  ],
                )
              ],
            ),
            SizedBox(
              height: gapnumber,
            ),
            Divider(
              height: 10,
              thickness: 1.0,
              indent: 5,
              endIndent: 5,
            )
          ],
        ),
      ),
    );
  }

  Widget getuserinfo(int index) {
    if (widget.data.docs.isNotEmpty) {
      return myclient(context, index);
    } else {
      return Center(
        child: Container(
          decoration: BoxDecoration(
            color: legistwhite,
          ),
          child: ElevatedButton(
            onPressed: () {
              sideMenuController.changeActiveItemTo("NewClients");
              widget.appState.selectedIndex = 6;
              //Navigator.push(context,
              //   MaterialPageRoute(builder: (context) => ClientsForm()));
            },
            child: Text("Add New Client"),
          ),
        ),
      );
    }
  }

  Widget myclient(BuildContext context, index) {
    return ListView(
      children: [
        ListTile(
          leading: Container(
            alignment: Alignment.center,
            height: 30,
            width: 30,
            decoration: BoxDecoration(
                color: legistblue, borderRadius: BorderRadius.circular(30)),
            child: Text(
                widget.data.docs[index]['firstname']
                    .substring(0, 1)
                    .toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'OverpassRegular',
                    fontWeight: FontWeight.bold)),
          ),
          title: CustomText(
              text:
                  "${widget.data.docs[index]['firstname']} ${isnowcompany(widget.data.docs[index]['iscompany'])}",
              size: 20,
              color: legistblackfont,
              weight: FontWeight.bold),
          subtitle: CustomText(
              text: "${widget.data.docs[index]['email']}",
              size: 20,
              color: grey,
              weight: FontWeight.w200),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 68),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomText(text: "Edit"),
              const SizedBox(
                height: 10,
                child: VerticalDivider(
                  color: Colors.blue,
                  thickness: 1,
                  width: 10,
                ),
              ),
              InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: CustomText(text: "Alert"),
                          content: CustomText(
                              text: "Would you like to delete this client ?"),
                          actions: <Widget>[
                            ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.blue)),
                              child: CustomText(text: "Continue"),
                              onPressed: () {
                                //deleteUser();
                              },
                            )
                          ],
                        );
                      });
                },
                child: CustomText(text: "Delete"),
              ),
              const SizedBox(
                height: 10,
                child: VerticalDivider(
                  color: Colors.blue,
                  thickness: 1,
                  width: 10,
                ),
              ),
              InkWell(
                onTap: () {
                  sideMenuController.changeActiveItemTo("Chats");
                  widget.appState.selectedIndex = 14;
                },
                child: CustomText(text: "Message"),
              ),
            ],
          ),
        ),
        const Divider(
          height: 20,
          thickness: 0.5,
          color: lightGrey,
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            children: [
              widget.data.docs[index]['iscompany']
                  ? Container(
                      child: CompDetails(
                        clientID: widget.data.docs[index]['userid'],
                        myID: widget.myID,
                        gapnumber: gapnumber,
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                            text: "General Details", weight: FontWeight.bold),
                      ],
                    ),
              SizedBox(
                height: gapnumber,
              ),
              SizedBox(height: gapnumber),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  customText2(
                    "First Name",
                  ),
                  customText3(
                    widget.data.docs[index]['firstname'],
                  ),
                ],
              ),
              SizedBox(height: gapnumber),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  customText2(
                    "Username",
                  ),
                  customText3(
                    widget.data.docs[index]['username'],
                  ),
                ],
              ),
              SizedBox(height: gapnumber),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  customText2(
                    "Mobile Number",
                  ),
                  customText3(
                    widget.data.docs[index]['mobilenum'],
                  ),
                ],
              ),
              SizedBox(height: gapnumber),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  customText2(
                    "Gender",
                  ),
                  customText3(
                    widget.data.docs[index]['gender'].toString(),
                  ),
                ],
              ),
              SizedBox(height: gapnumber),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  customText2(
                    "Alternative Mobile No",
                  ),
                  customText3(
                    widget.data.docs[index]['altnum'].toString(),
                  ),
                ],
              ),
              SizedBox(height: gapnumber),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  customText2(
                    "Address",
                  ),
                  customText3(
                    widget.data.docs[index]['address'].toString(),
                  ),
                ],
              ),
              SizedBox(height: gapnumber),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  customText2(
                    "Postcode",
                  ),
                  customText3(
                    widget.data.docs[index]['postcode'].toString(),
                  ),
                ],
              ),
              SizedBox(height: gapnumber),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  customText2(
                    "City",
                  ),
                  customText3(
                    widget.data.docs[index]['city'],
                  ),
                ],
              ),
              SizedBox(height: gapnumber),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  customText2(
                    "State",
                  ),
                  customText3(
                    widget.data.docs[index]['state'],
                  ),
                ],
              ),
              SizedBox(height: gapnumber),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  customText2(
                    "Country",
                  ),
                  customText3(
                    widget.data.docs[index]['country'],
                  ),
                ],
              ),
              SizedBox(height: gapnumber),
              Container(
                child: Reflist(
                  clientID: widget.data.docs[index]['userid'],
                  myID: widget.myID,
                  gapnumber: gapnumber,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  String isnowcompany(bool iscompany) {
    if (iscompany) {
      return "(Company)";
    } else {
      return "(Individual)";
    }
  }

  Widget customText2(String mystring) {
    return CustomText(
      text: mystring,
      color: grey,
      weight: FontWeight.w600,
      size: 15,
    );
  }

  Widget customText3(String mystring) {
    return CustomText(
      text: mystring,
      color: legistblue,
      weight: FontWeight.w600,
      size: 15,
    );
  }
}

class CompDetails extends StatefulWidget {
  final String myID;
  final String clientID;
  final double gapnumber;
  const CompDetails({Key key, this.myID, this.clientID, this.gapnumber})
      : super(key: key);
  @override
  State<CompDetails> createState() => _CompDetailsState();
}

class _CompDetailsState extends State<CompDetails> {
  @override
  Widget build(BuildContext context) {
    return compdetail();
  }

  Widget compdetail() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(widget.myID)
            .collection('clients')
            .doc(widget.clientID)
            .collection('companydetails')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          if (snapshot.data.docs.isEmpty) {
            return const CircularProgressIndicator();
          }

          return ListView.builder(
              itemCount: snapshot.data.docs.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return compTile(
                    snapshot.data.docs[index]['companyname'],
                    snapshot.data.docs[index]['companyregnum'],
                    snapshot.data.docs[index]['companyphnnum'],
                    snapshot.data.docs[index]['companyfax']);
              });
        });
  }

  Widget compTile(
      String refname, String refnum, String refemail, String refaddress) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomText(text: "Company Details", weight: FontWeight.bold),
          ],
        ),
        SizedBox(
          height: widget.gapnumber,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            customText2(
              "Company Name",
            ),
            customText3(
              refname,
            ),
          ],
        ),
        SizedBox(
          height: widget.gapnumber,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            customText2(
              "Registeration Number",
            ),
            customText3(
              refnum,
            ),
          ],
        ),
        SizedBox(
          height: widget.gapnumber,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            customText2(
              "Contact Number",
            ),
            customText3(
              refemail,
            ),
          ],
        ),
        SizedBox(
          height: widget.gapnumber,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            customText2(
              "Fax Number",
            ),
            customText3(
              refaddress,
            ),
          ],
        ),
        SizedBox(
          height: widget.gapnumber,
        ),
        Divider(
          height: 10,
          thickness: 1.0,
          indent: 5,
          endIndent: 5,
        ),
        SizedBox(
          height: widget.gapnumber,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomText(text: "Person In Charge", weight: FontWeight.bold),
          ],
        ),
      ],
    );
  }

  Widget customText2(String mystring) {
    return CustomText(
      text: mystring,
      color: grey,
      weight: FontWeight.w600,
      size: 15,
    );
  }

  Widget customText3(String mystring) {
    return CustomText(
      text: mystring,
      color: legistblue,
      weight: FontWeight.w600,
      size: 15,
    );
  }
}
