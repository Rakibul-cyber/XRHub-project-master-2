import 'package:flutter/material.dart';
import 'package:urlnav2/my_projects/projects_home.dart';
import 'package:urlnav2/pages/books/book.dart';
import 'package:urlnav2/appState.dart';
import 'package:urlnav2/pages/books/bookdetailsScreen.dart';
import 'package:urlnav2/pages/books/bookslistScreen.dart';
import 'package:urlnav2/pages/books/selectedBookState.dart';
import 'package:urlnav2/pages/calendar/calendarPage.dart';
import 'package:urlnav2/pages/cases/addcase/cases_new_form.dart';
import 'package:urlnav2/pages/cases/addcase/cases_new_form2.dart';
import 'package:urlnav2/pages/cases/dashboard/casedashboard.dart';
import 'package:urlnav2/pages/cases/casesScreen.dart';
import 'package:urlnav2/pages/cases/selectedCaseState.dart';
import 'package:urlnav2/pages/chat/widget/chatfull.dart';
import 'package:urlnav2/pages/clientScreen.dart';
import 'package:urlnav2/fadeanimpage.dart';
import 'package:urlnav2/pages/clients/clientpage.dart';
import 'package:urlnav2/pages/clients/widgets/clients_new_form2.dart';
import 'package:urlnav2/pages/clients/widgets/clienttestweb.dart';
import 'package:urlnav2/pages/clients/widgets/reflist.dart';
import 'package:urlnav2/pages/dashboard/dashboard_home.dart';
import 'package:urlnav2/pages/dashboardScreen.dart';
import 'package:urlnav2/pages/files/fileScreenmain.dart';
import 'package:urlnav2/pages/issue/issuePage.dart';
import 'package:urlnav2/pages/mails/mail_main.dart';
import 'package:urlnav2/pages/notes/notesScreen.dart';
import 'package:urlnav2/pages/profile/profilemain.dart';
import 'package:urlnav2/pages/projects/projectPage.dart';
import 'package:urlnav2/pages/records/recordsScreen.dart';
import 'package:urlnav2/pages/records/widgets/recordsboxpage.dart';
import 'package:urlnav2/pages/records/widgets/selectedrecordstate.dart';
import 'package:urlnav2/pages/rfis/rfisPage.dart';
import 'package:urlnav2/pages/tasks/selectedtaskstate.dart';
import 'package:urlnav2/pages/tasks/taskdash.dart';
import 'package:urlnav2/pages/tasks/taskmainpage.dart';
import 'package:urlnav2/pages/tasks/widget/taskdrag.dart';
import 'package:urlnav2/pages/tasks/widget/taskdragreroute.dart';
import 'package:urlnav2/pages/tasks/widget/tastdrag2.dart';
import 'package:urlnav2/pages/videos/videos.dart';
import 'package:urlnav2/routes.dart';
import 'package:urlnav2/pages/settingsScreen.dart';

