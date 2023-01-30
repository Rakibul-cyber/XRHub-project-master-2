import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:universal_html/html.dart';
import 'package:urlnav2/constants/style.dart';
import 'package:urlnav2/layout/appshell.dart';

import '../appState.dart';
import '../constants/myconstants.dart';
import '../layout/sidebar/sideMenuItem.dart';
import '../layout/sidebar/sidemenucontroller.dart';
import 'create_new_project_form.dart';

class ProjectHomePage extends StatefulWidget {
  final AppState appState;
  final GlobalKey<NavigatorState> navigatorKey;
  const ProjectHomePage({this.appState, this.navigatorKey});

  @override
  State<ProjectHomePage> createState() => _ProjectHomePageState();
}

class _ProjectHomePageState extends State<ProjectHomePage> {
  SideMenuController instance = Get.find();
  //final database = 0;
  var sideLength = 50;
  List projects = [];
  Stream<QuerySnapshot> users;
  final user = FirebaseAuth.instance;
  final firebaseFirestore = FirebaseFirestore.instance;
  var checkOpenOrDelete = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    users = FirebaseFirestore.instance
        .collection('users')
        .doc(user.currentUser.uid)
        .collection('createProject')
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
            stream: users,
            builder: (
              BuildContext context,
              AsyncSnapshot<QuerySnapshot> snapshot,
            ) {
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              final data = snapshot.requireData;

              return Column(
                children: [
                  Expanded(
                    child: MainMethod(context, data),
                  ),
                ],
              );
            }),
      ),
    );
  }

  SingleChildScrollView MainMethod(
      BuildContext context, QuerySnapshot<Object> data) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(
                "assets/images/logo.png",
                width: 305,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 25,
              ),
              data.docs.isEmpty
                  ? Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/images/body_image.svg',
                            theme: const SvgTheme(currentColor: Colors.green),
                            fit: BoxFit.none,
                            
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'No project to display',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          MediaQuery.of(context).size.width > 771
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      '''Contact an administrator to create a project and invite you to it. For more information, visit the''',
                                      softWrap: true,
                                      textAlign: TextAlign.center,
                                    ),
                                    TextButton(
                                      child: const Text(
                                        'Help Site',
                                        style: TextStyle(
                                          color: Color(0xFF358CDA),
                                        ),
                                      ),
                                      onPressed: () {},
                                    )
                                  ],
                                )
                              : Column(
                                  children: [
                                    const Text(
                                      '''Contact an administrator to create a project and invite you to it. For more information, visit the''',
                                      softWrap: true,
                                      textAlign: TextAlign.center,
                                    ),
                                    TextButton(
                                      child: const Text(
                                        'Help Site',
                                        style: TextStyle(
                                          color: Color(0xFF358CDA),
                                        ),
                                      ),
                                      onPressed: () {},
                                    )
                                  ],
                                ),
                        ],
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 70),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width > 990
                                ? MediaQuery.of(context).size.width / 4
                                : double.infinity,
                            child: const TextField(
                              decoration: InputDecoration(
                                // filled: true,
                                fillColor: Color(0xFFFFFFFF),

                                prefixIcon:
                                    Icon(Icons.search, color: lightGrey),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: lightGrey,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(4),
                                  ),
                                ),
                                hintText: 'Search project by Name',
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 350,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(4),
                                ),
                                border: Border.all(width: 1, color: lightGrey)),
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            decoration: const BoxDecoration(
                                                border: Border(
                                                    right: BorderSide(
                                              color: lightGrey,
                                              width: 1,
                                            ))),
                                            child: const Text(
                                              'Projects',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          flex: 2,
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        const Expanded(
                                          child: Text('Date Created',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          flex: 1,
                                        ),
                                      ],
                                    ),
                                    const Divider(),
                                    ListView.builder(
                                        itemCount: data.docs.length,
                                        shrinkWrap: true,
                                        // padding: EdgeInsets.symmetric(vertical: 10),

                                        itemBuilder: ((context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 0),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: AnimatedContainer(
                                                    decoration: const BoxDecoration(
                                                        border: Border(
                                                            right: BorderSide(
                                                      color: lightGrey,
                                                      width: 1,
                                                    ))),
                                                    duration:
                                                        const Duration(seconds: 2),
                                                    curve: Curves.easeIn,
                                                    child: InkWell(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 10,
                                                                horizontal: 5),
                                                        child: Text(
                                                          '${data.docs[index]['titleController']}',
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal),
                                                        ),
                                                      ),
                                                      onTap: () {
                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            // return object of type Dialog
                                                            return AlertDialog(
                                                              title: const Text(
                                                                  "Open / Delete"),
                                                              content:
                                                                  Container(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width /
                                                                    4,
                                                                child:
                                                                    SingleChildScrollView(
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: <
                                                                    
                                                                        Widget>[
                                                                      
                                                                      const Text(
                                                                          'Click open button to check project details or press delete to remove project'),
                                                                          SizedBox(height: 10,),
                                                                          Center(
                                                                            child: Text(
                                                                '* Once deleted, it cannot be recovered.', style: TextStyle(fontSize: 12, color: Colors.red[300]),),
                                                                          ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              actions: <Widget>[
                                                                
                                                                // usually buttons at the bottom of the dialog
                                                                ElevatedButton(
                                                                  child: const Text(
                                                                      "Delete"),
                                                                  style: ElevatedButton
                                                                      .styleFrom(
                                                                    backgroundColor:
                                                                        Colors.red[
                                                                            500],
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                        
                                                                    
                                                                    

                                                                   data.docs[index].reference.delete();
                                                                   Navigator.of(context).pop();
                                                                            
                                                                  },
                                                                ),

                                                                ElevatedButton(
                                                                  child:
                                                                      const Text(
                                                                          "Open"),
                                                                  style: ElevatedButton
                                                                      .styleFrom(
                                                                          //backgroundColor: Colors.white,

                                                                          ),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                    instance.changeActiveItemTo(
                                                                        "Dashboard");
                                                                    widget
                                                                        .appState
                                                                        .selectedIndex = 1;
                                                                  },
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  flex: 2,
                                                ),
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                      '${data.docs[index]['startDateController']}',
                                                      style: const TextStyle(
                                                          fontWeight: FontWeight
                                                              .normal)),
                                                  flex: 1,
                                                ),
                                              ],
                                            ),
                                          );
                                        })),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
              SizedBox(
                height: projects.isNotEmpty
                    ? MediaQuery.of(context).size.height / 20
                    : MediaQuery.of(context).size.height / 8,
              ),
              CreateFormButton(),
              // ElevatedButton(
              //   style: ElevatedButton.styleFrom(
              //       minimumSize:
              //           Size(200, 50) // put the width and height you want
              //       ),
              //   onPressed: () {
              //     instance.changeActiveItemTo("Dashboard");
              //     widget.appState.selectedIndex = 1;
              //     print(instance.activeItem);
              //   },
              //   child: Text('Create new propject'),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
