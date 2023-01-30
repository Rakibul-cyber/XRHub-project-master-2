import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import '../../constants/style.dart';

class ProjectFormPopup extends StatefulWidget {
  ProjectFormPopup({Key key}) : super(key: key);

  @override
  State<ProjectFormPopup> createState() => _ProjectFormPopupState();
}

class _ProjectFormPopupState extends State<ProjectFormPopup> {
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

  uploadIMage() {
    XFile image;
    ImagePicker()
        .pickImage(
      source: ImageSource.gallery,
    )
        .then((value) {
      setState(() {
        image = value;
      });
    });
    FirebaseStorage.instance
        .ref("desiredPathForImage/")
        .putFile(File(image.path))
        .then((TaskSnapshot taskSnapshot) {
      if (taskSnapshot.state == TaskState.success) {
        print("Image uploaded Successful");
        // Get Image URL Now
        taskSnapshot.ref.getDownloadURL().then((imageURL) {
          print("Image Download URL is $imageURL");
        });
      } else if (taskSnapshot.state == TaskState.running) {
        // Show Prgress indicator
      } else if (taskSnapshot.state == TaskState.error) {
        // Handle Error Here
      }
    });
  }

  // user defined function
  void _showDialog(context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: const Center(child: Text("Create Project")),
          content: Container(
            width: MediaQuery.of(context).size.width / 3,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: const [
                      Text(
                        "Project name",
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
                      labelText: 'Enter a project name',
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 214, 212, 212)),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "Project number",
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
                      labelText: 'Enter a project number',
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 214, 212, 212)),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: const [
                      Text(
                        "Account",
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
                      labelText: 'Select an account',
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
                      Text(
                        "Project type",
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
                      labelText: 'Select an account first',
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 214, 212, 212)),
                      suffixIcon: Icon(Entypo.chevron_small_down),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text("Template",
                      style: TextStyle(color: Colors.grey, fontSize: 16)),
                  TextField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: (BorderSide(
                            width: 1,
                            color: Color.fromARGB(255, 155, 154, 154))),
                      ),
                      labelText: 'Select an account first',
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 214, 212, 212)),
                      suffixIcon: Icon(Entypo.chevron_small_down),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Address",
                          style: TextStyle(color: Colors.grey, fontSize: 16)),
                      Text("Enter address manually",
                          style: TextStyle(color: Colors.blue, fontSize: 16)),
                    ],
                  ),
                  TextField(
                    controller: assignController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: (BorderSide(
                            width: 1,
                            color: Color.fromARGB(255, 155, 154, 154))),
                      ),
                      labelText: 'Enter a location',
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 214, 212, 212)),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: const [
                      Text("Time zone",
                          style: TextStyle(color: Colors.grey, fontSize: 16)),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          AntDesign.exclamationcircleo,
                          color: Colors.grey,
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
                      labelText: '(GMT +08:00) Kuala Lumpur',
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 214, 212, 212)),
                      suffixIcon: Icon(Entypo.chevron_small_down),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: const [
                          Text("Start date",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 16)),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              AntDesign.exclamationcircleo,
                              color: Colors.grey,
                              size: 12,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: const [
                          Text("End date",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 16)),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              AntDesign.exclamationcircleo,
                              color: Colors.grey,
                              size: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 6,
                        child: TextField(
                          controller: watchController,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: (BorderSide(
                                  width: 1,
                                  color: Color.fromARGB(255, 155, 154, 154))),
                            ),
                            prefixIcon: Icon(Entypo.calendar),
                            labelText: "Select date",
                            labelStyle: TextStyle(
                                color: Color.fromARGB(255, 214, 212, 212)),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(),
                      ),
                      Expanded(
                        flex: 6,
                        child: TextField(
                          controller: watchController,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: (BorderSide(
                                  width: 1,
                                  color: Color.fromARGB(255, 155, 154, 154))),
                            ),
                            prefixIcon: Icon(Entypo.calendar),
                            labelText: "Select date",
                            labelStyle: TextStyle(
                                color: Color.fromARGB(255, 214, 212, 212)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text("Project value",
                      style: TextStyle(color: Colors.grey, fontSize: 16)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 6,
                        child: TextField(
                          controller: watchController,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: (BorderSide(
                                  width: 1,
                                  color: Color.fromARGB(255, 155, 154, 154))),
                            ),
                            labelText: "Enter a value",
                            labelStyle: TextStyle(
                                color: Color.fromARGB(255, 214, 212, 212)),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(),
                      ),
                      Expanded(
                        flex: 6,
                        child: TextField(
                          controller: watchController,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: (BorderSide(
                                  width: 1,
                                  color: Color.fromARGB(255, 155, 154, 154))),
                            ),
                            labelText: "USD",
                            labelStyle: TextStyle(
                                color: Color.fromARGB(255, 214, 212, 212)),
                            suffixIcon: Icon(Entypo.chevron_small_down),
                          ),
                        ),
                      ),
                    ],
                  ),
                  /*
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
                  ),*/
                  const SizedBox(
                    height: 15,
                  ),
                  TextButton.icon(
                      onPressed: () async {
                        uploadIMage();
                      },
                      icon: Icon(Icons.upload),
                      label: Text('Upload Image'))
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
                    .collection('createProject')
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
            label: const Text("Create Project"),
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
