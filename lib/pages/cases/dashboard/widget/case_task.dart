import 'package:flutter/material.dart';
import 'package:urlnav2/constants/custom_text.dart';
import 'package:urlnav2/constants/style.dart';

class CaseTaskWidget extends StatelessWidget {
  final String caseName;
  final String task;

  const CaseTaskWidget({Key key, @required this.caseName, @required this.task})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(space_10),
      decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(space_20),
          border: Border.all(color: lightGrey, width: .5),
          color: silver),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
              text: caseName,
              color: dark,
              size: fontSub,
              weight: FontWeight.bold,
              talign: TextAlign.center),
          y5,
          CustomText(
            text: task,
            color: dark,
            size: fontSub,
          ),
        ],
      ),
    );
  }
}
