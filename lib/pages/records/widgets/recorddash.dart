import 'dart:typed_data';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:urlnav2/appState.dart';
import 'package:urlnav2/constants/custom_text.dart';
import 'package:urlnav2/constants/myconstants.dart';
import 'package:urlnav2/constants/style.dart';
import 'package:urlnav2/helpers/reponsiveness.dart';
import 'package:urlnav2/pages/chat/widget/constants.dart';
import 'package:urlnav2/pages/files/components/custom_icons.dart';
import 'package:urlnav2/pages/files/components/dropped_file.dart';
import 'package:urlnav2/pages/files/components/dropped_file_widget.dart';
import 'package:urlnav2/pages/files/components/dropzone_widget.dart';
import 'package:urlnav2/pages/files/components/storage_chart.dart';
import 'package:urlnav2/pages/files/components/usage.dart';
import 'package:intl/intl.dart';
import 'package:urlnav2/pages/records/widgets/card_folder.dart';
import 'package:urlnav2/pages/records/widgets/selectedrecordstate.dart';

class RecordsDashboard extends StatefulWidget {
  final QuerySnapshot<Object> data;
  final AppState appState;
  final SelectedRecordState selectedRecordState;
  const RecordsDashboard(
      {this.data, this.appState, this.selectedRecordState, Key key})
      : super(key: key);

  @override
  State<RecordsDashboard> createState() => _RecordsDashboard();
}

class _RecordsDashboard extends State<RecordsDashboard> {
  Usage usage = new Usage(totalFree: 40, totalUsed: 60);
  DroppedFile droppedFile;
  DropzoneViewController dropzoneController;
  bool isloading = false;
  UploadTask task;
  File file;
  Uint8List bytes;
  PlatformFile byte_file;
  CollectionReference myfilescol;
  String myfilename = "";
  QuerySnapshot nameSnapshot;

