// import 'package:flutter/material.dart';
// import 'package:flutter_vector_icons/flutter_vector_icons.dart';
// import 'package:get/route_manager.dart';
// import 'package:urlnav2/appState.dart';
// import 'package:urlnav2/constants/custom_text.dart';
// import 'package:urlnav2/constants/myconstants.dart';
// import 'package:urlnav2/constants/style.dart';
// import 'package:urlnav2/helpers/reponsiveness.dart';
// import 'package:urlnav2/layout/constants/getmyusername.dart';
// import 'package:urlnav2/layout/sidebar/childitemlist.dart';
// import 'package:urlnav2/layout/sidebar/sideMenuItem.dart';
// import 'package:urlnav2/pages/cases/selectedCaseState.dart';
// import 'package:urlnav2/pages/tasks/selectedtaskstate.dart';

// class CVKSideMenu extends StatelessWidget {
//   final AppState appState;
//   final SelectedCaseState caseState;
//   final SelectedTaskState taskState;
//   const CVKSideMenu({Key key, this.appState, this.caseState, this.taskState})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: legistwhite,
//         border: Border.all(color: lightGrey, width: .5),
//       ),
//       child: ListView(
//         children: [
//           Column(
//             //mainAxisSize: MainAxisSize.max,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               profilepic(context),
//               NavItem(
//                 selected: false,
//                 icon: SimpleLineIcons.home,
//                 name: "Home",
//                 childname: Childitemslist([], []),
//                 appState: appState,
//                 caseState: caseState,
//                 taskState: taskState,
//                 selectedindex: 0,
//               ),
              
//               NavItem(
//                 selected: false,
//                 icon: MaterialCommunityIcons.google_spreadsheet,
//                 name: "Sheets",
                
//                 appState: appState,
//                 caseState: caseState,
//                 taskState: taskState,
//                 selectedindex: 1,
                
//               ),
//               NavItem(
//                 selected: false,
//                 icon: Feather.file,
//                 name: "Files",
                
//                 appState: appState,
//                 caseState: caseState,
//                 taskState: taskState,
//                 selectedindex: 2,
//               ),

//               NavItem(
//                 selected: false,
//                 icon: AntDesign.checkcircleo,
//                 name: "Issue",
//                 childname: Childitemslist([], []),
//                 appState: appState,
//                 caseState: caseState,
//                 taskState: taskState,
//                 selectedindex: 3,
//               ),
              
//               NavItem(
//                 selected: false,
//                 icon: Foundation.clipboard_notes,
//                 name: "Forms",
//                 childname: Childitemslist([], []),
//                 appState: appState,
//                 caseState: caseState,
//                 taskState: taskState,
//                 selectedindex: 4,
//               ),

//               NavItem(
//                 selected: false,
//                 icon: Ionicons.images_outline,
//                 name: "Photos",
//                 childname: Childitemslist([], []),
//                 appState: appState,
//                 caseState: caseState,
//                 taskState: taskState,
//                 selectedindex: 5,
//               ),
//               NavItem(
//                 selected: false,
//                 icon: MaterialCommunityIcons.message_alert_outline,
//                 name: "RFIs",
//                 childname: Childitemslist([], []),
//                 appState: appState,
//                 caseState: caseState,
//                 taskState: taskState,
//                 selectedindex: 6,
//               ),
//               NavItem(
//                 selected: false,
//                 icon: MaterialCommunityIcons.account_group_outline,
//                 name: "Meetings",
//                 childname: Childitemslist([], []),
//                 appState: appState,
//                 caseState: caseState,
//                 taskState: taskState,
//                 selectedindex: 7,
//               ),
//               NavItem(
//                 selected: false,
//                 icon: MaterialCommunityIcons.chart_timeline,
//                 name: "Schedule",
//                 childname: Childitemslist([], []),
//                 appState: appState,
//                 caseState: caseState,
//                 taskState: taskState,
//                 selectedindex: 8,
//               ),
//               NavItem(
//                 selected: false,
//                 icon: AntDesign.gift,
//                 name: "Assets",
//                 childname: Childitemslist([], []),
//                 appState: appState,
//                 caseState: caseState,
//                 taskState: taskState,
//                 selectedindex: 9,
//               ),
//               NavItem(
//                 selected: false,
//                 icon: Entypo.text_document,
//                 name: "Reports",
//                 childname: Childitemslist([], []),
//                 appState: appState,
//                 caseState: caseState,
//                 taskState: taskState,
//                 selectedindex: 10,
//               ),
//               NavItem(
//                 selected: false,
//                 icon: MaterialIcons.group,
//                 name: "Members",
//                 childname: Childitemslist([], []),
//                 appState: appState,
//                 caseState: caseState,
//                 taskState: taskState,
//                 selectedindex: 11,
//               ),
//               NavItem(
//                 selected: false,
//                 icon: Ionicons.swap_horizontal_outline,
//                 name: "Bridge",
//                 childname: Childitemslist([], []),
//                 appState: appState,
//                 caseState: caseState,
//                 taskState: taskState,
//                 selectedindex: 12,
//               ),
//               NavItem(
//                 selected: false,
//                 icon: SimpleLineIcons.settings,
//                 name: "Settings",
//                 childname: Childitemslist([], []),
//                 appState: appState,
//                 caseState: caseState,
//                 taskState: taskState,
//                 selectedindex: 13,
//               ),
//               Divider(
//                           height: 1.5,
//                           color: Color.fromARGB(255, 153, 151, 151),
//                         ),
//               NavItem(
//                 selected: false,
//                 icon: MaterialCommunityIcons.arrow_collapse_left,
//                 name: "",
//                 childname: Childitemslist([], []),
//                 appState: appState,
//                 caseState: caseState,
//                 taskState: taskState,
//                 selectedindex: 14,
//               ),
              
              

