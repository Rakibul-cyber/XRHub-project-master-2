import 'package:flutter/material.dart';
import 'package:urlnav2/constants/custom_text.dart';
import 'package:urlnav2/constants/style.dart';

class MyFollowers extends StatefulWidget {
  final String name;
  final String job;
  final String location;
  final String url;

  const MyFollowers({Key key, this.job, this.location, this.name, this.url})
      : super(key: key);

  @override
  _MyFollowers createState() => _MyFollowers();
}

class _MyFollowers extends State<MyFollowers> {
  bool isconnected = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          isThreeLine: true,
          leading: CircleAvatar(
            backgroundColor: legistblue,
            backgroundImage: NetworkImage(
              widget.url,
            ),
          ),
          title: CustomText(
            text: widget.name,
          ),
          subtitle: CustomText(
            color: grey,
            size: 12,
            text: "${widget.job} at ${widget.location}",
          ),
          trailing: InkWell(
            onTap: () {
              setState(() {
                isconnected = !isconnected;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: lightGrey, width: 1),
              ),
              child: CustomText(
                color: isconnected ? dark : lightGrey,
                text: isconnected ? "Requested" : "Connect",
                size: 15,
                weight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
