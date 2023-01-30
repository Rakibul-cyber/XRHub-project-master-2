import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:urlnav2/constants/custom_text.dart';
import 'package:urlnav2/constants/style.dart';
import 'package:urlnav2/pages/calendar/eventClient.dart';
import 'package:urlnav2/pages/notes/notecase.dart';

class NoteCaseList extends StatefulWidget {
  final QuerySnapshot data;
  final int index;
  final NoteCase casename;
  NoteCaseList({Key key, this.data, this.index, this.casename})
      : super(key: key);

  @override
  State<NoteCaseList> createState() => _NoteCaseListState();
}

class _NoteCaseListState extends State<NoteCaseList> {
  bool isselect = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() => isselect = true);
        widget.casename.setmyName = widget.data.docs[widget.index]['casename'];
      },
      child: ListTile(
        title: Column(
          children: [
            CustomText(
              text: widget.data.docs[widget.index]['casename'],
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