//               //Expanded(child: Container()),
//               //Icon(Icons.arrow_back_ios)
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget profilepic(BuildContext context) {
//     return SafeArea(
//       child: InkWell(
//         onTap: () {
//           if (!sideMenuController.isActive("Profile")) {
//             sideMenuController.changeActiveItemTo("Profile");
//             appState.selectedIndex = 5;
//             caseState.selectedCase = null;
//             taskState.selectedTask = null;
//           }
//           appState.selectedIndex = 5;
//         },
//         child: Column(
//           children: [
//             const SizedBox(
//               height: 16,
//             ),
//             Container(
//               decoration: BoxDecoration(
//                   color: active.withOpacity(.5),
//                   borderRadius: BorderRadius.circular(60)),
//               child: Container(
//                 decoration: BoxDecoration(
//                     color: legistwhite,
//                     borderRadius: BorderRadius.circular(60)),
//                 padding: const EdgeInsets.all(2),
//                 margin: const EdgeInsets.all(2),
//                 child: CircleAvatar(
//                   backgroundColor: legistwhite,
//                   child: Icon(
//                     Icons.person_outline,
//                     color: dark,
//                   ),
//                 ),
//               ),
//             ),
//             Getusername(
//               appState: appState,
//             ),
//             const SizedBox(
//               height: 16,
//             ),
//             if (ResponsiveWidget.isLargeScreen(context))
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Flexible(
//                     flex: 1,
//                     child: Column(
//                       children: [
//                         CustomText(
//                           talign: TextAlign.center,
//                           text: "Cases",
//                           weight: FontWeight.bold,
//                         ),
//                         CustomText(
//                           talign: TextAlign.center,
//                           text: "2",
//                           color: lightGrey,
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(
//                     width: 8,
//                   ),
//                   Container(
//                     width: 1,
//                     height: 22,
//                     color: lightGrey,
//                   ),
//                   const SizedBox(
//                     width: 8,
//                   ),
//                   Flexible(
//                     flex: 1,
//                     child: Column(
//                       children: [
//                         if (ResponsiveWidget.isLargeScreen(context)) ...[
//                           CustomText(
//                               text: "Experience", weight: FontWeight.bold),
//                         ] else ...[
//                           CustomText(text: "XP", weight: FontWeight.bold),
//                         ],
//                         CustomText(
//                           text: "5 yrs",
//                           color: lightGrey,
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(
//                     width: 8,
//                   ),
//                   Container(
//                     width: 1,
//                     height: 22,
//                     color: lightGrey,
//                   ),
//                   const SizedBox(
//                     width: 8,
//                   ),
//                   Flexible(
//                     flex: 1,
//                     child: Column(
//                       children: [
//                         CustomText(text: "Rating", weight: FontWeight.bold),
//                         CustomText(text: "4.5", color: lightGrey),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             const SizedBox(
//               height: 16,
//             ),
//             const Divider(
//               height: 10,
//               thickness: 1.0,
//               indent: 20,
//               endIndent: 20,
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
