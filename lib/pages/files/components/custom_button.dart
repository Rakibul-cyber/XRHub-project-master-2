import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urlnav2/constants/custom_text.dart';
import 'package:urlnav2/constants/style.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    @required this.icon,
    @required this.label,
    @required this.onPressed,
    this.color = Colors.blue,
    this.borderRadius,
    this.totalsize,
    Key key,
  }) : super(key: key);

  final IconData icon;
  final Color color;
  final String label;
  final String totalsize;
  final Function() onPressed;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    final _borderRadius = borderRadius ?? BorderRadius.circular(10);

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListTile(
        leading: InkWell(
          onTap: onPressed,
          borderRadius: _borderRadius,
          child: Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: color.withOpacity(.25),
              borderRadius: _borderRadius,
            ),
            padding: const EdgeInsets.all(15),
            child: Icon(
              icon,
              color: color,
              size: 15,
            ),
          ),
        ),
        title: Text(
          label.capitalizeFirst,
          textAlign: TextAlign.start,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: CustomText(
          text: "$totalsize GB",
          weight: FontWeight.w600,
          color: legistblue,
        ),
      ),
    );
  }
}
