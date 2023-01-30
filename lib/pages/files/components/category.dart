import 'package:flutter/material.dart';
import 'package:urlnav2/constants/custom_text.dart';
import 'package:urlnav2/constants/style.dart';
import 'package:urlnav2/pages/files/components/custom_button.dart';
import 'package:urlnav2/pages/files/components/custom_icons.dart';

class FileCategory extends StatelessWidget {
  final double docsize;
  final double imgsize;
  final double vidsize;
  final double musicsize;
  final double otherssize;
  FileCategory(
      {Key key,
      this.docsize,
      this.imgsize,
      this.musicsize,
      this.otherssize,
      this.vidsize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          y20,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomButton(
                icon: CustomIcons.doc_text_inv,
                color: Colors.green,
                label: "documents",
                totalsize: "$docsize GB",
                onPressed: () {},
              ),
              CustomButton(
                icon: Icons.image,
                color: Colors.lightBlue,
                label: "images",
                onPressed: () {},
                totalsize: "$imgsize GB",
              ),
              CustomButton(
                icon: Icons.video_collection,
                color: Colors.redAccent,
                label: "videos",
                onPressed: () {},
                totalsize: "$vidsize GB",
              ),
              CustomButton(
                icon: CustomIcons.music,
                color: Colors.orangeAccent,
                label: "music",
                onPressed: () {},
                totalsize: "$musicsize GB",
              ),
              CustomButton(
                icon: Icons.file_open_outlined,
                color: Colors.amberAccent,
                label: "others",
                onPressed: () {},
                totalsize: "$otherssize GB",
              ),
            ],
          )
        ],
      ),
    );
  }
}
