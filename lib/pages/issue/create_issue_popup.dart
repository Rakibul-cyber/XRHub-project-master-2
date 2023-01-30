import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../../constants/style.dart';

class IssuePopUp extends StatelessWidget {
  IssuePopUp({Key key}) : super(key: key);

  final TextEditingController titleController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController assignController = TextEditingController();
  final TextEditingController watchController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController locationDeatilsController =
      TextEditingController();
  final TextEditingController dueDateController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController placementController = TextEditingController();
  final TextEditingController rootCauseController = TextEditingController();

  final user = FirebaseAuth.instance;
  final firebaseFirestore = FirebaseFirestore.instance;

  // user defined function
  void _showDialog(context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: const Center(child: Text("Create issue")),
          content: Container(
            width: MediaQuery.of(context).size.width / 3,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: const [
                      Text(
                        "Title",
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                      Text(
                        "*",
                        style: TextStyle(color: Colors.red),
                      )
                    ],
                  ),
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: (BorderSide(
                            width: 1,
                            color: Color.fromARGB(255, 155, 154, 154))),
                      ),
                      labelText: 'Commissioning',
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 214, 212, 212)),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "Status",
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  TextField(
                    controller: statusController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: (BorderSide(
                            width: 1,
                            color: Color.fromARGB(255, 155, 154, 154))),
                      ),
                      prefixIcon: Icon(
                        Entypo.flow_line,
                        color: Colors.orange,
                      ),
                      labelText: 'Open',
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 214, 212, 212)),
                      suffixIcon: Icon(Entypo.chevron_small_down),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    'Type',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  TextField(
                    controller: typeController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: (BorderSide(
                            width: 1,
                            color: Color.fromARGB(255, 155, 154, 154))),
                      ),
                      labelText: 'Commissioning > Commissioning',
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 214, 212, 212)),
                      suffixIcon: Icon(Entypo.chevron_small_down),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text("Description",
                      style: TextStyle(color: Colors.grey, fontSize: 16)),
                  TextField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: (BorderSide(
                            width: 1,
                            color: Color.fromARGB(255, 155, 154, 154))),
                      ),
                      labelText: 'Describe the issue',
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 214, 212, 212)),
                      contentPadding: EdgeInsets.symmetric(vertical: 40),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text("Assigned to",
                      style: TextStyle(color: Colors.grey, fontSize: 16)),
                  TextField(
                    controller: assignController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: (BorderSide(
                            width: 1,
                            color: Color.fromARGB(255, 155, 154, 154))),
                      ),
                      labelText: 'Select a member,role,or company',
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 214, 212, 212)),
                      suffixIcon: Icon(Entypo.chevron_small_down),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: const [
                      Text("Watchers",
                          style: TextStyle(color: Colors.grey, fontSize: 16)),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          AntDesign.exclamationcircleo,
                          color: Colors.blue,
                          size: 12,
                        ),
                      ),
                    ],
                  ),
                  TextField(
                    controller: watchController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: (BorderSide(
                            width: 1,
                            color: Color.fromARGB(255, 155, 154, 154))),
                      ),
                      labelText: 'Select watchers',
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 214, 212, 212)),
                      suffixIcon: Icon(Entypo.chevron_small_down),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text("Location",
                      style: TextStyle(color: Colors.grey, fontSize: 16)),
                  TextField(
                    controller: locationController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: (BorderSide(
                            width: 1,
                            color: Color.fromARGB(255, 155, 154, 154))),
                      ),
                      labelText: 'Select a location',
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 214, 212, 212)),
                      suffixIcon: Icon(Entypo.chevron_small_down),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text("Location details",
                      style: TextStyle(color: Colors.grey, fontSize: 16)),
                  TextField(
                    controller: locationDeatilsController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: (BorderSide(
                            width: 1,
                            color: Color.fromARGB(255, 155, 154, 154))),
                      ),
                      labelText: 'Enter location details',
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 214, 212, 212)),
                      suffixIcon: Icon(Entypo.chevron_small_down),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text("Due date",
                      style: TextStyle(color: Colors.grey, fontSize: 16)),
                  TextField(
                    controller: dueDateController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: (BorderSide(
                            width: 1,
                            color: Color.fromARGB(255, 155, 154, 154))),
                      ),
                      prefixIcon: Icon(Fontisto.date),
                      labelText: 'Select date',
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 214, 212, 212)),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text("Start date",
                      style: TextStyle(color: Colors.grey, fontSize: 16)),
                  TextField(
                    controller: startDateController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: (BorderSide(
                            width: 1,
                            color: Color.fromARGB(255, 155, 154, 154))),
                      ),
                      prefixIcon: Icon(Fontisto.date),
                      labelText: 'Select date',
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 214, 212, 212)),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text("Placement",
                      style: TextStyle(color: Colors.grey, fontSize: 16)),
                  TextField(
                    controller: placementController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: (BorderSide(
                            width: 1,
                            color: Color.fromARGB(255, 155, 154, 154))),
                      ),
                      labelText: 'Select... ',
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 214, 212, 212)),
                      suffixIcon: Icon(Entypo.chevron_small_down),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text("Root cause",
                      style: TextStyle(color: Colors.grey, fontSize: 16)),
                  TextField(
                    controller: rootCauseController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: (BorderSide(
                            width: 1,
                            color: Color.fromARGB(255, 155, 154, 154))),
                      ),
                      labelText: 'Select a root cause',
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 214, 212, 212)),
                      suffixIcon: Icon(Entypo.chevron_small_down),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text("Cancel"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[500],
                maximumSize: const Size(150, 50),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            // usually buttons at the bottom of the dialog
            ElevatedButton(
              child: const Text("Create"),
              onPressed: () {
                firebaseFirestore
                    .collection('users')
                    .doc(user.currentUser.uid)
                    .collection('createIssue')
                    .add({
                  'titleController': titleController.text,
                  'statusController': statusController.text,
                  'typeController': typeController.text,
                  'descriptionController': descriptionController.text,
                  'assignController': assignController.text,
                  'watchController': watchController.text,
                  'locationController': locationController.text,
                  'locationDeatilsController': locationDeatilsController.text,
                  'dueDateController': dueDateController.text,
                  'startDateController': startDateController.text,
                  'placementController': placementController.text,
                  'rootCauseController': rootCauseController.text,
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          ElevatedButton.icon(
            onPressed: () {
              _showDialog(context);
            },
            icon: const Icon(AntDesign.plus),
            label: const Text("Create Issue"),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: blue,
            ),
          ),
          const SizedBox(width: 2),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(AntDesign.down),
            label: const Text(""),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: blue,
            ),
          ),
        ],
      ),
    );
  }
}
