import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:urlnav2/constants/custom_text.dart';
import 'package:urlnav2/constants/style.dart';

class DashboardClientWidget extends StatefulWidget {
  final String fname;
  final String uname;
  final String mnumber;
  final String gender;
  final String altnum;
  final String address;
  final String email;
  final Stream streamcases;
  final String userid;

  const DashboardClientWidget(
      {Key key,
      this.address,
      this.altnum,
      this.email,
      this.fname,
      this.gender,
      this.mnumber,
      this.uname,
      this.streamcases,
      this.userid})
      : super(key: key);

  @override
  State<DashboardClientWidget> createState() => _DashboardClientWidget();
}

class _DashboardClientWidget extends State<DashboardClientWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          child: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Container(
                      alignment: Alignment.center,
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(30)),
                      child: Text(widget.fname.substring(0, 1).toUpperCase(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'OverpassRegular',
                              fontWeight: FontWeight.bold)),
                    ),
                    x10,
                    CustomText(
                      text: widget.fname,
                      color: dark,
                      size: fontHeader,
                    ),
                  ]),
                  const Divider(height: space_50),
                  const CustomText(
                    text: 'Personal Information',
                    color: foregroundColor,
                    size: fontHeader,
                    weight: FontWeight.bold,
                    talign: TextAlign.center,
                  ),
                  y40,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const CustomText(
                              text: 'First Name',
                              color: dark,
                              size: fontSub,
                              weight: FontWeight.bold,
                            ),
                            CustomText(
                              text: widget.fname,
                              color: foregroundColor,
                              size: fontSub,
                            )
                          ],
                        ),
                        y10,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const CustomText(
                              text: 'Username',
                              color: dark,
                              size: fontSub,
                              weight: FontWeight.bold,
                            ),
                            CustomText(
                              text: widget.uname,
                              color: foregroundColor,
                              size: fontSub,
                            )
                          ],
                        ),
                        y10,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const CustomText(
                              text: 'Mobile Number',
                              color: dark,
                              size: fontSub,
                              weight: FontWeight.bold,
                            ),
                            CustomText(
                              text: widget.mnumber,
                              color: foregroundColor,
                              size: fontSub,
                            )
                          ],
                        ),
                        y10,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const CustomText(
                              text: 'Email',
                              color: dark,
                              size: fontSub,
                              weight: FontWeight.bold,
                            ),
                            CustomText(
                              text: widget.email,
                              color: foregroundColor,
                              size: fontSub,
                            ),
                          ],
                        ),
                        y10,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const CustomText(
                              text: 'Gender',
                              color: dark,
                              size: fontSub,
                              weight: FontWeight.bold,
                            ),
                            CustomText(
                              text: widget.gender,
                              color: foregroundColor,
                              size: fontSub,
                            ),
                          ],
                        ),
                        y10,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const CustomText(
                              text: 'Alternative Number',
                              color: dark,
                              size: fontSub,
                              weight: FontWeight.bold,
                            ),
                            CustomText(
                              text: widget.altnum,
                              color: foregroundColor,
                              size: fontSub,
                            ),
                          ],
                        ),
                        y10,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const CustomText(
                              text: 'Address',
                              color: dark,
                              size: fontSub,
                              weight: FontWeight.bold,
                            ),
                            CustomText(
                              talign: TextAlign.end,
                              text: widget.address,
                              color: foregroundColor,
                              size: fontSub,
                            ),
                          ],
                        ),
                        y10,
                      ],
                    ),
                  ),
                  const Divider(
                    height: 4 * 20.0,
                  ),
                  mycases(widget.fname),
                  y40,
                  activecases2(widget.fname),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }

  Widget mycases(String clientname) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(widget.userid)
            .collection('cases')
            .where('clientname', isEqualTo: clientname)
            .snapshots(),
        builder: (
          BuildContext context,
          AsyncSnapshot<QuerySnapshot> snapshot,
        ) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final data = snapshot.requireData;

          return mycases2(data.size, "");
        });
  }

  Widget mycases2(int mynum, String mycasename) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CustomText(
                text: 'Active Cases',
                color: foregroundColor,
                size: fontHeader,
                weight: FontWeight.bold,
                talign: TextAlign.center),
            x10,
            Container(
                padding: const EdgeInsets.all(paddingMin),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: light,
                    border: Border.all(color: foregroundColor)),
                child: CustomText(
                  text: "$mynum",
                  color: foregroundColor,
                  size: 14,
                ))
          ],
        ),
      ],
    );
  }

  Widget activecases2(String clientname) {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(space_10),
      child: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(widget.userid)
                .collection('cases')
                .where('clientname', isEqualTo: clientname)
                .snapshots(),
            builder: (
              BuildContext context,
              AsyncSnapshot<QuerySnapshot> snapshot,
            ) {
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              final data = snapshot.requireData;

              return ListView.builder(
                  itemCount: data.size,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return buildCase(data.docs[index]['casename']);
                  });
            }),
      ),
    );
  }

  Widget activecases3() {
    return SingleChildScrollView(
      child: Container(
        child: SafeArea(
          child: Column(
            children: [
              buildCase('The people vs. Jacob Simpson'),
              y10,
              buildCase('The people vs. Sammy Stewart'),
              y10,
              buildCase('The people vs. Sammy Stewart'),
              y10,
              buildCase('The people vs. Sammy Stewart'),
              y10,
              buildCase('The people vs. Sammy Stewart'),
              y10,
              buildCase('The people vs. Sammy Stewart'),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCase(String caseName) {
    String caseTypeDescription;
    //TODO: Make a switch case that takes in caseType and returns a proper phrase of it. (Example: firstDegreeMurder -> First Degree Murder)
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(paddingMid),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(space_20),
            color: const Color.fromARGB(135, 137, 180, 255)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text: caseName,
              color: foregroundColor,
              size: fontSub,
            ),
            //PoppinsTextWidget(text: '$caseTypeDescription', color: foregroundColor, size: fontSub, isBold: true, isCenter: false),
          ],
        ),
      ),
    );
  }

  Widget activecases() {
    return StreamBuilder<QuerySnapshot>(
        stream: widget.streamcases,
        builder: (
          BuildContext context,
          AsyncSnapshot<QuerySnapshot> snapshot,
        ) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          final data = snapshot.requireData;

          return ListView.builder(
              itemCount: data.size,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return buildCase(data.docs[index]['starttime']);
              });
        });
  }
}
