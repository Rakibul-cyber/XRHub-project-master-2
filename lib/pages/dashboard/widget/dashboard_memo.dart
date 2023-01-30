import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:urlnav2/constants/custom_text.dart';
import 'package:urlnav2/constants/style.dart';

class DashboardMemoWidget extends StatelessWidget {
  const DashboardMemoWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
            Text('Memos',
                textAlign: TextAlign.center,
                style: GoogleFonts.getFont('Poppins',
                    textStyle:
                        const TextStyle(fontSize: fontHeader, color: dark))),
            const Divider(
              height: space_20,
            ),
            memocard('Project A',
                'Meeting with stakeholders soon. Stay on standby and clear your schedules.'),
            y10,
            memocard('Project B',
                'Modules to include: File sharing, chatting and live broadcasting.'),
            y5,
            const Divider(
              height: space_20,
            ),
            y10,
            InkWell(
              onTap: () {},
              child: Text('View All',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.getFont('Comfortaa',
                      textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: foregroundColor))),
            ),
          ],
        ),
      ),
    );
  }

  Widget memocard(String caseName, String memo) {
    return Expanded(
        child: Container(
      padding: const EdgeInsets.all(space_20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.amber),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
    ));
  }
}
