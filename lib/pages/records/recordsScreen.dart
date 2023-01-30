import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:urlnav2/appState.dart';
import 'package:urlnav2/pages/records/widgets/recorddash.dart';
import 'package:urlnav2/pages/records/widgets/recordsboxpage.dart';
import 'package:urlnav2/pages/records/widgets/selectedrecordstate.dart';

class RecordPage extends StatefulWidget {
  final AppState appState;
  final SelectedRecordState selectedRecordState;

  const RecordPage({Key key, this.appState, this.selectedRecordState})
      : super(key: key);
  @override
  _RecordPage createState() => _RecordPage();
}

class _RecordPage extends State<RecordPage> {
  Stream<QuerySnapshot> users;
  String myID;
  @override
  void initState() {
    super.initState();
    myID = widget.appState.myid;
    users = FirebaseFirestore.instance
        .collection('users')
        .doc(myID)
        .collection('records')
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
                    return Center(child: CircularProgressIndicator());
                  }
                  final data = snapshot.requireData;

                  //return RecordBoxScreen();
//TODO
                  return RecordsDashboard(
                    data: data,
                    appState: widget.appState,
                    selectedRecordState: widget.selectedRecordState,
                  );
                }),
          )),
        ],
      ),
    );
  }
}
