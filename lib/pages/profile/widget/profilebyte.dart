import 'dart:typed_data';

class ProfileByte {
  static Uint8List myName;

  get getmyName => myName;

  set setmyName(Uint8List myname) {
    myName = myname;
  }
}
