import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:urlnav2/appState.dart';
import 'package:urlnav2/constants/custom_text.dart';
import 'package:urlnav2/constants/style.dart';
import 'package:urlnav2/pages/cases/dashboard/cases_dashboard.dart';
import 'package:urlnav2/pages/cases/selectedCaseState.dart';

class CaseDashboardScreen extends StatefulWidget {
  final SelectedCaseState myindex;
  final AppState appState;

  CaseDashboardScreen({Key key, this.myindex, this.appState}) : super(key: key);

  @override
  State<CaseDashboardScreen> createState() => _CaseDashboardScreenState();
}

class _CaseDashboardScreenState extends State<CaseDashboardScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(paddingMain),
            child: caseslist(context),
          ),
        ],
      ),
    );
  }

  Widget caseslist(BuildContext context) {
    return CaseDashboardPage(
      caseNo: widget.myindex.selectedCase,
      appState: widget.appState,
    );
  }
}
