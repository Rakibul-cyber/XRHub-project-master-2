import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:urlnav2/appState.dart';
import 'package:urlnav2/constants/custom_text.dart';
import 'package:urlnav2/constants/style.dart';
import 'package:urlnav2/helpers/helperfunctions.dart';
import 'package:urlnav2/helpers/reponsiveness.dart';
import 'package:urlnav2/layout/constants/constants.dart';

class Getusername extends StatefulWidget {
  final AppState appState;
  const Getusername({Key key, this.appState}) : super(key: key);
  @override
  _Getusername createState() => _Getusername();
}

class _Getusername extends State<Getusername> {
  Stream<QuerySnapshot> mydetails;

  @override
  void initState() {
    super.initState();
    mydetails = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.appState.myid)
        .collection('details')
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return streamprofile();
  }

  Widget streamprofile() {
    return StreamBuilder<QuerySnapshot>(
        stream: mydetails,
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

          if (snapshot.data.docs.isEmpty) {
            return CustomText(
              talign: TextAlign.center,
              color: lightGrey,
              text: "User",
            );
          }

          if (!ResponsiveWidget.isLargeScreen(context)) {
            return CustomText(
              talign: TextAlign.center,
              text: "${snapshot.data.docs[0]["firstname"]}",
              color: lightGrey,
            );
          } else {
            return CustomText(
              talign: TextAlign.center,
              text:
                  "${snapshot.data.docs[0]["firstname"]} ${snapshot.data.docs[0]["lastname"]}",
              color: lightGrey,
            );
          }
        });
  }
}
