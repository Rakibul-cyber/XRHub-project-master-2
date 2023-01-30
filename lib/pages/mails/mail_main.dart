import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:urlnav2/appState.dart';
import 'package:urlnav2/pages/mails/mailing.dart';

class MailPage extends StatelessWidget {
  final AppState appState;
  MailPage({Key key, this.appState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> emails = FirebaseFirestore.instance
        .collection('users')
        .doc(appState.myid)
        .collection('emails')
        .snapshots();
    return StreamBuilder<QuerySnapshot>(
        stream: emails,
        builder: (
          BuildContext context,
          AsyncSnapshot<QuerySnapshot> snapshot,
        ) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading..');
          }
          final data = snapshot.requireData;
          return Container(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    child: MailScreen2(
                      data: data,
                      appState: appState,
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
