import 'package:flutter/material.dart';
import 'package:urlnav2/constants/style.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardActivityWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
        child: Row(
      children: [
        // x20,
        Expanded(
          child: Container(
            // ignore: prefer_const_constructors
            padding: EdgeInsets.all(paddingMid),
            decoration: BoxDecoration(
                border: Border.all(color: lightGrey, width: .5),
                borderRadius: BorderRadius.circular(space_20),
                color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Activity',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.getFont('Poppins',
                        textStyle: const TextStyle(
                            fontSize: fontHeader, color: dark))),
                const Divider(
                  height: space_20,
                ),
                activityCard(
                    name: 'Jenna Westbrook',
                    color: Colors.purple,
                    recentActivity: 'added Jessie Stones as a friend'),
                y10,
                activityCard(
                  name: 'Anwar Obaid',
                  color: Color.fromARGB(255, 0, 107, 194),
                  recentActivity:
                      'shared a file with you. Click here to check it out', /* activityType: addFriend */
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }

  Widget activityCard({
     String name,
     String recentActivity,
     Color color,
  }) {
    return Expanded(
      child: InkWell(
        onTap: () {},
        child: Container(
            padding: const EdgeInsets.all(paddingSmall + paddingMin),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(space_20), color: color),
            child: RichText(
              text: TextSpan(
                // Note: Styles for TextSpans must be explicitly defined.
                // Child text spans will inherit styles from parent
                style: GoogleFonts.getFont('Poppins',
                    textStyle: const TextStyle(
                      fontSize: fontSub,
                      color: light,
                    )),
                children: <TextSpan>[
                  TextSpan(
                      text: name,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: ' has just $recentActivity.'),
                  const TextSpan(
                      text: '\n6:11 PM',
                      style:
                          TextStyle(color: Colors.white54, fontSize: fontSub)),
                ],
              ),
            )),
      ),
    );
  }
}
