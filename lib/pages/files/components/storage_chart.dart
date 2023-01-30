import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:urlnav2/constants/custom_text.dart';
import 'package:urlnav2/constants/style.dart';
import 'package:urlnav2/pages/files/components/usage.dart';

class StorageChart extends StatelessWidget {
  const StorageChart({
    this.usage,
    this.radius = 200,
    Key key,
  }) : super(key: key);

  final Usage usage;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // chart
        CircularPercentIndicator(
          radius: radius,
          lineWidth: 25,
          animation: true,
          percent: getUsedPercent() / 100,
          center: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _percentText(),
              CustomText(text: "used"),
            ],
          ),
          circularStrokeCap: CircularStrokeCap.round,
          progressColor: Theme.of(context).primaryColor,
          backgroundColor: Colors.grey[300],
        ),

        y20,

        // usage information
        Row(
          children: [
            Spacer(),
            Flexible(
              flex: 4,
              child: _indicatorUsage(
                color: Colors.grey[300],
                title: "${usage.totalFree}GB",
                subtitle: "free",
              ),
            ),
            Flexible(
              flex: 4,
              child: _indicatorUsage(
                color: Theme.of(context).primaryColor,
                title: "${usage.totalUsed}GB",
                subtitle: "used",
              ),
            ),
            Spacer(),
          ],
        )
      ],
    );
  }

  Widget _percentText() {
    return Text(
      "${getUsedPercent().toInt()}%",
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.w600,
        color: legistblue,
      ),
    );
  }

  Widget _indicatorUsage({
    @required Color color,
    @required String title,
    @required String subtitle,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: color,
          radius: 8,
        ),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            CustomText(
              text: subtitle,
            ),
          ],
        )
      ],
    );
  }

  double getUsedPercent() {
    int _maxStorage = usage.totalFree + usage.totalUsed;
    return (usage.totalUsed / _maxStorage) * 100;
  }
}
