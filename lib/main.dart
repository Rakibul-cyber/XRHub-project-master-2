import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
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
  Firebase.initializeApp(
    name: 'SecondaryApp',
    options: const FirebaseOptions(
        apiKey: "AIzaSyDRqlzCHiXfdFbOHNO5-Mhej_L5oIXiw0k",
        authDomain: "xrhub-2b4f5.firebaseapp.com",
        projectId: "xrhub-2b4f5",
        storageBucket: "xrhub-2b4f5.appspot.com",
        messagingSenderId: "231808537332",
        appId: "1:231808537332:web:63e8112e39f87cb20f04a1"),
  );
  setPathUrlStrategy();
  Get.put(SideMenuController());
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  CVKRouterDelegate _routerDelegate = CVKRouterDelegate();
  CVKRouteInformationParser _routeInformationParser =
      CVKRouteInformationParser();
  @override
  Widget build(BuildContext context) {
    return myAuthWidget();
  }

  Widget myAuthWidget() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          //initialData: User,
          create: (context) =>
              context.read<AuthenticationService>().authStateChanges,
        )
      ],
      child: MaterialApp.router(
        title: 'CVK',
        debugShowCheckedModeBanner: false,
        routerDelegate: _routerDelegate,
        routeInformationParser: _routeInformationParser,
        theme: ThemeData(
          scaffoldBackgroundColor: lightest,
          fontFamily: 'ArtifaktElement',
          primarySwatch: kPrimaryColor,
        ),
      ),
    );
  }
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          //initialData: User,
          create: (context) =>
              context.read<AuthenticationService>().authStateChanges,
        )
      ],
      child: MaterialApp.router(
        title: 'CVK',
        debugShowCheckedModeBanner: false,
        routerDelegate: _routerDelegate,
        routeInformationParser: _routeInformationParser,
        theme: ThemeData(
          scaffoldBackgroundColor: light,
          primarySwatch: Colors.deepPurple,
          fontFamily: 'ArtifaktElement',
        ),
      ),
    );
  }
}
