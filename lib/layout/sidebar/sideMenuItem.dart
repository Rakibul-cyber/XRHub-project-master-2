import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:urlnav2/appState.dart';
import 'package:urlnav2/constants/custom_text.dart';
import 'package:urlnav2/constants/myconstants.dart';
import 'package:urlnav2/constants/style.dart';
import 'package:urlnav2/layout/sidebar/childitemlist.dart';
import 'package:urlnav2/pages/cases/selectedCaseState.dart';
import 'package:urlnav2/pages/records/widgets/selectedrecordstate.dart';
import 'package:urlnav2/pages/tasks/selectedtaskstate.dart';

class NavItem extends StatefulWidget {
  final IconData icon;
  final String name;
  final bool selected;
  final AppState appState;
  final SelectedCaseState caseState;
  final SelectedTaskState taskState;
  final SelectedRecordState recordState;
  final int selectedindex;
  final Childitemslist childname;

  const NavItem(
      {Key key,
      this.icon,
      this.name,
      this.selected,
      this.appState,
      this.caseState,
      this.taskState,
      this.recordState,
      this.selectedindex,
      this.childname})
      : super(key: key);

  @override
  State<NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<NavItem> {
  bool isopen = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return mywidget2();
  }

  Widget mywidget2() {
    return Material(
      color: greyBc,
      child: AnimatedContainer(
        decoration: BoxDecoration(
            color: sideMenuController.isActive(widget.name)
                ? Colors.grey.shade100
                : Colors.transparent,
            ),
        alignment: sideMenuController.isActive(widget.name)
            ? Alignment.topCenter
            : Alignment.center,
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn,
        width: double.infinity,
        
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                  onTap: () {
                    if (!sideMenuController.isActive(widget.name)) {
                      sideMenuController.changeActiveItemTo(widget.name);
                      widget.appState.selectedIndex = widget.selectedindex;
                      widget.caseState.selectedCase = null;
                      widget.taskState.selectedTask = null;
                      widget.recordState.selectedrecord = null;
                    }
                    //isopen = true;
                  },
                  onHover: (value) {
                    value
                        ? sideMenuController.onHover(widget.name)
                        : sideMenuController.onHover("");
                  },
                  hoverColor: white,
                  child: Obx(
                    () => Container(
                      height: 60,
                      decoration: BoxDecoration(
                          color: sideMenuController.isActive(widget.name)
                              ? Colors.white
                              : Colors.transparent,
                          //borderRadius: BorderRadius.circular(10)
                          
                          ),
                      alignment: Alignment.center,
                      child: ListTile(
                        leading: Icon(
                          widget.icon,
                          color: sideMenuController.isActive(widget.name) ||
                                  sideMenuController.isHovering(widget.name)
                              ? blue
                              : lightGrey,
                        ),
                        title: Row(
                          children: [
                            CustomText(
                              text: widget.name,
                              weight: sideMenuController.isActive(widget.name) ||
                                      sideMenuController.isHovering(widget.name)
                                  ? FontWeight.bold
                                  : FontWeight.w400,
                              color: sideMenuController.isActive(widget.name) ||
                                      sideMenuController.isHovering(widget.name)
                                  ? blue
                                  : lightGrey,
                            ),
                            SizedBox(width: 10,),
                            widget.childname != null ? Icon(MaterialCommunityIcons.star_circle, color: Color(0xFF00AC9E), size: 16,): Text(''),
                          ],
                        ),
                       
                      ),
                    ),
                  )),
              
            ],
          ),
        ),
      ),
    );
  }

  double containersize(int count, double containersize) {
    return containersize + 45.0 * (count);
  }
}
