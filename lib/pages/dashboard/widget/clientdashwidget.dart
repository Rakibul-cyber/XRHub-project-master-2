import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:urlnav2/appState.dart';
import 'package:urlnav2/constants/custom_text.dart';
import 'package:urlnav2/constants/style.dart';
import 'package:urlnav2/pages/files/components/custom_icons.dart';
import 'package:intl/intl.dart';

class ClientWidgetDash extends StatefulWidget {
  final AppState appState;
  ClientWidgetDash({Key key, this.appState}) : super(key: key);

  @override
  State<ClientWidgetDash> createState() => _ClientWidgetDashState();
}

class _ClientWidgetDashState extends State<ClientWidgetDash> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(widget.appState.myid)
            .collection('clients')
            .snapshots(),
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

          return Container(
            height: 300,
            padding: const EdgeInsets.all(paddingMid),
            decoration: BoxDecoration(
                color: legistwhite,
                border: Border.all(color: lightGrey, width: .5),
                borderRadius: BorderRadius.circular(space_20)),
            child: DataTable2(
                columnSpacing: 12,
                horizontalMargin: 12,
                minWidth: 600,
                columns: const [
                  DataColumn2(
                    label: CustomText(
                      text: "Name",
                      color: grey,
                    ),
                    size: ColumnSize.L,
                  ),
                  DataColumn(
                    label: CustomText(
                      text: "Email",
                      color: grey,
                    ),
                  ),
                  DataColumn(
                    label: CustomText(
                      text: "Mobile Number",
                      color: grey,
                    ),
                  ),
                  DataColumn(
                    label: CustomText(
                      text: "Alternate Number",
                      color: grey,
                    ),
                  ),
                ],
                rows: List<DataRow>.generate(
                    data.size,
                    (index) => DataRow(cells: [
                          DataCell(
                            CustomText(
                              text: data.docs[index]['firstname'],
                              size: 12,
                            ),
                          ),
                          DataCell(CustomText(
                              text: data.docs[index]['email'], size: 12)),
                          DataCell(CustomText(
                              text: data.docs[index]['mobilenum'], size: 12)),
                          DataCell(CustomText(
                              text: data.docs[index]['altnum'], size: 12)),
                        ]))),
          );
        });
  }

  Widget myfiletype(String type, double size) {
    switch (type) {
      case ("txt"):
        return Icon(
          CustomIcons.doc_text_inv,
          color: Colors.blue,
          size: size,
        );
      case ("png"):
        return Icon(
          Icons.image,
          color: Colors.amber,
          size: size,
        );
      case ("jpeg"):
        return Icon(
          Icons.image,
          color: Colors.amber,
          size: size,
        );
      case ("pdf"):
        return Icon(
          Icons.picture_as_pdf,
          color: Colors.red,
          size: size,
        );
      case ("mp4"):
        return Icon(
          Icons.video_collection,
          color: Colors.orange,
          size: size,
        );
      case ("mp3"):
        return Icon(
          CustomIcons.music,
          color: Colors.pink,
          size: size,
        );

      default:
        return Icon(
          CustomIcons.doc_text_inv,
          color: Colors.green,
          size: size,
        );
    }
  }

  String epochtodate(int epochdate) {
    DateTime date1 = DateTime.fromMillisecondsSinceEpoch(epochdate);
    return DateFormat('EEE, d/M/y').format(date1).toString();
  }
}
