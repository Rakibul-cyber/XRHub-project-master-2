import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:urlnav2/appState.dart';
import 'package:urlnav2/helpers/helperfunctions.dart';
import 'package:urlnav2/layout/constants/constants.dart';
import 'package:urlnav2/pages/clients/widgets/clientmain2.dart';

class ClientPageNew extends StatefulWidget {
  final AppState appState;
  const ClientPageNew({Key key, this.appState}) : super(key: key);
  @override
  _ClientPageNew createState() => _ClientPageNew();
}

class _ClientPageNew extends State<ClientPageNew> {
  Stream<QuerySnapshot> users;
  String myID;
  @override
  void initState() {
    super.initState();
    myID = widget.appState.myid;
    users = FirebaseFirestore.instance
        .collection('users')
        .doc(myID)
        .collection('clients')
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

                  return ClientPageMain2(data, myID, widget.appState);
                }),
          )),
        ],
      ),
    );
  }
}
