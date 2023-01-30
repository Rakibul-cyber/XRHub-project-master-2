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

class ChatFunction extends StatefulWidget {
  final String chatRoomId;

  ChatFunction({Key key, this.chatRoomId}) : super(key: key);

  @override
  ChatFunctionState createState() => ChatFunctionState();
}

class ChatFunctionState extends State<ChatFunction> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController messageEditingController = new TextEditingController();
  bool ismessage = false;
  UploadTask task;
  File file;
  Uint8List bytes;
  PlatformFile byte_file;
  String myfilename = "";
  bool isloading = false;

  Widget chatMessages() {
    final Stream<QuerySnapshot> chats = FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(widget.chatRoomId)
        .collection("chats")
        .orderBy('time', descending: true)
        .snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: chats,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                reverse: true,
                padding: const EdgeInsets.only(bottom: 60),
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container();
                  }
                  return MessageTile(
                    message: snapshot.data.docs[index]["message"],
                    sendByMe:
                        Constants.myName == snapshot.data.docs[index]["sendBy"],
                    ismessage: snapshot.data.docs[index]["ismessage"],
                    file: snapshot.data.docs[index]["file"],
                  );
                })
            : Container();
      },
    );
  }

  addMessage({String url}) {
    if (!ismessage) {
      Map<String, dynamic> chatMessageMap = {
        "sendBy": Constants.myName,
        "message": messageEditingController.text.isNotEmpty
            ? messageEditingController.text
            : "",
        'time': DateTime.now().millisecondsSinceEpoch,
        'ismessage': false,
        'file': url,
      };

      addMessage2(widget.chatRoomId, chatMessageMap);

      setState(() {
        messageEditingController.text = "";
      });
    } else {
      if (messageEditingController.text.isNotEmpty) {
        Map<String, dynamic> chatMessageMap = {
          "sendBy": Constants.myName,
          "message": messageEditingController.text,
          'time': DateTime.now().millisecondsSinceEpoch,
          'ismessage': true,
          'file': "url",
        };

        addMessage2(widget.chatRoomId, chatMessageMap);

        setState(() {
          messageEditingController.text = "";
        });
      }
    }
  }

  Future<void> addMessage2(String chatRoomId, chatMessageData) {
    FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .add(chatMessageData)
        .catchError((e) {
      print(e.toString());
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: active.withOpacity(.4), width: .5),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Padding(
          padding: const EdgeInsets.all(35.0),
          child: Column(
            children: [
              Flexible(flex: 10, child: chatMessages()),
              if (isloading) ...[
                Flexible(
                  child: Row(
                    children: [
                      Expanded(child: Container()),
                      const Padding(
                        padding: EdgeInsets.only(
                            top: 8, bottom: 8, left: 30, right: 24),
                        child: CircularProgressIndicator(),
                      ),
                    ],
                  ),
                )
              ],
              Flexible(
                flex: 2,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                    decoration: BoxDecoration(
                      color: light,
                      border: Border.all(color: lightGrey, width: .5),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                            child: TextField(
                          controller: messageEditingController,
                          style: darkTextStyle(),
                          decoration: InputDecoration(
                              hintText: "Message ...",
                              hintStyle: TextStyle(
                                color: dark,
                                fontSize: 16,
                              ),
                              border: InputBorder.none),
                        )),
                        SizedBox(
                          width: 16,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              ismessage = true;
                            });
                            addMessage();
                          },
                          child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                  color: legistblue,
                                  borderRadius: BorderRadius.circular(10)),
                              padding: EdgeInsets.all(5),
                              child: Center(
                                child: CustomText(
                                  weight: FontWeight.bold,
                                  text: "SEND",
                                  color: legistwhite,
                                ),
                              )),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        InkWell(
                          onTap: () async {
                            chooseFileDialog(context);
                          },
                          child: Icon(
                            Icons.attach_file,
                            color: dark,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> chooseFileDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              actionsAlignment: MainAxisAlignment.center,
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton(
                      style: chooseButtonStyle,
                      onPressed: () {
                        selectFile(context);
                      },
                      child: CustomText(
                        text: "Select file from Computer",
                        weight: FontWeight.bold,
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      style: chooseButtonStyle,
                      onPressed: () {},
                      child: CustomText(
                        text: "Select file from Database",
                        weight: FontWeight.bold,
                      )),
                ],
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: CustomText(
                      text: "Cancel",
                      weight: FontWeight.bold,
                    )),
              ],
            );
          });
        });
  }

  final ButtonStyle chooseButtonStyle = ElevatedButton.styleFrom(
    onPrimary: legistblue,
    primary: Colors.grey[200],
    minimumSize: Size(88, 36),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2)),
    ),
  );

  Future selectFile(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null)
      return;
    else if (result.files.single.bytes != null ||
        FilePicker.platform.toString() == "Instance of 'FilePickerWeb'") {
      setState(() {
        bytes = result.files.single.bytes;
        byte_file = result.files.single;
      });

      Navigator.of(context).pop();
      uploadFileDialog(context, byte_file.name);
    } else {
      final path = result.files.single.path;
      setState(() => file = File(path));

      Navigator.of(context).pop();
      uploadFileDialog(context, Path.basename(file.path));
    }

    if (task == null) return;

    final snapshot = await task.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
  }

  Future<void> uploadFileDialog(
      BuildContext context, String currentfilename) async {
    final TextEditingController _textEditingController =
        TextEditingController();
    return await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.file_upload_outlined),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: currentfilename,
                            weight: FontWeight.w200,
                          ),
                          CustomText(
                            text: "61.12KB",
                            weight: FontWeight.w100,
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    decoration: InputDecoration(
                        labelText: "Caption",
                        hintText: "Add a caption...",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onChanged: (value) {
                      messageEditingController.text = value;
                    },
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        ismessage = false;
                      });
                      uploadFile();

                      Navigator.of(context).pop();
                    },
                    child: CustomText(
                      color: legistwhitefont,
                      text: "SEND",
                      weight: FontWeight.bold,
                    )),
              ],
            );
          });
        });
  }

  Future uploadFile() async {
    isloading = true;

    if (file == null && bytes == null) {
      return;
    } else if (file != null) {
      final fileName = Path.basename(file.path);
      final destination = 'clientschat/$fileName';

      task = uploadFiles(destination, file);

      setState(() {
        myfilename = fileName;
      });
    } else {
      //if (bytes != null){
      final fileName = byte_file.name;
      final destination = 'clientschat/$fileName';
      task = uploadBytes(destination, bytes);
      setState(() {
        myfilename = fileName;
      });
    }

    if (task == null) return;

    final snapshot = await task.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    addMessage(url: urlDownload);
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

class MessageTile extends StatelessWidget {
  final String message;
  final bool sendByMe;
  final bool ismessage;
  final String file;

  MessageTile(
      {@required this.message,
      @required this.sendByMe,
      @required this.ismessage,
      this.file});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 8,
          bottom: 8,
          left: sendByMe ? 30 : 24,
          right: sendByMe ? 24 : 30),
      alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.only(top: 17, bottom: 17, left: 20, right: 20),
        decoration: BoxDecoration(
            borderRadius: sendByMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomLeft: Radius.circular(23))
                : BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomRight: Radius.circular(23)),
            gradient: LinearGradient(
              colors: sendByMe
                  ? [const Color(0xff007EF4), const Color(0xff2A75BC)]
                  : [lightGrey, lightGrey],
            )),
        child: Column(
          children: [
            if (!ismessage) ...[
              Stack(
                  fit: StackFit.passthrough,
                  alignment: Alignment.center,
                  children: [
                    Image.network(
                      file,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent loadingProgress) {
                        if (loadingProgress == null) return child;
                        return CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes
                              : null,
                        );
                      },
                      errorBuilder: (context, error, _) =>
                          buildEmptyFile('Preview Unavailable'),
                      scale: 2.5,
                    ),
                    InkWell(
                      onTap: () {
                        downloadChatFileOnWeb(file);
                      },
                      child: CircleAvatar(
                        backgroundColor: grey.withOpacity(0.6),
                        child: Icon(
                          Icons.file_download,
                          color: legistwhitefont,
                        ),
                      ),
                    )
                  ])
            ],
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                  child: Text(message,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'OverpassRegular',
                          fontWeight: FontWeight.w300)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildEmptyFile(String text) {
    return Center(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.blue, fontSize: 16),
      ),
    );
  }

  static Future<File> downloadChatFileOnWeb(String url) async {
    html.AnchorElement(href: url)
      ..setAttribute('download', "file")
      ..click();
  }
}