  void initState() {
    super.initState();
    getUserInfogetChats();
    myfilescol = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.appState.myid)
        .collection('records');
  }

  getUserInfogetChats() async {
    await getmyusername().then((snapshot) {
      setState(() {
        nameSnapshot = snapshot;
      });
    });
    Constants.myName = nameSnapshot.docs[0]["firstname"];
    Constants.myID = nameSnapshot.docs[0]["email"];
  }

  getmyusername() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(widget.appState.myid)
        .collection('details')
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomText(
                    text: "Record Boxes",
                    weight: FontWeight.bold,
                    size: 15,
                  ),
                  folderlist(),
                  /*y20,
                  const CustomText(
                    text: "Files",
                    weight: FontWeight.bold,
                    size: 15,
                  ),
                  fileslist(),*/
                ],
              ),
            )),
        if (!ResponsiveWidget.isSmallScreen(context))
          Flexible(
              flex: 1,
              child: Container(
                decoration: const BoxDecoration(
                    color: legistwhite,
                    border: Border.symmetric(
                        vertical: BorderSide(color: lightGrey, width: .5))),
                child: ListView(
                  padding: const EdgeInsets.all(20),
                  children: [
                    const CustomText(
                      text: "Storage",
                      weight: FontWeight.bold,
                      size: 15,
                    ),
                    StorageChart(
                      usage: usage,
                    ),
                    //FileCategory(),
                    droppedFile != null
                        ? SizedBox(
                            height: 200,
                            // width: 300,
                            child: DroppedFileWidget(file: droppedFile))
                        : Container(
                            width: 0,
                          ),
                    kIsWeb
                        ? SizedBox(
                            height: 400,
                            // width: 300,
                            child: DropzoneWidget(
                                onDroppedFile: (file) =>
                                    setState(() => droppedFile = file)))
                        : pickFile(),
                    y20,
                    uploadbutton(),
                  ],
                ),
              )),
      ],
    );
  }

  Future<dynamic> acceptFile(dynamic event) async {
    final name = event.name;
    final mime = await dropzoneController.getFileMIME(event);
    final size = await dropzoneController.getFileSize(event);
    final url = await dropzoneController.createFileUrl(event);
    final bytes = await dropzoneController.getFileData(event);

    if (kDebugMode) {
      print(name);
      print(mime);
      print(size);
      print(url);
    }

    // ignore: unused_local_variable
    final droppedFile = DroppedFile(
      url: url,
      name: name,
      mime: mime,
      size: size,
      bytes: bytes,
    );

    // widget.onDroppedFile(droppedFile);
  }

  Widget pickFile() {
    return Padding(
      padding: const EdgeInsets.only(top: 18),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            primary: Colors.blue,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
        icon: const Icon(Icons.attach_file_rounded, size: 32),
        label: const Text('Attach File(s)',
            style: TextStyle(color: Colors.white, fontSize: 20)),
        onPressed: () async {
          final events = await dropzoneController.pickFiles();
          if (events.isEmpty) return;
          acceptFile(events.first);
        },
      ),
    );
  }

  Widget folderlist() {
    return Expanded(
        child: GridView.builder(
      itemCount: widget.data.size,
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
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: InkWell(
          onTap: () {
            sideMenuController.changeActiveItemTo("Task#${index + 1}");
            widget.selectedRecordState.selectedrecord = "${index + 1}";
          },
          child: CardFolder(
            label: "Box ${index + 1}",
            datecreated: index,
          ),
        ),
      ),
    ));
  }

  Widget uploadbutton() {
    if (isloading) {
      return Center(child: CircularProgressIndicator());
    } else {
      return InkWell(
        onTap: () {
          if (droppedFile != null) {
            chooseFileDialog();
          }
        },
        child: Container(
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: droppedFile != null ? legistblue : grey),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: CustomText(
                color: droppedFile != null
                    ? legistwhitefont
                    : dark.withOpacity(0.8),
                text: "Upload",
              ),
            ),
          ),
        ),
      );
    }
  }

  Future<void> chooseFileDialog() async {
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
                      onPressed: () {
                        Navigator.pop(context);
                        chooseFolderDialog(context);
                      },
                      child: const CustomText(
                        text: "Existing Box",
                        weight: FontWeight.bold,
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        saveFiles("${widget.data.size + 1}");
                      },
                      child: const CustomText(
                        text: "New Box",
                        weight: FontWeight.bold,
                      )),
                ],
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
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

  Future<void> chooseFolderDialog(BuildContext context) async {
    bool isselect = false;
    return await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: Container(
                width: MediaQuery.of(context).size.width / 6,
                child: Form(
                    //key: _formKey,
                    child: Row(
                  children: [
                    Flexible(
                      flex: 6,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListView.builder(
                              itemCount: widget.data.docs.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    setState(() => isselect = true);
                                    saveFiles("${index + 1}");
                                  },
                                  child: ListTile(
                                    title: Column(
                                      children: [
                                        CustomText(
                                          text: "Box ${index + 1}",
                                        ),
                                        const SizedBox(
                                          child: Divider(
                                            height: 0.5,
                                            color: lightGrey,
                                            indent: 10,
                                            endIndent: 10,
                                          ),
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                    trailing: isselect
                                        ? Icon(
                                            Icons.check_circle_outline_outlined)
                                        : Icon(Icons.circle_outlined),
                                  ),
                                );
                              }),
                        ],
                      ),
                    ),
                  ],
                )),
              ),
              actions: <Widget>[
                ElevatedButton(
                  child: CustomText(
                    text: 'Okay',
                    color: legistwhitefont,
                  ),
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          });
        });
  }

  Future<void> saveFiles(String boxname) async {
    setState(() {
      isloading = true;
    });
    if (droppedFile == null) {
      return;
    } else if (kIsWeb) {
      try {
        var ref = FirebaseStorage.instance
            .ref('records/${Constants.myID}/${boxname}/${droppedFile.name}');

        // Firebase.upload
        var uploadTask = ref.putData(droppedFile.bytes).catchError((error) {
          if (kDebugMode) {
            print('Error saving file:\n$error');
          }
        });

        var loadURL = await (await uploadTask).ref.getDownloadURL();

        String finalName = (await uploadTask).ref.name;
        String finalURL = loadURL.toString();

        Map<String, dynamic> chatMessageMap = {
          "name": droppedFile.name,
          "type": getfiletype(droppedFile.mime),
          "sendBy": Constants.myName,
          "size": droppedFile.formattedSize,
          'time': DateTime.now().millisecondsSinceEpoch,
          'file': finalURL,
        };

        myfilescol
            .doc(boxname)
            .set({
              'created':
                  DateFormat('EEE, d/M/y').format(DateTime.now()).toString(),
            })
            .then((value) {})
            .catchError((error) => print('Failed to create task: $error'));

        myfilescol
            .doc(boxname)
            .collection("files")
            .add(chatMessageMap)
            .then((_) {
          if (kDebugMode) {
            print('Task File URL saved successfully.');
          }
        }).catchError((error) {
          if (kDebugMode) {
            print(
                'Failed to save the File URL for the select task.\nError: $error');
          }
        });
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
      setState(() {
        isloading = false;
      });
      droppedFile = null;
    } else {
      //File Upload for Android.
      return;
    }
  }

  String getfiletype(String name) {
    final splitted = name.split("/");
    return splitted[1];
  }

  Widget fileslist() {
    return Expanded(
      child: DataTable2(
          columnSpacing: 12,
          horizontalMargin: 12,
          minWidth: 600,
          columns: const [
            DataColumn2(
              label: CustomText(
                text: "Name",
                color: grey,
              ),
              size: ColumnSize.L,
            ),
            DataColumn(
              label: CustomText(
                text: "Size",
                color: grey,
              ),
            ),
            DataColumn(
              label: CustomText(
                text: "Last Modified",
                color: grey,
              ),
            ),
            DataColumn(
              label: CustomText(
                text: "Author",
                color: grey,
              ),
            ),
          ],
          rows: List<DataRow>.generate(
              widget.data.size,
              (index) => DataRow(cells: [
                    DataCell(ListTile(
                        title: CustomText(
                          text: widget.data.docs[index]['name'],
                          size: 12,
                        ),
                        leading: myfiletype(widget.data.docs[index]['type']))),
                    DataCell(CustomText(
                        text: widget.data.docs[index]['size'].toString(),
                        size: 12)),
                    DataCell(CustomText(
                        text: widget.data.docs[index]['time'].toString(),
                        size: 12)),
                    DataCell(CustomText(
                        text: widget.data.docs[index]['sendBy'], size: 12)),
                  ]))),
    );
  }

  Widget myfiletype(String type) {
    switch (type) {
      case ("txt"):
        return const Icon(
          CustomIcons.doc_text_inv,
        );
      case ("png"):
        return const Icon(
          Icons.image,
        );
      case ("pdf"):
        return const Icon(
          Icons.picture_as_pdf,
        );
      case ("mp4"):
        return const Icon(
          Icons.video_collection,
        );
      case ("mp3"):
        return const Icon(
          CustomIcons.music,
        );

      default:
        return const Icon(
          CustomIcons.doc_text_inv,
        );
    }
  }
}
