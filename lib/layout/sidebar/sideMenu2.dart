import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:urlnav2/appState.dart';
import 'package:urlnav2/constants/custom_text.dart';
import 'package:urlnav2/constants/myconstants.dart';
import 'package:urlnav2/constants/style.dart';
import 'package:urlnav2/helpers/reponsiveness.dart';
import 'package:urlnav2/layout/constants/getcasenumber.dart';
import 'package:urlnav2/layout/constants/getexperience.dart';
import 'package:urlnav2/layout/constants/getmyusername.dart';
import 'package:urlnav2/layout/constants/getprofilepic.dart';
import 'package:urlnav2/layout/sidebar/childitemlist.dart';
import 'package:urlnav2/layout/sidebar/sideMenuItem.dart';
import 'package:urlnav2/pages/cases/selectedCaseState.dart';
import 'package:urlnav2/pages/records/widgets/selectedrecordstate.dart';
import 'package:urlnav2/pages/tasks/selectedtaskstate.dart';

class CVKSideMenu2 extends StatefulWidget {
  final AppState appState;
  final SelectedCaseState caseState;
  final SelectedTaskState taskState;
  final SelectedRecordState recordState;
  const CVKSideMenu2(
      {Key key,
      this.appState,
      this.caseState,
      this.taskState,
      this.recordState})
      : super(key: key);

  @override
  State<CVKSideMenu2> createState() => CVKSideMenu2State();
}