class InnerRouterDelegate extends RouterDelegate<CVKRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<CVKRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // SelectedBookState _bookState;
  // final SelectedCaseState _caseState;
  // final SelectedTaskState _taskState;
  // final SelectedRecordState _recordState;
  // SelectedBookState get bookState => _bookState;

  // set bookState(SelectedBookState value) {
  //   if (value == _bookState) {
  //     return;
  //   }
  //   _bookState = value;
  //   notifyListeners();
  // }

  AppState _appState;
  AppState get appState => _appState;

  set appState(AppState value) {
    if (value == _appState) {
      return;
    }
    _appState = value;
    notifyListeners();
  }

  InnerRouterDelegate(this._appState, 

  //
  //this._taskState, this._recordState, 
  
  // this._bookState, this._caseState,
  //     this._taskState, this._recordState
      
      );

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        if (appState.selectedIndex == 0) ...[
          FadeAnimationPage(
            child: ProjectHomePage(
              appState: appState,
            ),
            key: ValueKey('ProjectHomePage'),
          ),
        ] else if (appState.selectedIndex == 1) ...[
          FadeAnimationPage(
            
            child: DashboardHomePage(
              appState: appState,
            ),
            key: ValueKey('DashboardPage'),
          ),
        ] else if (appState.selectedIndex == 2) ...[
          FadeAnimationPage(
            child: IssuePage(),
            key: ValueKey('IssuePage'),
          ),
        ]else if (appState.selectedIndex == 3) ...[
          FadeAnimationPage(
            child: RFIsPage(
              
            ),
            key: ValueKey('RFIsPage'),
          ),
        ] else if (appState.selectedIndex == 4) ...[
          
            FadeAnimationPage(
              child: ProjectPage(
                
              ),
              key: ValueKey('ProjectPage'),
            ),
           
        ],

        //  else if (appState.selectedIndex == 4) ...[
        //   FadeAnimationPage(
        //     child: BooksListScreen(
        //       bookState: _bookState,
        //     ),
        //     key: ValueKey('BooksListPage'),
        //   ),
        //   if (_bookState.selectedBook != null)
        //     FadeAnimationPage(
        //       child: BookDetailsScreen(book: _bookState.selectedBook),
        //       key: ValueKey(_bookState.selectedBook),
        //     ),
        //   //MaterialPage(
        //   //  key: ValueKey(appState.selectedBook),
        //   //  child: BookDetailsScreen(book: appState.selectedBook),
        //   //),
        // ] else if (appState.selectedIndex == 5) ...[
        //   FadeAnimationPage(
        //     child: ProfileMainPage(
        //       appState: appState,
        //     ),
        //     key: ValueKey('ProfilePage'),
        //   ),
        // ] else if (appState.selectedIndex == 6) ...[
        //   FadeAnimationPage(
        //     child: ClientformWeb(
        //       appState: appState,
        //     ),
        //     key: ValueKey('ClientForm'),
        //   ),
        // ] else if (appState.selectedIndex == 7) ...[
        //   FadeAnimationPage(
        //     child: CasesAddForm(
        //       appState: appState,
        //     ),
        //     key: ValueKey('CasesForm'),
        //   ),
        // ] else if (appState.selectedIndex == 8) ...[
        //   FadeAnimationPage(
        //     child: NotesMainPage(
        //       appState: appState,
        //     ),
        //     key: ValueKey('NotesPage'),
        //   ),
        // ] else if (appState.selectedIndex == 9) ...[
        //   FadeAnimationPage(
        //     child: MailPage(
        //       appState: appState,
        //     ),
        //     key: ValueKey('MailPage'),
        //   ),
        // ] else if (appState.selectedIndex == 10) ...[
        //   FadeAnimationPage(
        //     child: CalendarPage(
        //       appState: appState,
        //     ),
        //     key: ValueKey('CalendarPage'),
        //   ),
        // ] else if (appState.selectedIndex == 11) ...[
        //   FadeAnimationPage(
        //     child: TaskScreen(
        //       appState: appState,
        //       selectedTaskState: _taskState,
        //     ),
        //     key: ValueKey('TasksPage'),
        //   ),
        //   if (_taskState.selectedTask != null)
        //     FadeAnimationPage(
        //       child: DragTask2(
        //         myindex: _taskState,
        //         appState: appState,
        //       ),
        //       key: ValueKey(_taskState.selectedTask),
        //     ),
        // ] else if (appState.selectedIndex == 12) ...[
        //   FadeAnimationPage(
        //     child: RecordPage(
        //         appState: appState, selectedRecordState: _recordState),
        //     key: ValueKey('RecordPage'),
        //   ),
        //   if (_recordState.selectedrecord != null)
        //     FadeAnimationPage(
        //       child: RecordBoxScreen(
        //         appState: appState,
        //         recordState: _recordState,
        //       ),
        //       key: ValueKey(_taskState.selectedTask),
        //     ),
        // ] else if (appState.selectedIndex == 14) ...[
        //   FadeAnimationPage(
        //     child: ChatFullPage(
        //       appState: appState,
        //     ),
        //     key: ValueKey('ChatPage'),
        //   ),
        // ] else if (appState.selectedIndex == 15) ...[
        //   FadeAnimationPage(
        //     child: FilePageMain(
        //       appState: appState,
        //       //myindex: _taskState,
        //     ),
        //     key: ValueKey('FilePage'),
        //   ),
        // ] else if (appState.selectedIndex == 16) ...[
        //   FadeAnimationPage(
        //     child: VideosPage(
        //       roomname: "CVKMeeting${appState.myid}",
        //       appState: appState,
        //       //myindex: _taskState,
        //     ),
        //     key: ValueKey('VideosPage'),
        //   ),
        // ]
      ],
      // onPopPage: (route, result) {
      //   _bookState.selectedBook = null;
      //   notifyListeners();
      //   return route.didPop(result);
      // },
    );
  }

  @override
  Future<void> setNewRoutePath(CVKRoutePath path) async {
    // This is not required for inner router delegate because it does not
    // parse route
    assert(false);
  }

  //void _handleBookTapped(Book book) {
  //  _appState.selectedBook = book;
  //  notifyListeners();
  //}
}
