import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:urlnav2/constants/style.dart';
import 'create_issue_popup.dart';

class IssuePage extends StatefulWidget {
  const IssuePage({Key key}) : super(key: key);

  @override
  State<IssuePage> createState() => _IssuePageState();
}

class _IssuePageState extends State<IssuePage> {
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
        .collection('createIssue')
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

  Container MainMethod(BuildContext context, QuerySnapshot<Object> data) {
    return Container(
      child: MediaQuery.of(context).size.width > 735 ?
      
      Container(
          color: white,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Issue",
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color.fromARGB(255, 195, 196, 197))),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Manage your project's issues here",
                                  style: TextStyle(
                                      fontSize: 28, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 05),
                                Column(
                                  children: const [
                                    Text(
                                        "Track and manage all of your project's outstanding issues within Autodesk Build")
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        ElevatedButton(
                                          child: const Text('Take the tour'),
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                            foregroundColor: Colors.white,
                                            backgroundColor: const Color.fromARGB(
                                                255, 8, 162, 149),
                                          ),
                                        ),
                                        TextButton(
                                          child: const Text('Learn more'),
                                          style: TextButton.styleFrom(
                                            foregroundColor: Colors.teal,
                                          ),
                                          onPressed: () {},
                                        ),
                                        TextButton(
                                          child:
                                              const Text('Register for course'),
                                          style: TextButton.styleFrom(
                                            foregroundColor: Colors.teal,
                                          ),
                                          onPressed: () {},
                                        )
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                            Image.asset(
                              'assets/images/documents.png',
                              height: 100,
                              width: 100,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Icon(
                          AntDesign.menuunfold,
                          color: blue,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Settings',
                            style: TextStyle(color: blue),
                          ),
                        ),
                        Icon(
                          FontAwesome.caret_down,
                          color: blue,
                          size: 12,
                        ),
                      ],
                    ),
                    const Divider(color: Color.fromARGB(255, 195, 196, 197)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IssuePopUp(),

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
                                foregroundColor:
                                    const Color.fromARGB(255, 166, 167, 168),
                                backgroundColor: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton.icon(
                              onPressed: () {},
                              icon: const Icon(AntDesign.search1),
                              label: const Text("Search by issue title or id"),
                              style: ElevatedButton.styleFrom(
                                foregroundColor:
                                    const Color.fromARGB(255, 166, 167, 168),
                                backgroundColor: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton.icon(
                              onPressed: () {},
                              icon: const Icon(AntDesign.filter),
                              label: const Text(""),
                              style: ElevatedButton.styleFrom(
                                foregroundColor:
                                    const Color.fromARGB(255, 166, 167, 168),
                                backgroundColor: Colors.white,
                              ),
                            ),
                          ],
                        )),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    data.docs.isEmpty
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                                Image.asset(
                                  'assets/images/folder.png',
                                  height: 200,
                                  width: 200,
                                ),
                                const Center(
                                  child: Text(
                                    "There are no issues on this project",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const Center(
                                  child: Text(
                                      "All issues created for this project will appear here.Create new issues from this page or directly from a sheet or model"),
                                ),
                              ])
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
          )) : Center(
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
    );
  }
}
