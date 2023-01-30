import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:urlnav2/constants/custom_text.dart';
import 'package:urlnav2/constants/style.dart';

class Reflist extends StatefulWidget {
  final String myID;
  final String clientID;
  final double gapnumber;
  const Reflist({Key key, this.myID, this.clientID, this.gapnumber})
      : super(key: key);

  @override
  State<Reflist> createState() => _ReflistState();
}

class _ReflistState extends State<Reflist> {
  Stream refstream;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(widget.myID)
          .collection('clients')
          .doc(widget.clientID)
          .collection('references')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (snapshot == null) {
          return const CircularProgressIndicator();
        }
        return ListView.builder(
            itemCount: snapshot.data.docs.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return RefTile(
                  snapshot.data.docs[index]['refname'],
                  snapshot.data.docs[index]['refmobile'],
                  snapshot.data.docs[index]['refemail'],
                  snapshot.data.docs[index]['refaddress'],
                  index);
            });
      },
    );
  }

  Widget RefTile(String refname, String refnum, String refemail,
      String refaddress, int index) {
    return Column(
      children: [
        Divider(
          height: 10,
          thickness: 1.0,
          indent: 5,
          endIndent: 5,
        ),
        SizedBox(
          height: widget.gapnumber,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomText(
                text: "Reference #${index + 1}", weight: FontWeight.bold),
          ],
        ),
        SizedBox(
          height: widget.gapnumber,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            customText2(
              "Reference name",
            ),
            customText3(
              refname,
            ),
          ],
        ),
        SizedBox(
          height: widget.gapnumber,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            customText2(
              "Reference Number",
            ),
            customText3(
              refnum,
            ),
          ],
        ),
        SizedBox(
          height: widget.gapnumber,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            customText2(
              "Reference email",
            ),
            customText3(
              refemail,
            ),
          ],
        ),
        SizedBox(
          height: widget.gapnumber,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            customText2(
              "Reference Address",
            ),
            customText3(
              refaddress,
            ),
          ],
        ),
        SizedBox(
          height: widget.gapnumber,
        ),
        Divider(
          height: 10,
          thickness: 1.0,
          indent: 5,
          endIndent: 5,
        )
      ],
    );
  }

  Widget customText2(String mystring) {
    return CustomText(
      text: mystring,
      color: grey,
      weight: FontWeight.w600,
      size: 15,
    );
  }

  Widget customText3(String mystring) {
    return CustomText(
      text: mystring,
      color: legistblue,
      weight: FontWeight.w600,
      size: 15,
    );
  }
}
