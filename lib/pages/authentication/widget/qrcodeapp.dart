import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:cloud_firestore/cloud_firestore.dart';
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
class QRAppScan extends StatefulWidget {
  const QRAppScan({Key key}) : super(key: key);
  @override
  _QRAppScanState createState() => _QRAppScanState();
}

class _QRAppScanState extends State<QRAppScan> {
  @override
  Widget build(BuildContext context) {
    final message =
        // ignore: lines_longer_than_80_chars
        'https://teczocvk.web.app/';

    final qrFutureBuilder = FutureBuilder<ui.Image>(
      future: _loadOverlayImage(),
      builder: (ctx, snapshot) {
        final size = 200.0;
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

    return Center(
      child: Container(
        width: 200,
        child: qrFutureBuilder,
      ),
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
              Icon(
                Icons.request_page_sharp,
                size: 80,
                color: legistwhite,
                shadows: [
                  Shadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 10,
                    offset: Offset(0, 2),
                  )
                ],
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
