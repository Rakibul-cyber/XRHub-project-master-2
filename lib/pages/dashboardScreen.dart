import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:urlnav2/constants/custom_text.dart';
import 'package:urlnav2/constants/style.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({Key key}) : super(key: key);
  final Stream refstream =
      FirebaseFirestore.instance.collection('cases').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: refstream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          return ListView.builder(
              itemCount: snapshot.data.docs.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return RefTile(
                  snapshot.data.docs[index]['acts'],
                );
              });
        },
      ),
    );
  }

  Widget RefTile(String myact) {
    return CustomText(
      text: myact,
    );
  }
}
