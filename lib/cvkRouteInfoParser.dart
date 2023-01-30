import 'package:flutter/material.dart';
import 'package:urlnav2/constants/myconstants.dart';
import 'package:urlnav2/main.dart';
import 'package:urlnav2/pages/tasks/widget/taskdragreroute.dart';
import 'package:urlnav2/routes.dart';

class CVKRouteInformationParser extends RouteInformationParser<CVKRoutePath> {
  @override
  Future<CVKRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location);

    if (uri.pathSegments.isNotEmpty && uri.pathSegments.first == 'projecthome') {
      sideMenuController.changeActiveItemTo('ProjectHome');
      return ProjectHomePath();
    }else if (uri.pathSegments.isNotEmpty &&
        uri.pathSegments.first == 'dashboard') {
      sideMenuController.changeActiveItemTo('Dashboard');
      return DashboardPath();
    } else if (uri.pathSegments.isNotEmpty &&
        uri.pathSegments.first == 'issue') {
      sideMenuController.changeActiveItemTo('Issue');
      return IssuePath();
    } else if (uri.pathSegments.isNotEmpty &&
        uri.pathSegments.first == 'rfis') {
      sideMenuController.changeActiveItemTo('RFIs');
      return RFIsPath();
    } else if (uri.pathSegments.isNotEmpty &&
        uri.pathSegments.first == 'projects') {
      sideMenuController.changeActiveItemTo('Projects');
      return ProjectsPath();
    } 
    
    // else if (uri.pathSegments.isNotEmpty &&
    //     uri.pathSegments.first == 'books') {
    //   sideMenuController.changeActiveItemTo('Books');
    //   return BooksListPath();
    // } else if (uri.pathSegments.isNotEmpty &&
    //     uri.pathSegments.first == 'profile') {
    //   sideMenuController.changeActiveItemTo('Profile');
    //   return ProfilePath();
    // } else if (uri.pathSegments.isNotEmpty &&
    //     uri.pathSegments.first == 'createclient') {
    //   //sideMenuController.changeActiveItemTo('Clients');
    //   return NewClientsPath();
    // } else if (uri.pathSegments.isNotEmpty &&
    //     uri.pathSegments.first == 'createcase') {
    //   //sideMenuController.changeActiveItemTo('Clients');
    //   return NewCasesPath();
    // } else if (uri.pathSegments.isNotEmpty &&
    //     uri.pathSegments.first == 'notes') {
    //   sideMenuController.changeActiveItemTo('Notes');
    //   return NotesPath();
    // } else if (uri.pathSegments.isNotEmpty &&
    //     uri.pathSegments.first == 'mailing') {
    //   sideMenuController.changeActiveItemTo('Mails');
    //   return MailPath();
    // } else if (uri.pathSegments.isNotEmpty &&
    //     uri.pathSegments.first == 'calendar') {
    //   sideMenuController.changeActiveItemTo('Calendar');
    //   return CalendarPath();
    // } else if (uri.pathSegments.isNotEmpty &&
    //     uri.pathSegments.first == 'tasks') {
    //   sideMenuController.changeActiveItemTo('Tasks');
    //   return TaskPath();
    // } else if (uri.pathSegments.isNotEmpty &&
    //     uri.pathSegments.first == 'records') {
    //   sideMenuController.changeActiveItemTo('Records');
    //   return RecordPath();
    // } else if (uri.pathSegments.isNotEmpty &&
    //     uri.pathSegments.first == 'files') {
    //   sideMenuController.changeActiveItemTo('Files');
    //   return FilePath();
    // } else if (uri.pathSegments.isNotEmpty &&
    //     uri.pathSegments.first == 'chats') {
    //   sideMenuController.changeActiveItemTo('Chats');
    //   return ChatPath();
    // } else if (uri.pathSegments.isNotEmpty &&
    //     uri.pathSegments.first == 'videos') {
    //   sideMenuController.changeActiveItemTo('Videos');
    //   return VideoPath();
    // } else {
    //   if (uri.pathSegments.length == 2) {
    //     if (uri.pathSegments[0] == 'book') {
    //       return BooksDetailsPath(int.tryParse(uri.pathSegments[1]));
    //     } else if (uri.pathSegments[0] == 'cases') {
    //       return CaseDashPath(0);
    //     } else if (uri.pathSegments[0] == 'tasks') {
    //       return TaskDashpath(int.tryParse(uri.pathSegments[1]));
    //     } else if (uri.pathSegments[0] == 'records') {
    //       return RecordsDashPath(int.tryParse(uri.pathSegments[1]));
    //     }
    //   }
    // }
  }
  /*@override
  Future<CVKRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location);

    if (uri.pathSegments.length == 0) {
      sideMenuController.changeActiveItemTo('Dashboard');
      return DashboardPath();
    } else if (uri.pathSegments.length == 1) {
      if (uri.pathSegments.isNotEmpty &&
          uri.pathSegments.first == 'dashboard') {
        sideMenuController.changeActiveItemTo('Dashboard');
        return DashboardPath();
      } else if (uri.pathSegments.isNotEmpty &&
          uri.pathSegments.first == 'settings') {
        sideMenuController.changeActiveItemTo('Settings');
        return SettingsPath();
      } else if (uri.pathSegments.isNotEmpty &&
          uri.pathSegments.first == 'clients') {
        sideMenuController.changeActiveItemTo('Clients');
        return ClientsPath();
      } else if (uri.pathSegments.isNotEmpty &&
          uri.pathSegments.first == 'cases') {
        sideMenuController.changeActiveItemTo('Cases');
        return CasesPath();
      } else if (uri.pathSegments.isNotEmpty &&
          uri.pathSegments.first == 'books') {
        sideMenuController.changeActiveItemTo('Books');
        return BooksListPath();
      } else if (uri.pathSegments.isNotEmpty &&
          uri.pathSegments.first == 'profile') {
        sideMenuController.changeActiveItemTo('Profile');
        return ProfilePath();
      } else if (uri.pathSegments.isNotEmpty &&
          uri.pathSegments.first == 'createclient') {
        //sideMenuController.changeActiveItemTo('Clients');
        return NewClientsPath();
      } else if (uri.pathSegments.isNotEmpty &&
          uri.pathSegments.first == 'createcase') {
        //sideMenuController.changeActiveItemTo('Clients');
        return NewCasesPath();
      } else if (uri.pathSegments.isNotEmpty &&
          uri.pathSegments.first == 'notes') {
        sideMenuController.changeActiveItemTo('Notes');
        return NotesPath();
      } else if (uri.pathSegments.isNotEmpty &&
          uri.pathSegments.first == 'mailing') {
        sideMenuController.changeActiveItemTo('Mails');
        return MailPath();
      } else if (uri.pathSegments.isNotEmpty &&
          uri.pathSegments.first == 'calendar') {
        sideMenuController.changeActiveItemTo('Calendar');
        return CalendarPath();
      } else if (uri.pathSegments.isNotEmpty &&
          uri.pathSegments.first == 'tasks') {
        sideMenuController.changeActiveItemTo('Tasks');
        return TaskPath();
      } else if (uri.pathSegments.isNotEmpty &&
          uri.pathSegments.first == 'records') {
        sideMenuController.changeActiveItemTo('Records');
        return RecordPath();
      } else if (uri.pathSegments.isNotEmpty &&
          uri.pathSegments.first == 'files') {
        sideMenuController.changeActiveItemTo('Files');
        return FilePath();
      } else if (uri.pathSegments.isNotEmpty &&
          uri.pathSegments.first == 'chats') {
        sideMenuController.changeActiveItemTo('Chats');
        return ChatPath();
      } else if (uri.pathSegments.isNotEmpty &&
          uri.pathSegments.first == 'videos') {
        sideMenuController.changeActiveItemTo('Videos');
        return VideoPath();
      }
    } else if (uri.pathSegments.length == 2) {
      if (uri.pathSegments[0] == 'book') {
        return BooksDetailsPath(int.tryParse(uri.pathSegments[1]));
      } else if (uri.pathSegments[0].toLowerCase() == 'case') {
        return CaseDashPath(int.tryParse(uri.pathSegments[1]));
      } else if (uri.pathSegments[0].toLowerCase() == 'tasks') {
        return TaskDashpath(int.tryParse(uri.pathSegments[1]));
      } else if (uri.pathSegments[0].toLowerCase() == 'records') {
        return RecordsDashPath(int.tryParse(uri.pathSegments[1]));
      }
    } else {
      sideMenuController.changeActiveItemTo('Dashboard');
      return DashboardPath();
    }
  }*/ 

  @override
  RouteInformation restoreRouteInformation(CVKRoutePath configuration) {
    if (configuration is ProjectHomePath) {
      return RouteInformation(location: '/projecthome');
    }
    if (configuration is DashboardPath) {
      return RouteInformation(location: '/dashboard');
    }
    if (configuration is IssuePath) {
      return RouteInformation(location: '/issue');
    }
    if (configuration is RFIsPath) {
      return RouteInformation(location: '/RFIs');
    }
    if (configuration is ProjectsPath) {
      return RouteInformation(location: '/projects');
    }
    // if (configuration is BooksListPath) {
    //   return RouteInformation(location: '/books');
    // }
    // if (configuration is ProfilePath) {
    //   return RouteInformation(location: '/profile');
    // }
    // if (configuration is NewClientsPath) {
    //   return RouteInformation(location: '/createclient');
    // }
    // if (configuration is NewCasesPath) {
    //   return RouteInformation(location: '/createcases');
    // }
    // if (configuration is NotesPath) {
    //   return RouteInformation(location: '/notes');
    // }
    // if (configuration is MailPath) {
    //   return RouteInformation(location: '/mailing');
    // }
    // if (configuration is CalendarPath) {
    //   return RouteInformation(location: '/calendar');
    // }
    // if (configuration is TaskPath) {
    //   return RouteInformation(location: '/tasks');
    // }
    // if (configuration is RecordPath) {
    //   return RouteInformation(location: '/records');
    // }
    // if (configuration is BooksDetailsPath) {
    //   return RouteInformation(location: '/book/${configuration.id}');
    // }
    // if (configuration is CaseDashPath) {
    //   return RouteInformation(location: '/cases/${configuration.id}');
    // }
    // if (configuration is TaskDashpath) {
    //   return RouteInformation(location: '/tasks/${configuration.id}');
    // }
    // if (configuration is RecordsDashPath) {
    //   return RouteInformation(location: '/records/${configuration.id}');
    // }
    // if (configuration is FilePath) {
    //   return RouteInformation(location: '/files');
    // }
    // if (configuration is ChatPath) {
    //   return RouteInformation(location: '/chats');
    // }
    // if (configuration is VideoPath) {
    //   return RouteInformation(location: '/videos');
    // }

    return null;
  }
}
