import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'dart:io';
import 'package:universal_html/html.dart' as html;
import 'package:urlnav2/appState.dart';
import 'package:urlnav2/constants/custom_text.dart';
import 'package:path/path.dart' as Path;
import 'package:urlnav2/pages/records/widgets/selectedrecordstate.dart';

class QRTest23 extends StatefulWidget {
  final AppState appState;
  final SelectedRecordState recordState;
  QRTest23({Key key, this.appState, this.recordState}) : super(key: key);

  @override
  State<QRTest23> createState() => _QRTest23State();
}

class _QRTest23State extends State<QRTest23> {
  int _counter = 0;
  Uint8List _imageFile;
  UploadTask task;

  //Create an instance of ScreenshotController
  ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Screenshot(
              controller: screenshotController,
              child: CustomText(text: "TEST TEXT")),
          ElevatedButton(
            onPressed: () {
              //downloadChatFileOnWeb("url");
              screenshotController.capture().then((Uint8List image) {
                //Capture Done
                setState(() {
                  _imageFile = image;
                });
              }).catchError((onError) {
                print(onError);
              });
              upload();
            },
          ),
        ],
      ),
    );
  }

  static Future<File> downloadChatFileOnWeb(String url) async {
    html.AnchorElement(href: url)
      ..setAttribute('download', "file")
      ..click();
  }

  static UploadTask uploadBytes(String destination, Uint8List data) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putData(data);
    } on FirebaseException catch (e) {
      return null;
    }
  }

  void upload() async {
    final fileName = "testqr";
    final destination = 'qrteststorage/$fileName';
    task = uploadBytes(destination, _imageFile);

    final snapshot = await task.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    Map<String, dynamic> chatMessageMap = {
      'time': DateTime.now().millisecondsSinceEpoch,
      'ismessage': true,
      'file': urlDownload,
    };

    FirebaseFirestore.instance
        .collection("qrtest")
        .add(chatMessageMap)
        .catchError((e) {
      print(e.toString());
    });
  }
}
