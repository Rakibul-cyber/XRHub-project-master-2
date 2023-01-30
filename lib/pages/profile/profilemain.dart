import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:urlnav2/appState.dart';
import 'package:urlnav2/pages/profile/widget/profilepage.dart';

class ProfileMainPage extends StatefulWidget {
  final AppState appState;
  const ProfileMainPage({Key key, this.appState}) : super(key: key);
  @override
  _ProfileMainPage createState() => _ProfileMainPage();
}

class _ProfileMainPage extends State<ProfileMainPage> {
  Stream<QuerySnapshot> users;
  @override
  void initState() {
    super.initState();
    users = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.appState.myid)
        .collection('details')
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
              child: Container(
            child: StreamBuilder<QuerySnapshot>(
                stream: users,
                builder: (
                  BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot,
                ) {
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final data = snapshot.requireData;

                  return ProfilePage(data, widget.appState);
                }),
          )),
        ],
      ),
    );
  }
}
