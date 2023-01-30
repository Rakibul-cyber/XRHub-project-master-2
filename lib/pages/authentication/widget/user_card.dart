import 'package:flutter/material.dart';
import 'package:urlnav2/constants/custom_text.dart';
import 'package:urlnav2/constants/style.dart';

class UserCard extends StatefulWidget {
  final String username;
  final String jobtitle;
  final String location;
  final String url;
  final int index;

  const UserCard(
      {Key key,
      this.username,
      this.jobtitle,
      this.location,
      this.index,
      this.url})
      : super(key: key);

  @override
  _UserCard createState() => _UserCard();
}

class _UserCard extends State<UserCard> {
  bool isconnected = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: legistwhite,
          border: Border.all(color: lightGrey.withOpacity(.4), width: .5),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 6),
                color: lightGrey.withOpacity(.1),
                blurRadius: 12)
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: Container()),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isconnected = !isconnected;
                      });
                    },
                    child: CustomText(
                      text: isconnected ? "Requested" : "Connect",
                      color: legistwhitefont,
                    ))
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 20.0,
                    backgroundColor: legistblue,
                    child: ClipOval(
                      child: SizedBox(
                        width: 100.0,
                        height: 100.0,
                        child: Image.network(
                          widget
                              .url, //"https://www.seekpng.com/png/detail/847-8474751_download-empty-profile.png",
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  CustomText(
                    text: widget.username,
                    size: 18,
                    weight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  CustomText(
                    color: darkGrey,
                    text: widget.jobtitle,
                    size: 15,
                    weight: FontWeight.w200,
                  ),
                  CustomText(
                    color: darkGrey,
                    text: "at ${widget.location}",
                    size: 15,
                    weight: FontWeight.w200,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
