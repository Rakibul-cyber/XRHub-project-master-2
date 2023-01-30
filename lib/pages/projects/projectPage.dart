import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../../constants/style.dart';
import 'project_from.dart';

class ProjectPage extends StatefulWidget {
  const ProjectPage({Key key}) : super(key: key);

  @override
  State<ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  Stream<QuerySnapshot> users;
  final user = FirebaseAuth.instance;
  final firebaseFirestore = FirebaseFirestore.instance;
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
    return Container(
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
    );
  }

  Column MainMethod(BuildContext context, QuerySnapshot<Object> data) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        MediaQuery.of(context).size.width > 735
            ? Container(
                child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Projects",
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [
                            Icon(
                              AntDesign.delete,
                              color: Colors.blue,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Deleted projects',
                                style: TextStyle(
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                            Icon(
                              MaterialIcons.list_alt,
                              color: Colors.blue,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Publish log',
                                style: TextStyle(
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                            Icon(
                              AntDesign.menuunfold,
                              color: Colors.blue,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Settings',
                                style: TextStyle(
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                            Icon(
                              FontAwesome.caret_down,
                              color: Colors.blue,
                              size: 12,
                            ),
                          ],
                        ),
                        const Divider(
                            color: Color.fromARGB(255, 195, 196, 197)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ProjectFormPopup(),

                            // hjadfgjdhjfhsgh
                            ///hjgfgsdhfg
                            ///hjdgfgsdhf
                            SizedBox(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton.icon(
                                  onPressed: () {},
                                  icon: const Icon(AntDesign.export),
                                  label: const Text("Export All"),
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: const Color.fromARGB(
                                        255, 166, 167, 168),
                                    backgroundColor: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                ElevatedButton.icon(
                                  onPressed: () {},
                                  icon: const Icon(AntDesign.search1),
                                  label:
                                      const Text("Search by issue title or id"),
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: const Color.fromARGB(
                                        255, 166, 167, 168),
                                    backgroundColor: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                ElevatedButton.icon(
                                  onPressed: () {},
                                  icon: const Icon(AntDesign.filter),
                                  label: const Text(""),
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: const Color.fromARGB(
                                        255, 166, 167, 168),
                                    backgroundColor: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                ElevatedButton.icon(
                                  onPressed: () {},
                                  icon: const Icon(AntDesign.appstore_o),
                                  label: const Text(""),
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: const Color.fromARGB(
                                        255, 166, 167, 168),
                                    backgroundColor: Colors.white,
                                  ),
                                ),
                                ElevatedButton.icon(
                                  onPressed: () {},
                                  icon: const Icon(Ionicons.menu_sharp),
                                  label: const Text(""),
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: const Color.fromARGB(
                                        255, 166, 167, 168),
                                  ),
                                ),
                              ],
                            )),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 15, 20, 5),
                          child: Row(
                            // ignore: prefer_const_literals_to_create_immutables
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 4,
                                child: Row(
                                  children: [
                                    Icon(
                                      Fontisto.checkbox_passive,
                                      size: 10,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    const Text(
                                      'Number',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 4,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      "Version set",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'Discipline',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'Tag',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 6,
                                child: Text(
                                  'Updated by',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                            color: Color.fromARGB(255, 195, 196, 197)),
                        SizedBox(
                          height: 20,
                        ),
                        data.docs.isEmpty
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      SvgPicture.asset(
                                        'images/project_files.svg',
                                        height: 200,
                                        width: 200,
                                      ),
                                      const Center(
                                        child: Text(
                                          '''There aren't any published projects yet''',
                                          style: TextStyle(
                                            fontSize: 21,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          TextButton(
                                              child: Text('Add projects'),
                                              style: TextButton.styleFrom(
                                                foregroundColor: Colors.blue,
                                              ),
                                              onPressed: () {}),
                                          Text("or publish from "),
                                          TextButton(
                                              child: Text('Files'),
                                              style: TextButton.styleFrom(
                                                foregroundColor: Colors.blue,
                                              ),
                                              onPressed: () {}),
                                        ],
                                      )
                                    ]),
                              )
                            : GridView.builder(
                          shrinkWrap: true,
                          itemCount: data.size,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount:
                                MediaQuery.of(context).orientation ==
                                        Orientation.landscape
                                    ? 3
                                    : 2,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                            childAspectRatio: (2 / 1),
                          ),
                          itemBuilder: (
                            context,
                            index,
                          ) {
                            return GestureDetector(
                              onTap: () {
                                // Navigator.of(context).pushNamed(RouteName.GridViewCustom);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: greyBc,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      //Icon(items[index].icon),
                                      //Text(items[index].title,style: TextStyle(fontSize: 18, color: Colors.black),
                                      // textAlign: TextAlign.center),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '${data.docs[index]['titleController']}',
                                            style: TextStyle(
                                              color: blue,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                height: 8,
                                                width: 8,
                                                decoration: const BoxDecoration(
                                                  color: Colors.green,
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              const Text(
                                                'Open',
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),

                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Expanded(
                                            child: Text(
                                                '''${data.docs[index]['descriptionController']}'''),
                                          ),
                                        ),
                                      ),

                                      Expanded(child: Container()),

                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          TextButton(
                                              onPressed: () {},
                                              child: const Text(
                                                'View Details',
                                                style: TextStyle(color: blue),
                                              )),
                                          TextButton.icon(
                                              onPressed: () {},
                                              icon: const Icon(
                                                Icons.done,
                                                color: Colors.green,
                                              ),
                                              label: const Text(
                                                'Solved',
                                                style: TextStyle(
                                                    color: Colors.green),
                                              )),
                                          ElevatedButton.icon(
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  // return object of type Dialog
                                                  return AlertDialog(
                                                    title:
                                                        Text("Confirm Delete"),
                                                    content: Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              4,
                                                      child:
                                                          SingleChildScrollView(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Text(
                                                                'Are you sure you want to delete this issue? Once deleted, it cannot be recovered.'),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    actions: <Widget>[
                                                      ElevatedButton(
                                                        child: const Text(
                                                            "Cancel"),
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                //backgroundColor: Colors.white,

                                                                ),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
                                                      // usually buttons at the bottom of the dialog
                                                      ElevatedButton(
                                                        child: const Text(
                                                            "Delete"),
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              Colors.red[500],
                                                        ),
                                                        onPressed: () {
                                                          data.docs[index]
                                                              .reference
                                                              .delete();
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            label: const Text('Delete'),
                                            icon: const Icon(Icons.delete),
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Colors.red[500]),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ]),
                ),
              ))
            : Center(
                child: Container(
                    child: Column(
                children: [
                  Icon(
                    MaterialIcons.laptop,
                    size: 100,
                    color: lightGrey,
                  ),
                  Text('Use Laptop to view the content'),
                ],
              ))),
      ],
    );
  }
}
