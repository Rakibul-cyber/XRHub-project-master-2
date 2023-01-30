import 'package:flutter/material.dart';
import 'package:urlnav2/constants/custom_text.dart';
import 'package:urlnav2/constants/style.dart';

class DashboardMemoWidget extends StatelessWidget {
  final String caseName;
  final String memo;

  const DashboardMemoWidget(
      {Key key, @required this.caseName, @required this.memo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(space_20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.amber),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            CustomText(
              text: caseName,
              color: dark,
              size: fontSub,
              weight: FontWeight.bold,
            ),
            y5,
            CustomText(
              text: memo,
              color: dark,
              size: fontBody,
            ),
          ]),
        ),
        y10
      ],
    );
  }
}
