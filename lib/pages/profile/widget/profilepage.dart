import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:urlnav2/appState.dart';
import 'package:urlnav2/constants/custom_text.dart';
import 'package:urlnav2/constants/style.dart';
import 'package:urlnav2/helpers/reponsiveness.dart';
import 'package:urlnav2/helpers/save_file_web.dart';
import 'package:urlnav2/pages/profile/widget/myabout.dart';
import 'package:urlnav2/pages/profile/widget/myschool.dart';
import 'package:urlnav2/pages/profile/widget/myexperience.dart';
import 'package:urlnav2/pages/profile/widget/myfollowers.dart';
import 'package:urlnav2/pages/profile/widget/myskills.dart';
import 'package:urlnav2/pages/profile/widget/profileimage.dart';

class ProfilePage extends StatefulWidget {
  final QuerySnapshot<Object> data;
  final AppState appState;
  ProfilePage(this.data, this.appState);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _skillsController = TextEditingController();
  final _skillsController2 = TextEditingController();
  final _schoolController = TextEditingController();
  final _mystudyController = TextEditingController();
  final _mystudyyearController = TextEditingController();
  final _aboutsController = TextEditingController();
  ScrollController _controller;
  Stream<QuerySnapshot> skills;
  Stream<QuerySnapshot> school;
  Stream<QuerySnapshot> about;
  CollectionReference addskills;
  CollectionReference addschools;
  CollectionReference addabouts;

  @override
  void initState() {
    _controller = ScrollController();

    skills = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.appState.myid)
        .collection('skills')
        .snapshots();

