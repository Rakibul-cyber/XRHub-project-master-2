import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:urlnav2/appState.dart';
import 'package:urlnav2/constants/custom_text.dart';
import 'package:urlnav2/constants/style.dart';
import 'package:urlnav2/helpers/reponsiveness.dart';
import 'package:urlnav2/pages/files/components/custom_icons.dart';
import 'package:urlnav2/pages/records/widgets/selectedrecordstate.dart';

/// This is the screen that you'll see when the app starts
class RecordBoxScreen extends StatefulWidget {
  final AppState appState;
  final SelectedRecordState recordState;

  const RecordBoxScreen({Key key, this.appState, this.recordState})
      : super(key: key);
  @override
  _RecordBoxScreenState createState() => _RecordBoxScreenState();
}

class _RecordBoxScreenState extends State<RecordBoxScreen> {
  @override
  Widget build(BuildContext context) {
    final message =
        // ignore: lines_longer_than_80_chars
        'https://console.firebase.google.com/u/5/project/teczocvk/storage/teczocvk.appspot.com/files/~2Frecords~2F${FirebaseAuth.instance.currentUser.email}~2F${widget.recordState.selectedrecord}';

    final qrFutureBuilder = FutureBuilder<ui.Image>(
      future: _loadOverlayImage(),
      builder: (ctx, snapshot) {
        final size = 280.0;
        if (!snapshot.hasData) {
          return Container(width: size, height: size);
        }
        return CustomPaint(
          size: Size.square(size),
          painter: QrPainter(
            data: message,
            version: QrVersions.auto,
            eyeStyle: const QrEyeStyle(
              eyeShape: QrEyeShape.square,
              color: legistblue,
            ),
            dataModuleStyle: const QrDataModuleStyle(
              dataModuleShape: QrDataModuleShape.square,
              color: legistblue,
            ),
            // size: 320.0,
            embeddedImage: snapshot.data,
            embeddedImageStyle: QrEmbeddedImageStyle(
              size: Size.square(60),
            ),
          ),
        );
      },
    );

    return Container(
      padding: pad20,
      child: Column(
        children: <Widget>[
          Expanded(child: taskcontainer2()),
          Expanded(
            child: Center(
              child: Container(
                width: 280,
                child: qrFutureBuilder,
              ),
            ),
          ),
          /*Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40)
                .copyWith(bottom: 40),
            child: Text(message),
          ),*/
        ],
      ),
    );
  }

  Widget taskcontainer2() {
    return ListView(
      children: [
        StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(widget.appState.myid)
                .collection('records')
                .doc(widget.recordState.selectedrecord)
                .collection('files')
                .snapshots(),
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

              if (snapshot.data.docs.isEmpty) {
                return Center(
                  child: CustomText(
                    text: "Please Add a Task",
                  ),
                );
              }

              final data = snapshot.requireData;

              return GridView.builder(
                  itemCount: data.size,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 1,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 5,
                    crossAxisCount: ResponsiveWidget.isLargeScreen(context)
                        ? 6
                        : ResponsiveWidget.isMediumScreen(context)
                            ? 4
                            : 2,
                  ),
                  itemBuilder: (context, index) {
                    return filecell(
                        name: data.docs[index]["name"],
                        type: data.docs[index]["type"],
                        sentby: data.docs[index]["sendBy"],
                        filesize: data.docs[index]["size"]);
                  });
            }),
      ],
    );
  }

  Widget filecell({String type, String name, String filesize, String sentby}) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      margin: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: legistwhite,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: .2,
            blurRadius: 5,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Image.asset(
                "assets/icons/fileblank.png",
                width: 80,
              ),
              myfiletype(type, 30),
            ],
          ),
          CustomText(
            text: "${overflowtext(name)}.$type",
            talign: TextAlign.center,
            weight: FontWeight.bold,
          ),
          Expanded(child: Container()),
          const Divider(
            height: 10,
            thickness: 1.0,
            indent: 20,
            endIndent: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  CustomText(
                    text: "Filesize:",
                    size: 12,
                    weight: FontWeight.bold,
                  ),
                  CustomText(
                    text: filesize,
                    size: 11,
                    color: grey,
                  )
                ],
              ),
              CustomText(
                text: sentby,
                size: 11,
                color: grey,
              )
            ],
          )
        ],
      ),
    );
  }

  String overflowtext(String mystring) {
    int truncateAt = 10;
    String elepsis = "...";

    if (mystring.length > truncateAt) {
      return mystring.substring(0, truncateAt - elepsis.length) + elepsis;
    } else {
      return mystring;
    }
  }

  Widget myfiletype(String type, double size) {
    switch (type) {
      case ("txt"):
        return Icon(
          CustomIcons.doc_text_inv,
          color: Colors.blue,
          size: size,
        );
      case ("png"):
        return Icon(
          Icons.image,
          color: Colors.amber,
          size: size,
        );
      case ("pdf"):
        return Icon(
          Icons.picture_as_pdf,
          color: Colors.red,
          size: size,
        );
      case ("mp4"):
        return Icon(
          Icons.video_collection,
          color: Colors.orange,
          size: size,
        );
      case ("mp3"):
        return Icon(
          CustomIcons.music,
          color: Colors.pink,
          size: size,
        );

      default:
        return Icon(
          CustomIcons.doc_text_inv,
          color: Colors.green,
          size: size,
        );
    }
  }

  Future<ui.Image> _loadOverlayImage() async {
    final completer = Completer<ui.Image>();
    final byteData = await rootBundle.load('assets/icons/logo.png');
    ui.decodeImageFromList(byteData.buffer.asUint8List(), completer.complete);
    return completer.future;
  }
}
