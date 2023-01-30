import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:urlnav2/constants/custom_text.dart';
import 'package:urlnav2/constants/style.dart';
import 'package:urlnav2/pages/dashboard/widget/dashboard_task_card.dart';

class DashboardCompletedTaskWidget extends StatelessWidget {
  const DashboardCompletedTaskWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(paddingMid),
        decoration: BoxDecoration(
            border: Border.all(color: lightGrey, width: .5),
            color: Colors.white),
        child: Column(
          children: [
            InkWell(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Completed',
                      style: GoogleFonts.getFont('Poppins',
                          textStyle: const TextStyle(
                              fontSize: fontHeader, color: dark))),
                  x10,
                  const CircleAvatar(
                    radius: 15,
                    backgroundColor: foregroundColor,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CustomText(
                        text: '5',
                        color: light,
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              height: space_20,
            ),
            SizedBox(
              height: 160,
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      DashboardTaskCard(
                          caseName: "The people vs. Mary O'Donnel",
                          task:
                              'Prosecutor Jill McAdams has been selected as the judge.'),
                      y10,
                      DashboardTaskCard(
                          caseName: "The people vs. Mary O'Donnel",
                          task:
                              'Prosecutor Jill McAdams has been selected as the judge.'),
                      y10,
                      DashboardTaskCard(
                          caseName: "The people vs. Mary O'Donnel",
                          task:
                              'Prosecutor Jill McAdams has been selected as the judge.'),
                      y10,
                      DashboardTaskCard(
                          caseName: "The people vs. Mary O'Donnel",
                          task:
                              'Prosecutor Jill McAdams has been selected as the judge.'),
                      y10,
                      DashboardTaskCard(
                          caseName: "The people vs. Mary O'Donnel",
                          task:
                              'Prosecutor Jill McAdams has been selected as the judge.'),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
