import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardFolder extends StatelessWidget {
  const CardFolder({this.label, this.datecreated, this.width, Key key})
      : super(key: key);

  final String label;
  final int datecreated;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      width: width ?? 200,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: .2,
            blurRadius: 5,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: ListView(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.folder_outlined,
                size: 30,
              ),
            ],
          ),
          ListTile(
            contentPadding: const EdgeInsets.all(0),
            title: Text(
              label.capitalizeFirst,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              "$datecreated items",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
