import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:urlnav2/appState.dart';
import 'package:urlnav2/constants/custom_text.dart';
import 'package:urlnav2/constants/style.dart';
import 'package:urlnav2/helpers/helperfunctions.dart';
import 'package:urlnav2/helpers/reponsiveness.dart';
import 'package:urlnav2/layout/constants/constants.dart';

class Getcasenumber extends StatefulWidget {
  final AppState appState;
  const Getcasenumber({Key key, this.appState}) : super(key: key);
  @override
  _Getcasenumber createState() => _Getcasenumber();
}

class _Getcasenumber extends State<Getcasenumber> {
  Stream<QuerySnapshot> mydetails;

  @override
  void initState() {
    super.initState();
    mydetails = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.appState.myid)
        .collection('cases')
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
              text: "0",
            );
          }

          return CustomText(
            talign: TextAlign.center,
            text: "${snapshot.data.size}",
            color: lightGrey,
          );
        });
  }
}