class CVKSideMenu2State extends State<CVKSideMenu2> {
  var isexpanded = true;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: isexpanded ? 250 : 100,
        decoration: BoxDecoration(
          color: greyBc,
          border: Border.all(color: lightGrey, width: .5),
        ),
        child: ListView(
          children: [
            Column(
              //mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                cvkLogo(),
                //profilepic(context),
                //CustomText(text: widget.appState.selectedIndex.toString()),
                //CustomText(text: widget.caseState.selectedCase.toString()),
                //storagecheck(80, 0),
                Visibility(
                  visible: false,
                  child: NavItem(
                  
                  selected: true,
                  icon: SimpleLineIcons.home,
                  name: "ProjectHome",
                  
                  appState: widget.appState,
                  caseState: widget.caseState,
                  taskState: widget.taskState,
                  recordState: widget.recordState,
                  selectedindex: 0,
                              ),
                ),

                NavItem(
                selected: false,
                icon: SimpleLineIcons.home,
                name: "Dashboard",
                
                appState: widget.appState,
                caseState: widget.caseState,
                taskState: widget.taskState,
                recordState: widget.recordState,
                selectedindex: 1,
              ),
              
              NavItem(
                selected: false,
                icon: MaterialCommunityIcons.google_spreadsheet,
                name: "Issue",
                childname: Childitemslist([], []),
                appState: widget.appState,
                caseState: widget.caseState,
                taskState: widget.taskState,
                recordState: widget.recordState,
                selectedindex: 2,
              ),
              NavItem(
                selected: false,
                icon: Feather.file,
                name: "RFIs",
                childname: Childitemslist([], []),
                appState: widget.appState,
                caseState: widget.caseState,
                taskState: widget.taskState,
                recordState: widget.recordState,
                selectedindex: 3,
              ),

              NavItem(
                selected: false,
                icon: AntDesign.checkcircleo,
                name: "Projects",
                
                appState: widget.appState,
                caseState: widget.caseState,
                taskState: widget.taskState,
                recordState: widget.recordState,
                selectedindex: 4,
              ),
              
              // NavItem(
              //   selected: false,
              //   icon: Foundation.clipboard_notes,
              //   name: "Forms",
                
              //   appState: widget.appState,
              //   caseState: widget.caseState,
              //   taskState: widget.taskState,
              //   recordState: widget.recordState,
              //   selectedindex: 4,
              // ),

              // NavItem(
              //   selected: false,
              //   icon: Ionicons.images_outline,
              //   name: "Photos",
                
              //   appState: widget.appState,
              //   caseState: widget.caseState,
              //   taskState: widget.taskState,
              //   recordState: widget.recordState,
              //   selectedindex: 5,
              // ),
              // NavItem(
              //   selected: false,
              //   icon: MaterialCommunityIcons.message_alert_outline,
              //   name: "RFIs",
                
              //   appState: widget.appState,
              //   caseState: widget.caseState,
              //   taskState: widget.taskState,
              //   recordState: widget.recordState,
              //   selectedindex: 6,
              // ),
              // NavItem(
              //   selected: false,
              //   icon: MaterialCommunityIcons.account_group_outline,
              //   name: "Meetings",
                
              //   appState: widget.appState,
              //   caseState: widget.caseState,
              //   taskState: widget.taskState,
              //   recordState: widget.recordState,
              //   selectedindex: 7,
              // ),
              // NavItem(
              //   selected: false,
              //   icon: MaterialCommunityIcons.chart_timeline,
              //   name: "Schedule",
                
              //   appState: widget.appState,
              //   caseState: widget.caseState,
              //   taskState: widget.taskState,
              //   recordState: widget.recordState,
              //   selectedindex: 8,
              // ),
              // NavItem(
              //   selected: false,
              //   icon: AntDesign.gift,
              //   name: "Assets",
                
              //   appState: widget.appState,
              //   caseState: widget.caseState,
              //   taskState: widget.taskState,
              //   recordState: widget.recordState,
              //   selectedindex: 9,
              // ),
              // NavItem(
              //   selected: false,
              //   icon: Entypo.text_document,
              //   name: "Reports",
                
              //   appState: widget.appState,
              //   caseState: widget.caseState,
              //   taskState: widget.taskState,
              //   recordState: widget.recordState,
              //   selectedindex: 10,
              // ),
              // NavItem(
              //   selected: false,
              //   icon: MaterialIcons.group,
              //   name: "Members",
                
              //   appState: widget.appState,
              //   caseState: widget.caseState,
              //   taskState: widget.taskState,
              //   recordState: widget.recordState,
              //   selectedindex: 11,
              // ),
              // NavItem(
              //   selected: false,
              //   icon: Ionicons.swap_horizontal_outline,
              //   name: "Bridge",
                
              //   appState: widget.appState,
              //   caseState: widget.caseState,
              //   taskState: widget.taskState,
              //   recordState: widget.recordState,
              //   selectedindex: 12,
              // ),
              // NavItem(
              //   selected: false,
              //   icon: SimpleLineIcons.settings,
              //   name: "Settings",
                
              //   appState: widget.appState,
              //   caseState: widget.caseState,
              //   taskState: widget.taskState,
              //   recordState: widget.recordState,
              //   selectedindex: 13,
              // ),
              // Divider(
              //             height: 1.5,
              //             color: Color.fromARGB(255, 153, 151, 151),
              //           ),
              // NavItem(
              //   selected: false,
              //   icon: MaterialCommunityIcons.arrow_collapse_left,
              //   name: "",
                
              //   appState: widget.appState,
              //   caseState: widget.caseState,
              //   taskState: widget.taskState,
              //   recordState: widget.recordState,
              //   selectedindex: 14,
              // ),
              
                //Expanded(child: Container()),
                //Icon(Icons.arrow_back_ios)
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget cvkLogo() {
    return Container(
      decoration: BoxDecoration(
        color: white,
        border: Border.symmetric(
            horizontal:
                BorderSide(color: lightGrey.withOpacity(0.5), width: .5)),
      ),
      child: SizedBox(
       // height: toolbarheight - 1.0,
        child: ListTile(
          // leading: Image.asset(
          //   "assets/icons/logo.png",
          //   width: 50,
          // ),
          leading: Image.asset(
            "assets/images/logo.png",
           height: 50,
          ),
          
          // title: const CustomText(
          //   text: "XRHUB",
          //   size: 11,
          //   color: legistwhitefont,
          //   weight: FontWeight.bold,
         // ),
          // trailing: InkWell(
          //   onHover: (value) {},
          //   onTap: () {
          //     setState(() {
          //       isexpanded = !isexpanded;
          //     });
          //   },
          //   child: Icon(
          //     isexpanded
          //         ? Icons.arrow_left_outlined
          //         : Icons.arrow_right_outlined,
          //     size: 25,
          //     color: dark,
          //   ),
          // ),
        ),
      ),
    );
  }

  Widget profilepic(BuildContext context) {
    return SafeArea(
      child: InkWell(
        onHover: (value) {},
        onTap: () {
          if (!sideMenuController.isActive("Profile")) {
            sideMenuController.changeActiveItemTo("Profile");
            widget.appState.selectedIndex = 5;
            widget.caseState.selectedCase = null;
            widget.taskState.selectedTask = null;
            widget.recordState.selectedrecord = null;
          }
          widget.appState.selectedIndex = 5;
        },
        child: Column(
          children: [
            const SizedBox(
              height: 16,
            ),
            Container(
              decoration: BoxDecoration(
                  color: legistblue.withOpacity(.5),
                  borderRadius: BorderRadius.circular(60)),
              child: Container(
                decoration: BoxDecoration(
                    color: legistwhite,
                    borderRadius: BorderRadius.circular(60)),
                padding: const EdgeInsets.all(2),
                margin: const EdgeInsets.all(2),
                child: GetProfilePic(
                  appState: widget.appState,
                ),
              ),
            ),
            if (isexpanded) ...[
              Getusername(
                appState: widget.appState,
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 1,
                    child: Column(
                      children: [
                        const CustomText(
                          talign: TextAlign.center,
                          text: "Projects",
                          size: 12,
                          weight: FontWeight.bold,
                        ),
                        Getcasenumber(
                          appState: widget.appState,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Container(
                    width: 1,
                    height: 22,
                    color: lightGrey,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Flexible(
                    flex: 1,
                    child: Column(
                      children: [
                        if (ResponsiveWidget.isLargeScreen(context)) ...[
                          const CustomText(
                              text: "Experience",
                              size: 12,
                              weight: FontWeight.bold),
                        ] else ...[
                          const CustomText(
                              text: "XP", size: 12, weight: FontWeight.bold),
                        ],
                        GetExperience(
                          appState: widget.appState,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Container(
                    width: 1,
                    height: 22,
                    color: lightGrey,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Flexible(
                    flex: 1,
                    child: Column(
                      children: const [
                        CustomText(
                            text: "Rating", size: 12, weight: FontWeight.bold),
                        CustomText(text: "4.5", color: lightGrey),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
            ],
            const Divider(
              height: 10,
              thickness: 1.0,
              indent: 20,
              endIndent: 20,
            )
          ],
        ),
      ),
    );
  }

  Widget storagecheck(double total, double used) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: SafeArea(
        child: InkWell(
          onHover: (value) {},
          onTap: () {
            if (!sideMenuController.isActive("Profile")) {
              sideMenuController.changeActiveItemTo("Profile");
              widget.appState.selectedIndex = 5;
              widget.caseState.selectedCase = null;
              widget.taskState.selectedTask = null;
              widget.recordState.selectedrecord = null;
            }
            widget.appState.selectedIndex = 5;
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ListTile(
                leading: Icon(Icons.cloud_outlined),
                title: CustomText(
                  text: "Storage",
                  size: 12,
                ),
              ),
              if (isexpanded) ...[
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: LinearProgressIndicator(
                    value: 0.4,
                  ),
                ),
                CustomText(
                  text: "$used GB of $total GB used",
                  color: grey,
                  size: 12,
                ),
                const SizedBox(
                  height: 16,
                ),
                const Divider(
                  height: 10,
                  thickness: 1.0,
                  indent: 20,
                  endIndent: 20,
                )
              ]
            ],
          ),
        ),
      ),
    );
  }
}
