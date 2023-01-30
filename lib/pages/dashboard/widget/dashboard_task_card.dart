import 'package:flutter/material.dart';
import 'package:urlnav2/constants/custom_text.dart';
import 'package:urlnav2/constants/style.dart';

class DashboardTaskCard extends StatelessWidget {
  final String caseName;
  final String task;
  const DashboardTaskCard({Key key, this.caseName, this.task})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(space_10),
      decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(space_20),
          color: backgroundColor),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: caseName,
            color: dark,
            size: fontSub,
            weight: FontWeight.bold,
            talign: TextAlign.center,
          ),
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
