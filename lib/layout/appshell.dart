import 'package:flutter/material.dart';
import 'package:urlnav2/appState.dart';
import 'package:urlnav2/constants/custom_text.dart';
import 'package:urlnav2/constants/style.dart';
import 'package:urlnav2/helpers/reponsiveness.dart';
import 'package:urlnav2/innerRouteDelegate.dart';
import 'package:urlnav2/layout/sidebar/sideMenu.dart';
import 'package:urlnav2/layout/sidebar/sideMenu2.dart';
import 'package:urlnav2/layout/topbar/top_nav.dart';
import 'package:urlnav2/pages/books/selectedBookState.dart';
import 'package:urlnav2/pages/cases/selectedCaseState.dart';
import 'package:urlnav2/pages/records/widgets/selectedrecordstate.dart';
import 'package:urlnav2/pages/tasks/selectedtaskstate.dart';

// Widget that contains the AdaptiveNavigationScaffold
class AppShell extends StatefulWidget {
  final AppState appState;
  // final SelectedBookState selectedBookState;
  // final SelectedCaseState selectedCaseState;
  // final SelectedTaskState selectedTaskState;
  // final SelectedRecordState selectedRecordState;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final sidemenukey = GlobalKey<CVKSideMenu2State>();

  AppShell(
      {@required this.appState,
      // @required this.selectedBookState,
      // @required this.selectedCaseState,
      // @required this.selectedTaskState,
      // @required this.selectedRecordState
      
      });

  @override
  _AppShellState createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  InnerRouterDelegate _routerDelegate;
  ChildBackButtonDispatcher _backButtonDispatcher;

  @override
  void initState() {
    super.initState();
    _routerDelegate = InnerRouterDelegate(
        widget.appState,
        // widget.selectedBookState,
        // widget.selectedCaseState,
        // widget.selectedTaskState,
        // widget.selectedRecordState
        );
  }

  @override
  void didUpdateWidget(covariant AppShell oldWidget) {
    super.didUpdateWidget(oldWidget);
    _routerDelegate.appState = widget.appState;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Defer back button dispatching to the child router
    _backButtonDispatcher = Router.of(context)
        .backButtonDispatcher
        .createChildBackButtonDispatcher();
  }

  @override
  Widget build(BuildContext context) {
    var appState = widget.appState;
    // var caseState = widget.selectedCaseState;
    // var taskState = widget.selectedTaskState;
    // var recordState = widget.selectedRecordState;

    // Claim priority, If there are parallel sub router, you will need
    // to pick which one should take priority;

    _backButtonDispatcher.takePriority();

    return Row(
      children: [
        
        if (ResponsiveWidget.isLargeScreen(context))
        _routerDelegate.appState.selectedIndex != 0 ?  
        CVKSideMenu2(
              key: widget.sidemenukey,
              appState: appState,
              // caseState: caseState,
              // taskState: taskState,
              // recordState: recordState 
              
              ) 
              : Text(''),


        _routerDelegate.appState.selectedIndex != 0 ? 
        
        Expanded(
          child: Scaffold(
            key: widget.scaffoldKey,
            appBar: topNavigationBar(context, widget.scaffoldKey),
            /*body: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (ResponsiveWidget.isLargeScreen(context))
                  Expanded(
                      child: CVKSideMenu2(
                    key: widget.sidemenukey,
                    appState: appState,
                    caseState: caseState,
                    taskState: taskState,
                  ) //testsidebar(appState)
                      ),
                Expanded(
                  flex: 5,
                  child: Container(
                    child: Router(
                      routerDelegate: _routerDelegate,
                      backButtonDispatcher: _backButtonDispatcher,
                    ),
                  ),
                ),
              ],
            ),*/
            body: Container(
              child: Router(
                routerDelegate: _routerDelegate,
                backButtonDispatcher: _backButtonDispatcher,
              ),
            ),

            
             drawer:  Drawer(
              
              backgroundColor: Colors.transparent,
              elevation: 0,
              //width: widget.sidemenukey.currentState.isexpanded ? 250 : 100,
              child: CVKSideMenu2(
                  key: widget.sidemenukey,
                  appState: appState,
                  // caseState: caseState,
                  // taskState: taskState,
                  // recordState: recordState
                  
                  ),
            ),
            /*bottomNavigationBar: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings), label: 'Settings'),
                BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Clients'),
                BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Cases'),
                BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Books'),
              ],
              currentIndex: appState.selectedIndex,
              onTap: (newIndex) {
                appState.selectedIndex = newIndex;
              },
            ),*/
          ) ,
        ) 
        
        : Expanded(
          child: Scaffold(
             key: widget.scaffoldKey,
            body: Container(
                child: Router(
                  routerDelegate: _routerDelegate,
                  backButtonDispatcher: _backButtonDispatcher,
                ),
              ),
          ),
        ),
      ],
    );
  }

  Widget testsidebar(var appState) {
    final ButtonStyle style = ElevatedButton.styleFrom(
        primary: Colors.transparent,
        padding: const EdgeInsets.all(10),
        onPrimary: Colors.blue,
        shadowColor: Colors.transparent,
        textStyle: const TextStyle(fontSize: 20));
    return Column(
      children: [
        ElevatedButton(
            style: style,
            onPressed: () {
              appState.selectedIndex = 0;
              //appState.setSelectedBookById(1);
            },
            child: Text("Home")),
        ElevatedButton(
            style: style,
            onPressed: () {
              appState.selectedIndex = 1;
              //appState.setSelectedBookById(0);
            },
            child: Text("Sheets")),
        ElevatedButton(
            style: style,
            onPressed: () {
              appState.selectedIndex = 2;
              //appState.setSelectedBookById(0);
            },
            child: Text("Files")),
        ElevatedButton(
            style: style,
            onPressed: () {
              appState.selectedIndex = 3;
              //appState.setSelectedBookById(0);
            },
            child: Text("Issue")),
        ElevatedButton(
            style: style,
            onPressed: () {
              appState.selectedIndex = 4;
              //appState.setSelectedBookById(0);
            },
            child: Text("Forms"))
      ],
    );
  }
}
