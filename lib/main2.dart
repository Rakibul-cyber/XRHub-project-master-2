import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:urlnav2/constants/style.dart';
import 'package:urlnav2/cvkRouteInfoParser.dart';
import 'package:urlnav2/cvkRouterDelegate.dart';
import 'package:urlnav2/helpers/services/authentication_service.dart';
import 'package:urlnav2/layout/sidebar/sidemenucontroller.dart';
import 'package:urlnav2/pages/authentication/authenticate.dart';

void main() {
  setPathUrlStrategy();
  Get.put(SideMenuController());
  //runApp(MyApp());
}

class MyApp2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return myAuthWidget();
  }
}

Widget myAuthWidget() {
  return MultiProvider(
    providers: [
      Provider<AuthenticationService>(
        create: (_) => AuthenticationService(FirebaseAuth.instance),
      ),
      StreamProvider(
        //initialData: User,
        create: (context) =>
            context.read<AuthenticationService>().authStateChanges,
      )
    ],
    child: MaterialApp(
      //scrollBehavior: MyCustomScrollBehavior(),
      debugShowCheckedModeBanner: false,
      home: MyNestedRouter(),
    ),
  );
}

class MyNestedRouter extends StatefulWidget {
  @override
  _MyNestedRouterState createState() => _MyNestedRouterState();
}

class _MyNestedRouterState extends State<MyNestedRouter> {
  CVKRouterDelegate _routerDelegate = CVKRouterDelegate();
  CVKRouteInformationParser _routeInformationParser =
      CVKRouteInformationParser();

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    if (firebaseUser != null) {
      return MaterialApp.router(
        title: 'CVK2',
        debugShowCheckedModeBanner: false,
        routerDelegate: _routerDelegate,
        routeInformationParser: _routeInformationParser,
        theme: ThemeData(
          scaffoldBackgroundColor: light,
          fontFamily: 'ArtifaktElement',
        ),
      );
    }
    return Authenticate();
  }
}
