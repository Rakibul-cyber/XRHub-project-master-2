import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:urlnav2/appState.dart';
import 'package:urlnav2/constants/custom_text.dart';
import 'package:urlnav2/constants/style.dart';
import 'package:urlnav2/helpers/helperfunctions.dart';
import 'package:urlnav2/helpers/reponsiveness.dart';
import 'package:urlnav2/layout/constants/constants.dart';

class GetExperience extends StatefulWidget {
  final AppState appState;
  const GetExperience({Key key, this.appState}) : super(key: key);
  @override
  _GetExperience createState() => _GetExperience();
}

class _GetExperience extends State<GetExperience> {
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
              text: "0",
            );
          }

          return CustomText(
            talign: TextAlign.center,
            text: "${getexp(snapshot.data.docs[0]["jobstartingdt"])}",
            color: lightGrey,
          );
        });
  }

  int getexp(String startingdt) {
    String year =
        "${startingdt[(startingdt.length - 4)]}${startingdt[(startingdt.length - 3)]}${startingdt[(startingdt.length - 2)]}${startingdt[startingdt.length - 1]}";

    return DateTime.now().year - int.parse(year);
  }
}
