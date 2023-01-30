import 'package:flutter/material.dart';

const MaterialColor kPrimaryColor = const MaterialColor(
  0xFF358CDA,
  const <int, Color>{
    50: const Color(0xFF358CDA),
    100: const Color(0xFF358CDA),
    200: const Color(0xFF358CDA),
    300: const Color(0xFF358CDA),
    400: const Color(0xFF358CDA),
    500: const Color(0xFF358CDA),
    600: const Color(0xFF358CDA),
    700: const Color(0xFF358CDA),
    800: const Color(0xFF358CDA),
    900: const Color(0xFF358CDA),
  },
);
//new colors
const Color lightest = Color(0xFFFEFEFE);
const Color ligh = Color(0xFFF6F6F6);
const Color blue = Color(0xFF365DA1); 
const Color skyblue = Color(0xFF358CDA);
const Color darkBlue = Color(0xFF142A5C);
const Color darkest = Color(0xFF111010);


//old colors
const Color white = Color(0xFFFFFFFF);
const Color greyBc = Color(0xFFF6F6F6);
const Color light = Color(0xFFF7F8FC);
const Color lightGrey = Color(0xFFA4A6B3);
const Color grey = Color.fromARGB(255, 158, 158, 158);
const Color silver = Color.fromARGB(72, 221, 221, 221);
const Color darkGrey = Colors.black87;
const Color dark = Color(0xFF363740);
const Color active = Color(0xFF3C19C0);
//Color legistblue = Color(0xFF2196F3);
const Color legistblue = Color(0xFF168EEA);
const Color legistbluelight = Color(0xFFBBDEFB);
const Color legistbluelight2 = Color(0xFF90CAF9);
const Color legistwhite = Color(0xFFFFFFFF);
const Color legistwhitefont = Color(0xFFFFFFFF);
const Color legistblackfont = Color(0xFF000000);
const Color legistamber = Colors.amber;
const Color backgroundColor = Color.fromARGB(72, 221, 221, 221);
const Color foregroundColor = Colors.blue;

const double space_8 = 8; //For lines (subtitles, etc.)

const double space_10 = 10; //For gaps (cards, containers, etc.)
const double space_20 = 20;
const double space_30 = 30;
const double space_40 = 40;
const double space_50 = 50;
const double toolbarheight = 55;

//SizedBox

//Width

const x10 = SizedBox(width: 10);
const x20 = SizedBox(width: 20);
const x30 = SizedBox(width: 30);
const x40 = SizedBox(width: 40);
const x50 = SizedBox(width: 50);

//Height

const y5 = SizedBox(height: 5);
const y10 = SizedBox(height: 10);
const y20 = SizedBox(height: 20);
const y30 = SizedBox(height: 30);
const y40 = SizedBox(height: 40);
const y50 = SizedBox(height: 50);

//Padding

const double paddingMax = 50; //Max
const double paddingMain = 40.0;
const double paddingBig = 30;
const double paddingMid = 20;
const double paddingSmall = 10;
const double paddingMin = 8; //Min

const pad5 = EdgeInsets.all(5);
const pad8 = EdgeInsets.all(8);
const pad10 = EdgeInsets.all(10);
const pad16 = EdgeInsets.all(16);
const pad20 = EdgeInsets.all(20);

//Sizes
const double fontTitle = 32;
const double fontSubtitle = 28;
const double fontHeader = 20;
const double fontSubheader = 18;
const double fontLabel = 16;
const double fontSub = 12;
const double fontBody = 10;

InputDecoration textFieldInputDecoration(String hintText) {
  return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.white54),
      focusedBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      enabledBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)));
}

TextStyle simpleTextStyle() {
  return TextStyle(color: Colors.white, fontSize: 16);
}

TextStyle greyTextStyle() {
  return TextStyle(color: lightGrey, fontSize: 16);
}

TextStyle darkTextStyle() {
  return TextStyle(color: dark, fontSize: 16);
}

TextStyle biggerTextStyle() {
  return TextStyle(color: Colors.white, fontSize: 17);
}


