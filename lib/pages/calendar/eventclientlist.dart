import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:urlnav2/constants/custom_text.dart';
import 'package:urlnav2/constants/style.dart';
import 'package:urlnav2/pages/calendar/eventClient.dart';

class EventClientList extends StatefulWidget {
  final QuerySnapshot data;
  final int index;
  final EventClient clientname;
  EventClientList({Key key, this.data, this.index, this.clientname})
      : super(key: key);

  @override
  State<EventClientList> createState() => _EventClientListState();
}

class _EventClientListState extends State<EventClientList> {
  bool isselect = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() => isselect = true);
        widget.clientname.setmyName =
            widget.data.docs[widget.index]['firstname'];
      },
      child: ListTile(
        title: Column(
          children: [
            CustomText(
              text: widget.data.docs[widget.index]['firstname'],
            ),
            SizedBox(
              child: Divider(
                height: 0.5,
                color: lightGrey,
                indent: 10,
                endIndent: 10,
              ),
              height: 10,
            ),
          ],
        ),
        trailing: isselect
            ? Icon(Icons.check_circle_outline_outlined)
            : Icon(Icons.circle_outlined),
      ),
    );
  }
}
