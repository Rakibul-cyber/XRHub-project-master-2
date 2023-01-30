import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:urlnav2/layout/appshell.dart';
import 'package:urlnav2/appState.dart';
import 'package:urlnav2/pages/authentication/authenticate.dart';
import 'package:urlnav2/pages/books/selectedBookState.dart';
import 'package:urlnav2/pages/cases/selectedCaseState.dart';
import 'package:urlnav2/pages/records/widgets/selectedrecordstate.dart';
import 'package:urlnav2/pages/tasks/selectedtaskstate.dart';
import 'package:urlnav2/routes.dart';
import 'package:provider/provider.dart';

import 'my_projects/projects_home.dart';

class CVKRouterDelegate extends RouterDelegate<CVKRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<CVKRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey;

  //final GlobalKey<ScaffoldState> scaffoldKey;

  AppState appState = AppState();
  SelectedBookState selectedBookState = SelectedBookState();
  SelectedCaseState selectedCaseState = SelectedCaseState();
  SelectedTaskState selectedTaskState = SelectedTaskState();
  SelectedRecordState selectedRecordState = SelectedRecordState();

  CVKRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>() {
    appState.addListener(notifyListeners);
    selectedBookState.addListener(notifyListeners);
    selectedCaseState.addListener(notifyListeners);
    selectedTaskState.addListener(notifyListeners);
    selectedRecordState.addListener(notifyListeners);
  }

  CVKRoutePath get currentConfiguration {
    if (appState.selectedIndex == 0) {
      return ProjectHomePath();
    } else if (appState.selectedIndex == 1) {
      return DashboardPath();
    } else if (appState.selectedIndex == 2) {
      return IssuePath();
    } else if (appState.selectedIndex == 3) {
      return RFIsPath();
    } else if (appState.selectedIndex == 4) {
      return ProjectsPath();
    }

    // else if (appState.selectedIndex == 3) {
    //   if (selectedCaseState.selectedCase == null) {
    //     return NotesPath();
    //   }

    //   else {
    //     return CaseDashPath(selectedCaseState.getSelectedCaseById());
    //   }
    // } else if (appState.selectedIndex == 4) {
    //   if (selectedBookState.selectedBook == null) {
    //     return BooksListPath();
    //   } else {
    //     return BooksDetailsPath(selectedBookState.getSelectedBookById());
    //   }
    // } else if (appState.selectedIndex == 5) {
    //   return ProfilePath();
    // } else if (appState.selectedIndex == 6) {
    //   return NewClientsPath();
    // } else if (appState.selectedIndex == 7) {
    //   return NewCasesPath();
    // } else if (appState.selectedIndex == 8) {
    //   return NotesPath();
    // } else if (appState.selectedIndex == 9) {
    //   return MailPath();
    // } else if (appState.selectedIndex == 10) {
    //   return CalendarPath();
    // } else if (appState.selectedIndex == 11) {
    //   if (selectedTaskState.selectedTask == null) {
    //     return TaskPath();
    //   } else {
    //     return TaskDashpath(selectedTaskState.getSelectedTaskById());
    //   }
    // } else if (appState.selectedIndex == 12) {
    //   if (selectedRecordState.selectedrecord == null) {
    //     return RecordPath();
    //   } else {
    //     return RecordsDashPath(selectedRecordState.getSelectedrecordById());
    //   }
    // } else if (appState.selectedIndex == 14) {
    //   return ChatPath();
    // } else if (appState.selectedIndex == 15) {
    //   return FilePath();
    // } else if (appState.selectedIndex == 16) {
    //   return VideoPath();
    // }
  }

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    if (firebaseUser == null) {
      return Authenticate();
    }
    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(
          child: AppShell(
            //navigatorKey: navigatorKey,
            appState: appState,
            // selectedBookState: selectedBookState,
            // selectedCaseState: selectedCaseState,
            // selectedTaskState: selectedTaskState,
            // selectedRecordState: selectedRecordState
          ),
        ),
        // MaterialPage(child: MyProjects(navigatorKey: navigatorKey),),
      ],
      // onPopPage: (route, result) {
      //   if (!route.didPop(result)) {
      //     return false;
      //   }

      //   if (selectedBookState.selectedBook != null) {
      //     selectedBookState.selectedBook = null;
      //   }
      //   if (selectedCaseState.selectedCase != null) {
      //     selectedCaseState.selectedCase = null;
      //   }

      //   if (selectedTaskState.selectedTask != null) {
      //     selectedTaskState.selectedTask = null;
      //   }

      //   if (selectedRecordState.selectedrecord != null) {
      //     selectedRecordState.selectedrecord = null;
      //   }
      //   notifyListeners();
      //   return true;
      // },
    );
  }

  @override
  Future<void> setNewRoutePath(CVKRoutePath path) async {
    if (path is ProjectHomePath) {
      appState.selectedIndex = 0;
    } else if (path is DashboardPath) {
      appState.selectedIndex = 1;
    } else if (path is IssuePath) {
      appState.selectedIndex = 2;
    } else if (path is RFIsPath) {
      appState.selectedIndex = 3;
    } else if (path is ProjectsPath) {
      appState.selectedIndex = 4;
    }

    // else if (path is CasesPath) {
    //   appState.selectedIndex = 3;
    //   selectedCaseState.selectedCase = null;
    // } else if (path is BooksDetailsPath) {
    //   selectedBookState.setSelectedBookById(path.id);
    // } else if (path is CaseDashPath) {
    //   selectedCaseState.setSelectedCaseById(path.id);
    // } else if (path is TaskDashpath) {
    //   selectedTaskState.setSelectedTaskById(path.id);
    // } else if (path is RecordsDashPath) {
    //   selectedRecordState.setSelectedrecordById(path.id);
    // } else if (path is BooksListPath) {
    //   appState.selectedIndex = 4;
    //   selectedBookState.selectedBook = null;
    // } else if (path is ProfilePath) {
    //   appState.selectedIndex = 5;
    // } else if (path is NewClientsPath) {
    //   appState.selectedIndex = 6;
    // } else if (path is NewCasesPath) {
    //   appState.selectedIndex = 7;
    // } else if (path is NotesPath) {
    //   appState.selectedIndex = 8;
    // } else if (path is MailPath) {
    //   appState.selectedIndex = 9;
    // } else if (path is CalendarPath) {
    //   appState.selectedIndex = 10;
    // } else if (path is TaskPath) {
    //   appState.selectedIndex = 11;
    //   selectedTaskState.selectedTask = null;
    // } else if (path is RecordPath) {
    //   appState.selectedIndex = 12;
    //   selectedRecordState.selectedrecord = null;
    // } else if (path is ChatPath) {
    //   appState.selectedIndex = 14;
    // } else if (path is FilePath) {
    //   appState.selectedIndex = 15;
    // } else if (path is VideoPath) {
    //   appState.selectedIndex = 16;
    // }
  }
}
