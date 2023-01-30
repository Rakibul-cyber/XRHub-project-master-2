import 'package:flutter/material.dart';
import 'package:urlnav2/constants/custom_text.dart';

class RecordsMain extends StatefulWidget {
  RecordsMain({Key key}) : super(key: key);

  @override
  State<RecordsMain> createState() => _RecordsMainState();
}

class _RecordsMainState extends State<RecordsMain> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomText(
        text: "RECORDS",
      ),
    );
  }
}