    school = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.appState.myid)
        .collection('schools')
        .snapshots();

    about = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.appState.myid)
        .collection('about')
        .snapshots();

    addskills = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.appState.myid)
        .collection('skills');

    addschools = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.appState.myid)
        .collection('schools');

    addabouts = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.appState.myid)
        .collection('about');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: ResponsiveWidget.isLargeScreen(context)
            ? const EdgeInsets.symmetric(horizontal: 30, vertical: 10)
            : const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 5,
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  firstcolumn(),
                  const SizedBox(
                    height: 10,
                  ),
                  AboutProfile(
                    appState: widget.appState,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ExperienceProfile(
                    appState: widget.appState,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SchoolProfile(
                    appState: widget.appState,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SkillsProfile(
                    appState: widget.appState,
                  )
                ],
              ),
            ),
            if (!ResponsiveWidget.isSmallScreen(context))
              Flexible(
                flex: 2,
                child: Column(
                  children: [
                    followerslist(),
                    const SizedBox(
                      height: 10,
                    ),
                    emptycolumn(
                      "Resume",
                      generateresumebutton(),
                    ),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }

  Widget followerslist() {
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 30),
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: legistwhite,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: lightGrey, width: .5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText(
            text: "People you may know",
          ),
          Center(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .where("isuser", isEqualTo: false)
                  //.where('firstname',
                  //    isNotEqualTo: widget.data.docs[0]['firstname'])
                  .snapshots(),
              builder: (
                BuildContext context,
                AsyncSnapshot<QuerySnapshot> snapshot,
              ) {
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                return Container(
                    padding: const EdgeInsets.all(10),
                    child: ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return MyFollowers(
                              name: snapshot.data.docs[index]['firstname'],
                              job: snapshot.data.docs[index]['jobtitle'],
                              location: snapshot.data.docs[index]['location'],
                              url: snapshot.data.docs[index]['dpurl']);
                        }));
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget firstcolumn() {
    return Container(
      decoration: BoxDecoration(
        color: legistwhite,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: lightGrey, width: .5),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Center(
                //padding: const EdgeInsets.only(right: 12),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    "assets/images/cvk_profile_cover.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 200,
                  ),
                  Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: Container(
                            decoration: BoxDecoration(
                                color: legistwhite,
                                border: Border.all(color: lightGrey, width: .5),
                                borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10))),
                            child: firstColumnobj()),
                      ),
                    ],
                  )
                ],
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 80,
                      ),
                      ProfileImageWidget(
                        data: widget.data,
                        appState: widget.appState,
                      ),
                      /*Flexible(
                          flex: 3,
                          child: Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              Container(
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                    color: legistwhite,
                                    borderRadius: BorderRadius.circular(120)),
                                child: Container(
                                  //width: 200,
                                  decoration: BoxDecoration(
                                      color: legistwhite,
                                      borderRadius: BorderRadius.circular(120)),
                                  padding: const EdgeInsets.all(2),
                                  margin: const EdgeInsets.all(2),
                                  child: widget.data.docs.isNotEmpty
                                      ? CircleAvatar(
                                          backgroundColor: legistblue,
                                          backgroundImage: NetworkImage(
                                            widget.data.docs[0]['dpurl'],
                                          ),
                                        )
                                      : const CircleAvatar(
                                          backgroundColor: legistblue,
                                          backgroundImage: NetworkImage(
                                            "https://www.seekpng.com/png/detail/847-8474751_download-empty-profile.png",
                                          ),
                                        ),
                                ),
                              ),
                              InkWell(
                                onTap: () {},
                                child: Icon(Icons.edit),
                              )
                            ],
                          )),*/
                      Flexible(
                        flex: 5,
                        child: Container(),
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget firstColumnobj() {
    if (widget.data.docs.isNotEmpty) {
      return Padding(
        padding:
            const EdgeInsets.only(left: 30, right: 30, top: 50, bottom: 20),
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text:
                          "${widget.data.docs[0]['firstname']} ${widget.data.docs[0]['lastname']}",
                      size: 20,
                      weight: FontWeight.bold,
                    ),
                    CustomText(
                      text:
                          "${widget.data.docs[0]['jobtitle']} at ${widget.data.docs[0]['firmname']}",
                      size: 15,
                      weight: FontWeight.w600,
                    ),
                    CustomText(
                      text: widget.data.docs[0]['location'],
                      size: 14,
                      weight: FontWeight.normal,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        CustomText(
                          text: "0",
                          size: 14,
                          weight: FontWeight.bold,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        CustomText(
                          text: "followers",
                          size: 14,
                          weight: FontWeight.normal,
                        ),
                      ],
                    )
                  ],
                ),
                if (!ResponsiveWidget.isSmallScreen(context))
                  Expanded(child: Container()),
                if (!ResponsiveWidget.isSmallScreen(context))
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      myxp("myschool"),
                      //myxp(widget.school, "myschool")
                    ],
                  )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            /*Row(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {});
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      color: legistblue,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: CustomText(
                      color: legistwhitefont,
                      text: "Message",
                      size: 15,
                      weight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    setState(() {});
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: lightGrey, width: 1),
                    ),
                    child: CustomText(
                      color: lightGrey,
                      text: "More",
                      size: 15,
                      weight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),*/
            SizedBox(
              height: 10,
            ),
            scrollskill(),
          ],
        ),
      );
    } else {
      return Center(
        child: Container(
          decoration: BoxDecoration(
            color: legistwhite,
          ),
          child: ElevatedButton(
            onPressed: () {
              //sideMenuController.changeActiveItemTo("NewClients");
              //widget.appState.selectedIndex = 6;
              //Navigator.push(context,
              //   MaterialPageRoute(builder: (context) => ClientsForm()));
            },
            child: Text("Add Details"),
          ),
        ),
      );
    }
  }

  Widget scrollskill() {
    return Container(
      height: 100,
      child: Row(
        //alignment: AlignmentDirectional.center,
        children: [
          InkWell(
              onHover: (value) {},
              onTap: () {
                _moveUp(150);
              },
              child: Icon(Icons.chevron_left_sharp)),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(widget.appState.myid)
                    .collection('skills')
                    .snapshots(),
                builder: (
                  BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot,
                ) {
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      controller: _controller,
                      itemCount: snapshot.data.size,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: horicell(snapshot.data.docs[index]["myskills"],
                              snapshot.data.docs[index]["about"]),
                        );
                      });
                }),
          ),
          InkWell(
              onTap: () {
                _moveDown(150);
              },
              child: Icon(Icons.chevron_right_sharp)),
        ],
      ),
    );
  }

  _moveUp(double itemSize) {
    _controller.animateTo(_controller.offset - itemSize,
        curve: Curves.linear, duration: Duration(milliseconds: 500));
  }

  _moveDown(double itemSize) {
    _controller.animateTo(_controller.offset + itemSize,
        curve: Curves.linear, duration: Duration(milliseconds: 500));
  }

  Widget myxp(String myschool) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(widget.appState.myid)
          .collection('schools')
          .snapshots(),
      builder: (
        BuildContext context,
        AsyncSnapshot<QuerySnapshot> snapshot,
      ) {
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (snapshot.data.docs.isEmpty) {
          return Container();
        }

        return Row(
          children: [
            Image.asset(
              "assets/icons/logo.png",
              fit: BoxFit.contain,
              height: 20,
            ),
            SizedBox(
              width: 10,
            ),
            CustomText(
              text: snapshot.data.docs[snapshot.data.docs.length - 1][myschool],
              size: 14,
              weight: FontWeight.bold,
            ),
          ],
        );
      },
    );
  }

  Widget horicell(String skill, String about) {
    return Container(
      width: 300,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: lightGrey.withOpacity(0.4),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            color: dark,
            text: skill,
            size: 12,
            weight: FontWeight.bold,
          ),
          SafeArea(
            child: CustomText(
              color: dark,
              text: about,
              size: 12,
              weight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget emptycolumn(
    String title,
    Widget child,
  ) {
    return Container(
        margin: const EdgeInsets.only(top: 10, left: 30),
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          color: legistwhite,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: lightGrey, width: .5),
        ),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: title,
                weight: FontWeight.w900,
                size: 15,
              ),
            ],
          ),
          child
        ]));
  }

  Widget generateresumebutton() {
    return InkWell(
      onTap: _createcertificate,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
            color: legistblue, borderRadius: BorderRadius.circular(10)),
        child: const Center(
          child: ListTile(
            trailing: Icon(
              Icons.download,
              color: legistwhitefont,
            ),
            title: CustomText(
                text: 'Generate Resume',
                talign: TextAlign.center,
                color: Colors.white),
          ),
        ),
      ),
    );
  }

  Future<void> _createcertificate() async {
    //Create a PDF document.
    final PdfDocument document = PdfDocument();
    document.pageSettings.orientation = PdfPageOrientation.portrait;
    document.pageSettings.margins.all = 0;
    //Add page to the PDF
    final PdfPage page = document.pages.add();
    //Get the page size
    final Size pageSize = page.getClientSize();
    //Draw image
    page.graphics.drawImage(PdfBitmap(await _readImageData('resume1.jpg')),
        Rect.fromLTWH(0, 0, pageSize.width, pageSize.height));
    //Create font
    final PdfFont nameFont =
        PdfStandardFont(PdfFontFamily.helvetica, 27, style: PdfFontStyle.bold);
    final PdfFont controlFont =
        PdfStandardFont(PdfFontFamily.helvetica, 12, style: PdfFontStyle.bold);
    final PdfFont dateFont = PdfStandardFont(PdfFontFamily.helvetica, 12);
    final PdfFont infoFont = PdfStandardFont(PdfFontFamily.helvetica, 9);
    final PdfFont educationFont =
        PdfStandardFont(PdfFontFamily.helvetica, 10, style: PdfFontStyle.bold);
    final PdfFont uniFont = PdfStandardFont(PdfFontFamily.helvetica, 10);
    final PdfFont descFont = PdfStandardFont(PdfFontFamily.helvetica, 10,
        style: PdfFontStyle.italic);

    double x = _calculateXPosition(
        "${widget.data.docs[0]['firstname']}", nameFont, pageSize.width);
    page.graphics.drawString(widget.data.docs[0]['firstname'], nameFont,
        bounds: const Rect.fromLTWH(220, 75, 0, 0),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)));

    // Job Title
    x = _calculateXPosition("${widget.data.docs[0]['jobtitle']} at Teczo",
        controlFont, pageSize.width);
    page.graphics.drawString(
        "${widget.data.docs[0]['jobtitle']} at Teczp", controlFont,
        bounds: const Rect.fromLTWH(230, 133, 0, 0),
        brush: PdfSolidBrush(PdfColor(20, 58, 86)));

    // email
    final String emailText = widget.data.docs[0]['email'];
    x = _calculateXPosition(emailText, infoFont, pageSize.width);
    page.graphics.drawString(emailText, infoFont,
        bounds: const Rect.fromLTWH(115, 23, 0, 0),
        brush: PdfSolidBrush(PdfColor(255, 255, 255)));

    // email
    final String locationText = widget.data.docs[0]['location'];
    x = _calculateXPosition(locationText, infoFont, pageSize.width);
    page.graphics.drawString(locationText, infoFont,
        bounds: const Rect.fromLTWH(305, 23, 0, 0),
        brush: PdfSolidBrush(PdfColor(255, 255, 255)));

    // linked in
    final String aboutText =
        "Experienced Chief Technology Officer with a\ndemonstrated history of working in the information\ntechnology and services industry.Skilled in Graphic \nDesign, Game Development, Android Development, \nWeb Development, and Project Management. \nStrong information technology professional with a \nBachelor ofEngineering - BE focused in Mechanical \nEngineering from Universiti Teknologi PETRONAS.";
    x = _calculateXPosition(aboutText, dateFont, pageSize.width);
    page.graphics.drawString(aboutText, dateFont,
        bounds: const Rect.fromLTWH(300, 250, 0, 0),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)));

    // Education 1
    final String bachelorText = "Mechanical Engineering";
    x = _calculateXPosition(bachelorText, educationFont, pageSize.width);
    page.graphics.drawString(bachelorText, educationFont,
        bounds: const Rect.fromLTWH(300, 430, 0, 0),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)));
    final String uniText = "University Teknologi Petronas";
    x = _calculateXPosition(uniText, uniFont, pageSize.width);
    page.graphics.drawString(uniText, uniFont,
        bounds: const Rect.fromLTWH(300, 450, 0, 0),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)));
    final String edudescText = "Dec 2019";
    x = _calculateXPosition(edudescText, descFont, pageSize.width);
    page.graphics.drawString(edudescText, descFont,
        bounds: const Rect.fromLTWH(300, 470, 0, 0),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)));

    final String bachelor2Text = "Secondary Eduvation";
    x = _calculateXPosition(bachelor2Text, educationFont, pageSize.width);
    page.graphics.drawString(bachelor2Text, educationFont,
        bounds: const Rect.fromLTWH(300, 500, 0, 0),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)));
    final String uni2Text = "SMK KKB";
    x = _calculateXPosition(uni2Text, uniFont, pageSize.width);
    page.graphics.drawString(uni2Text, uniFont,
        bounds: const Rect.fromLTWH(300, 520, 0, 0),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)));
    final String edudesc2Text = "2011";
    x = _calculateXPosition(edudesc2Text, descFont, pageSize.width);
    page.graphics.drawString(edudesc2Text, descFont,
        bounds: const Rect.fromLTWH(300, 540, 0, 0),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)));

    // Experience 1
    final String compText = "Teczo Sdn Bhd";
    x = _calculateXPosition(compText, uniFont, pageSize.width);
    page.graphics.drawString(compText, uniFont,
        bounds: const Rect.fromLTWH(31, 250, 0, 0),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)));
    final String titleText =
        "${widget.data.docs[0]['jobtitle']}, ${widget.data.docs[0]['jobstartingdt']}- Present";
    x = _calculateXPosition(titleText, educationFont, pageSize.width);
    page.graphics.drawString(titleText, educationFont,
        bounds: const Rect.fromLTWH(31, 270, 0, 0),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)));

    // Skills
    final String skills1Text = "Project Management";
    x = _calculateXPosition(skills1Text, dateFont, pageSize.width);
    page.graphics.drawString(skills1Text, dateFont,
        bounds: const Rect.fromLTWH(31, 350, 0, 0),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)));

    final String skills2Text = "JavaScript";
    x = _calculateXPosition(skills2Text, dateFont, pageSize.width);
    page.graphics.drawString(skills2Text, dateFont,
        bounds: const Rect.fromLTWH(31, 370, 0, 0),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)));

    final String skills3Text = "Legal Services";
    x = _calculateXPosition(skills3Text, dateFont, pageSize.width);
    page.graphics.drawString(skills3Text, dateFont,
        bounds: const Rect.fromLTWH(31, 390, 0, 0),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)));

    final String skills4Text = "Kotlin";
    x = _calculateXPosition(skills4Text, dateFont, pageSize.width);
    page.graphics.drawString(skills4Text, dateFont,
        bounds: const Rect.fromLTWH(31, 410, 0, 0),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)));

    final String skills5Text = "Python";
    x = _calculateXPosition(skills5Text, dateFont, pageSize.width);
    page.graphics.drawString(skills5Text, dateFont,
        bounds: const Rect.fromLTWH(31, 430, 0, 0),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)));

    final String skills6Text = "Mobile Development";
    x = _calculateXPosition(skills6Text, dateFont, pageSize.width);
    page.graphics.drawString(skills6Text, dateFont,
        bounds: const Rect.fromLTWH(31, 450, 0, 0),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)));

    final String skills7Text = "Flutter";
    x = _calculateXPosition(skills7Text, dateFont, pageSize.width);
    page.graphics.drawString(skills7Text, dateFont,
        bounds: const Rect.fromLTWH(31, 470, 0, 0),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)));

    final String skills8Text = "Web Development";
    x = _calculateXPosition(skills8Text, dateFont, pageSize.width);
    page.graphics.drawString(skills8Text, dateFont,
        bounds: const Rect.fromLTWH(31, 490, 0, 0),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)));

    final String skills9Text = "Java";
    x = _calculateXPosition(skills9Text, dateFont, pageSize.width);
    page.graphics.drawString(skills9Text, dateFont,
        bounds: const Rect.fromLTWH(31, 510, 0, 0),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)));
    //Save and launch the document
    final List<int> bytes = document.save();
    //Dispose the document.
    document.dispose();
    //Save and launch file.
    await FileSaveHelper.saveAndLaunchFile(bytes, 'Certificate.pdf');
  }

  double _calculateXPosition(String text, PdfFont font, double pageWidth) {
    final Size textSize =
        font.measureString(text, layoutArea: Size(pageWidth, 0));
    return (pageWidth - textSize.width) / 2;
  }

  Future<List<int>> _readImageData(String name) async {
    final ByteData data = await rootBundle.load('assets/images/$name');
    return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  }
}
