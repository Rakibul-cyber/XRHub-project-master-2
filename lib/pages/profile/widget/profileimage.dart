import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:urlnav2/appState.dart';
import 'package:urlnav2/constants/custom_text.dart';
import 'package:urlnav2/constants/style.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:universal_html/html.dart' as html;
import 'package:path/path.dart' as Path;
import 'package:urlnav2/constants/custom_text.dart';
import 'package:urlnav2/constants/style.dart';
import 'package:urlnav2/pages/chat/widget/constants.dart';

class ProfileImageWidget extends StatefulWidget {
  final QuerySnapshot data;
  final AppState appState;
  ProfileImageWidget({Key key, this.data, this.appState}) : super(key: key);

  @override
  State<ProfileImageWidget> createState() => _ProfileImageWidgetState();
}

class _ProfileImageWidgetState extends State<ProfileImageWidget> {
  UploadTask task;
  File file;
  Uint8List bytes;
  PlatformFile byte_file;
  String myfilename = "";
  Stream<QuerySnapshot> about;
  CollectionReference addabout;
  bool uploaded = false;

  bool isloading = false;

  @override
  void initState() {
    about = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.appState.myid)
        .collection('about')
        .snapshots();

    addabout = FirebaseFirestore.instance.collection('users');
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(widget.appState.myid)
          .collection('details')
          .snapshots(),
      builder: (
        BuildContext context,
        AsyncSnapshot<QuerySnapshot> snapshot,
      ) {
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: const CircularProgressIndicator());
        }
        if (snapshot.data.docs.isEmpty) {}
        return maincontainer(snapshot.data, context);
      },
    );
  }

  Widget maincontainer(QuerySnapshot mydata, BuildContext context) {
    return Flexible(
        flex: 3,
        child: Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                  color: legistwhite, borderRadius: BorderRadius.circular(120)),
              child: Container(
                //width: 200,
                decoration: BoxDecoration(
                    color: legistwhite,
                    borderRadius: BorderRadius.circular(120)),
                padding: const EdgeInsets.all(2),
                margin: const EdgeInsets.all(2),
                child: bytes == null
                    ? CircleAvatar(
                        backgroundColor: legistblue,
                        backgroundImage: NetworkImage(
                          widget.data.docs[0]['dpurl'],
                        ),
                      )
                    : !isloading
                        ? ClipOval(
                            child: Image.memory(
                              bytes,
                              fit: BoxFit.fill,
                              width: 200,
                            ),
                          )
                        : Stack(
                            alignment: AlignmentDirectional.center,
                            children: const [
                              CircleAvatar(
                                backgroundColor: legistblue,
                                backgroundImage: NetworkImage(
                                  "https://www.seekpng.com/png/detail/847-8474751_download-empty-profile.png",
                                ),
                              ),
                              CircularProgressIndicator(),
                            ],
                          ),
              ),
            ),
            InkWell(
              onTap: () {
                mydialog(context, mydata);
              },
              child: bytes != null && !uploaded
                  ? uploadbutton()
                  : Icon(Icons.edit),
            )
          ],
        ));
  }

  Widget uploadbutton() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: legistblue),
      child: CustomText(text: "Upload"),
    );
  }

  void mydialog(BuildContext context, QuerySnapshot mydata) async {
    await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              actionsAlignment: MainAxisAlignment.center,
              content: mydialogcontent(context, mydata),
              actions: <Widget>[
                mydialogbutton(context, mydata),
              ],
            );
          });
        });
  }

  Widget mydialogbutton(BuildContext context, QuerySnapshot mydata) {
    return TextButton(
      child: bytes == null ? Text('Okay') : Text('Upload'),
      onPressed: () async {
        uploadFile(mydata);
        Navigator.of(context).pop();
      },
    );
  }

  Widget mydialogcontent(BuildContext context, QuerySnapshot mydata) {
    return Form(
        //key: _formKey,
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const CustomText(
          text: "Update Profile Picture",
          weight: FontWeight.bold,
        ),
        const SizedBox(
          height: 10,
        ),
        if (bytes == null) ...[
          CircleAvatar(
            radius: 100,
            backgroundColor: legistblue,
            backgroundImage: NetworkImage(
              widget.data.docs[0]['dpurl'],
            ),
          ),
        ] else ...[
          ClipOval(
            child: Image.memory(
              bytes,
              fit: BoxFit.fill,
              width: 200,
            ),
          ),
        ],
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(
            onPressed: () {
              selectFile(context, mydata);
              Navigator.of(context).pop();
            },
            child: CustomText(
              text: bytes == null ? "Add Photo" : "Change Photo",
              color: legistwhitefont,
            )),
        SizedBox(
          height: 10,
        ),
      ],
    ));
  }

  Future selectFile(BuildContext context, QuerySnapshot mydata) async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null)
      return;
    else if (result.files.single.bytes != null ||
        FilePicker.platform.toString() == "Instance of 'FilePickerWeb'") {
      setState(() {
        bytes = result.files.single.bytes;
        byte_file = result.files.single;
      });

      //uploadFileDialog(context, "Path.basename(file.path)");
      //mydialogcontent(context);
      mydialog(context, mydata);
      //Navigator.of(context).pop();
      //mydialogcontent2(Path.basename(file.path));
      //uploadFile();
    } else {
      final path = result.files.single.path;
      setState(() => file = File(path));

      mydialog(context, mydata);

      //Navigator.of(context).pop();
      //uploadFileDialog(context, "Path.basename(file.path)");
      //mydialogcontent2(Path.basename(file.path));
      //uploadFile();
    }

    if (task == null) return;

    final snapshot = await task.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
  }

  Future uploadFile(QuerySnapshot mydata) async {
    isloading = true;

    if (file == null && bytes == null) {
      return;
    } else if (file != null) {
      final fileName = Path.basename(file.path);
      final destination = 'profilepics/$fileName';

      task = uploadFiles(destination, file);

      setState(() {
        myfilename = fileName;
      });
    } else {
      final fileName = byte_file.name;
      final destination = 'profilepics/$fileName';
      task = uploadBytes(destination, bytes);
      setState(() {
        myfilename = fileName;
      });
    }

    if (task == null) return;

    final snapshot = await task.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    addabout
        .doc(widget.appState.myid)
        .update({
          'dpurl': urlDownload,
        })
        .then((value) => print('Skills added successfully'))
        .catchError((error) => print('Failed to create new skill: $error'));

    addabout
        .doc(widget.appState.myid)
        .collection("details")
        .doc(mydata.docs[0].id)
        .update({
          'dpurl': urlDownload,
        })
        .then((value) => print('Skills added successfully'))
        .catchError((error) => print('Failed to create new skill: $error'));

    setState(() {
      uploaded = true;
    });

    isloading = false;
  }

  static UploadTask uploadFiles(String destination, File file) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putFile(file);
    } on FirebaseException catch (e) {
      return null;
    }
  }

  static UploadTask uploadBytes(String destination, Uint8List data) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putData(data);
    } on FirebaseException catch (e) {
      return null;
    }
  }
}
