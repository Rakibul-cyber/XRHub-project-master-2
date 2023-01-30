import 'dart:typed_data';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:unicons/unicons.dart';
import 'package:urlnav2/appState.dart';
import 'package:urlnav2/constants/custom_text.dart';
import 'package:urlnav2/constants/style.dart';
import 'package:urlnav2/helpers/reponsiveness.dart';
import 'package:urlnav2/helpers/services/firebase_api.dart';
import 'package:urlnav2/pages/chat/widget/constants.dart';
import 'package:urlnav2/pages/files/components/card_folder.dart';
import 'package:urlnav2/pages/files/components/category.dart';
import 'package:urlnav2/pages/files/components/custom_icons.dart';
import 'package:urlnav2/pages/files/components/dropped_file.dart';
import 'package:urlnav2/pages/files/components/dropped_file_widget.dart';
import 'package:urlnav2/pages/files/components/dropzone_widget.dart';
import 'package:urlnav2/pages/files/components/storage_chart.dart';
import 'package:urlnav2/pages/files/components/usage.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as Path;

class FilePage extends StatefulWidget {
  final QuerySnapshot<Object> data;
  final AppState appState;
  const FilePage({this.data, this.appState, Key key}) : super(key: key);

  @override
  State<FilePage> createState() => _FilePageState();
}

class _FilePageState extends State<FilePage> {
  Usage usage = new Usage(totalFree: 100, totalUsed: 0);
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
  var selectedfilename = "";
  var selectedfiletype = "";
  var selectedfiledate = 0;
  var selectedfileauthur = "";
  var selectedfileurl = "";
  var selectedfiledesc = "";
  var selectedfolder = "";
  final filedescriptioncontroller = TextEditingController();
  final foldernamecontroller = TextEditingController();
  bool isfolderselected = false;

  void initState() {
    super.initState();
    getUserInfogetChats();
    myfilescol = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.appState.myid)
        .collection('files');
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: isfolderselected ? selectedfolder : "Folders",
                        weight: FontWeight.bold,
                        size: 15,
                      ),
                      if (isfolderselected) ...[
                        InkWell(
                          onTap: () {
                            setState(() {
                              isfolderselected = false;
                              selectedfolder = "";
                            });
                          },
                          child: Container(
                            child: CustomText(
                              text: "Back",
                            ),
                          ),
                        ),
                      ] else ...[
                        InkWell(
                            onTap: () {
                              if (!isfolderselected) {
                                createfolderDialog();
                              }
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.add,
                                  color: isfolderselected
                                      ? Colors.transparent
                                      : dark,
                                ),
                                CustomText(
                                  text: "Add New Folder",
                                  color: isfolderselected
                                      ? Colors.transparent
                                      : dark,
                                ),
                              ],
                            ))
                      ]
                    ],
                  ),
                  if (isfolderselected) ...[
                    folderlist2(selectedfolder),
                  ] else ...[
                    folderlist(),
                  ],
                  y20,
                  const CustomText(
                    text: "Files",
                    weight: FontWeight.bold,
                    size: 15,
                  ),
                  fileslist(),
                ],
              ),
            )),
        if (!ResponsiveWidget.isSmallScreen(context))
          if (selectedfilename == "") ...[
            sidepanel()
          ] else ...[
            sidepanel2(selectedfiletype, selectedfilename, selectedfiledate,
                selectedfileurl, selectedfiledesc)
          ]
      ],
    );
  }

  Widget sidepanel() {
    return Flexible(
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
              FileCategory(
                docsize: 5.4,
                imgsize: 8.2,
                vidsize: 2.1,
                musicsize: 0.5,
                otherssize: 1.4,
              ),
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
        ));
  }

  Widget sidepanel2(
      String type, String filename, int filedate, String url, String desc) {
    return Flexible(
        flex: 1,
        child: Container(
          decoration: const BoxDecoration(
              color: legistwhite,
              border: Border.symmetric(
                  vertical: BorderSide(color: lightGrey, width: .5))),
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Row(
                children: [
                  const CustomText(
                    text: "File Preview",
                    weight: FontWeight.bold,
                    size: 15,
                  ),
                  Expanded(child: Container()),
                  InkWell(
                    onTap: () {
                      setState(() {
                        selectedfilename = "";
                        selectedfiledate = 0;
                        selectedfiletype = "";
                        selectedfileauthur = "";
                        selectedfileurl = "";
                        selectedfiledesc = "";
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: legistblue),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: CustomText(
                            color: legistwhitefont,
                            text: "Upload New",
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              const Divider(
                height: 10,
                thickness: 1.0,
                indent: 20,
                endIndent: 20,
              ),
              if (type == "png" || type == "jpeg") ...[
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: grey, borderRadius: BorderRadius.circular(10)),
                  child: Image.network(
                    url,
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
                ),
              ] else ...[
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Image.asset(
                      "assets/icons/fileblank.png",
                      width: 200,
                    ),
                    /*Icon(
                    UniconsLine.file_alt,
                    size: 150,
                    color: legistwhite,
                    shadows: [
                      Shadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 10,
                        offset: Offset(0, 2),
                      )
                    ],
                  ),*/
                    myfiletype(type, 100),
                  ],
                ),
              ],
              CustomText(
                text: filename,
                weight: FontWeight.w600,
                size: 15,
              ),
              CustomText(
                text: epochtodate(filedate),
                weight: FontWeight.w100,
                color: grey,
                size: 11,
              ),
              const Divider(
                height: 10,
                thickness: 1.0,
                indent: 20,
                endIndent: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  maxLines: 20,
                  controller: filedescriptioncontroller,
                  decoration: InputDecoration(
                      labelText: "Add Description",
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              InkWell(
                onTap: () {
                  adddescription(filedate, filename);
                },
                child: Container(
                  margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: legistblue),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: CustomText(
                        color: legistwhitefont,
                        text: "Add Description",
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(
                height: 10,
                thickness: 1.0,
                indent: 20,
                endIndent: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: legistblue,
                          borderRadius: BorderRadius.circular(10)),
                      child: InkWell(
                        onTap: () {},
                        child: Icon(
                          Icons.share,
                          color: legistwhitefont,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: legistblue,
                          borderRadius: BorderRadius.circular(10)),
                      child: InkWell(
                        onTap: () {},
                        child: Icon(
                          Icons.download,
                          color: legistwhitefont,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: legistblue,
                          borderRadius: BorderRadius.circular(10)),
                      child: InkWell(
                        onTap: () {},
                        child: Icon(
                          Icons.delete_outline,
                          color: legistwhitefont,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              adddesc(getdesc(desc)),
            ],
          ),
        ));
  }

  void adddescription(int time, String name) async {
    selectedfilename = name;
    QuerySnapshot mysnap = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.appState.myid)
        .collection('files')
        .get();

    for (var document in mysnap.docs) {
      if (document['time'] == time) {
        myfilescol
            .doc(document.id)
            .update({'description': filedescriptioncontroller.text});
      }
    }
  }

  Widget adddesc(String mydesc) {
    return CustomText(
      text: mydesc,
      color: legistwhite,
    );
  }

  String getdesc(String desc) {
    filedescriptioncontroller.text = desc;
    return filedescriptioncontroller.text;
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

  Widget buildEmptyFile(String text) {
    return Center(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.blue, fontSize: 16),
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
            setState(() {
              isfolderselected = true;
              selectedfolder = widget.data.docs[index]['foldernam'];
            });
          },
          child: CardFolder(
            label: widget.data.docs[index]['foldernam'],
            datecreated: epochtodate(widget.data.docs[index]['datecreated']),
          ),
        ),
      ),
    ));
  }

  Widget folderlist2(String foldername) {
    return Container(
      height: 400,
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(widget.appState.myid)
              .collection('files')
              .where("folder", isEqualTo: foldername)
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
            final data = snapshot.requireData;

            return Column(
              children: [
                Expanded(
                    child: GridView.builder(
                  itemCount: data.size,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 1,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 5,
                    crossAxisCount: ResponsiveWidget.isLargeScreen(context)
                        ? 4
                        : ResponsiveWidget.isMediumScreen(context)
                            ? 4
                            : 2,
                  ),
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: InkWell(
                        onTap: () {
                          setState(() {
                            selectedfilename = data.docs[index]['name'];
                            selectedfiledate = data.docs[index]['time'];
                            selectedfiletype = data.docs[index]['type'];
                            selectedfileurl = data.docs[index]['file'];
                            selectedfiledesc = data.docs[index]['description'];
                            selectedfileauthur = data.docs[index]['sendBy'];
                          });
                        },
                        child: filecell(
                            name: data.docs[index]['name'],
                            type: data.docs[index]['type'],
                            filesize: data.docs[index]['size'],
                            sentby: data.docs[index]['sendBy'])),
                  ),
                )),
              ],
            );
          }),
    );
  }

  Widget uploadbutton() {
    if (isloading) {
      return Center(child: CircularProgressIndicator());
    } else {
      return InkWell(
        onTap: () {
          if (droppedFile != null) {
            if (isfolderselected) {
              saveFiles(selectedfolder);
            } else {
              chooseFileDialog();
            }
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
                        text: "Upload to Folder",
                        weight: FontWeight.bold,
                        color: legistwhite,
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        saveFiles("");
                      },
                      child: const CustomText(
                        text: "Upload",
                        weight: FontWeight.bold,
                        color: legistwhite,
                      )),
                ],
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const CustomText(
                      text: "Cancel",
                      weight: FontWeight.bold,
                    )),
              ],
            );
          });
        });
  }

  Future<void> saveFiles(String foldername) async {
    setState(() {
      isloading = true;
    });
    if (droppedFile == null) {
      return;
    } else if (kIsWeb) {
      try {
        var ref = FirebaseStorage.instance
            .ref('files/${Constants.myID}/$foldername/${droppedFile.name}');

        // Firebase.upload
        var uploadTask = ref.putData(droppedFile.bytes).catchError((error) {
          if (kDebugMode) {
            print('Error saving file:\n$error');
          }
        });

        var loadURL = await (await uploadTask).ref.getDownloadURL();

        String finalName = (await uploadTask).ref.name;
        String finalURL = loadURL.toString();

        var db = FirebaseFirestore.instance.collection('jobs');

        Map<String, dynamic> chatMessageMap = {
          "name": droppedFile.name,
          "type": getfiletype(droppedFile.mime),
          "sendBy": Constants.myName,
          "size": droppedFile.formattedSize,
          'time': DateTime.now().millisecondsSinceEpoch,
          'file': finalURL,
          'folder': foldername,
          'description': "",
        };

        myfilescol.add(chatMessageMap).then((_) {
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

  String epochtodate(int epochdate) {
    DateTime date1 = DateTime.fromMillisecondsSinceEpoch(epochdate);
    return DateFormat('EEE, d/M/y').format(date1).toString();
  }

  Future uploadFile() async {
    isloading = true;

    if (file == null && bytes == null) {
      return;
    } else if (file != null) {
      final fileName = Path.basename(file.path);
      final destination = 'files/${Constants.myID}/$fileName';

      task = uploadFiles(destination, file);

      setState(() {
        myfilename = fileName;
      });
    } else {
      //if (bytes != null){
      final fileName = byte_file.name;
      final destination = 'files/${Constants.myID}/$fileName';
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

  addMessage({String url}) {
    Map<String, dynamic> chatMessageMap = {
      "name": myfilename,
      "type": getfiletype(myfilename),
      "sendBy": Constants.myName,
      'time': DateTime.now().millisecondsSinceEpoch,
      'file': url,
      'description': "",
    };

    addMessage2(chatMessageMap);
  }

  String getfiletype(String name) {
    final splitted = name.split("/");
    return splitted[1];
  }

  Future<void> addMessage2(chatMessageData) {
    myfilescol.add(chatMessageData).catchError((e) {
      print(e.toString());
    });
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

  Widget fileslist() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(widget.appState.myid)
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
          final data = snapshot.requireData;

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
                    data.size,
                    (index) => DataRow(
                            cells: [
                              DataCell(ListTile(
                                  title: CustomText(
                                    text: data.docs[index]['name'],
                                    size: 12,
                                  ),
                                  leading: myfiletype(
                                      data.docs[index]['type'], 20))),
                              DataCell(CustomText(
                                  text: data.docs[index]['size'].toString(),
                                  size: 12)),
                              DataCell(CustomText(
                                  text: epochtodate(data.docs[index]['time']),
                                  size: 12)),
                              DataCell(CustomText(
                                  text: data.docs[index]['sendBy'], size: 12)),
                            ],
                            onSelectChanged: (value) {
                              setState(() {
                                selectedfilename = data.docs[index]['name'];
                                selectedfiledate = data.docs[index]['time'];
                                selectedfiletype = data.docs[index]['type'];
                                selectedfileurl = data.docs[index]['file'];
                                selectedfiledesc =
                                    data.docs[index]['description'];
                                selectedfileauthur = data.docs[index]['sendBy'];
                              });
                            }))),
          );
        });
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
      case ("jpeg"):
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
      case ("rvt"):
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
                                    saveFiles(
                                        widget.data.docs[index]["foldernam"]);
                                  },
                                  child: ListTile(
                                    title: Column(
                                      children: [
                                        CustomText(
                                          text: widget.data.docs[index]
                                              ["foldernam"],
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

  Future<void> createfolderDialog() async {
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
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      controller: foldernamecontroller,
                      decoration: InputDecoration(
                          labelText: "Folder Name",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  )
                ],
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          //createfolder(foldernamecontroller.text);
                          createemptyfolder(foldernamecontroller.text);
                          addfolderinfo(foldernamecontroller.text);
                          Navigator.pop(context);
                        },
                        child: const CustomText(
                          text: "Create Folder",
                          weight: FontWeight.bold,
                          color: legistwhite,
                        )),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const CustomText(
                          text: "Cancel",
                          weight: FontWeight.bold,
                          color: legistwhite,
                        )),
                  ],
                ),
              ],
            );
          });
        });
  }

  void addfolderinfo(String foldername) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(widget.appState.myid)
        .collection('folders')
        .add({
          'foldernam': foldername,
          'datecreated': DateTime.now().millisecondsSinceEpoch,
        })
        .then((value) {})
        .catchError((error) => print('Failed to create new client: $error'));
  }

  static UploadTask createemptyfolder(String folderName) {
    try {
      final ref =
          FirebaseStorage.instance.ref('files/${Constants.myID}/$folderName');

      return ref.child('README.txt').putString("""
\t<<< This is an auto-generated file for the folder name, $folderName >>>\n
< It's not advised to delete/modify this file as that'd lead to the folder being removed permanently.>\n
""");
    } on FirebaseException {
      return null;
    }
  }

  Future<void> createfolder(String boxname) async {
    setState(() {
      isloading = true;
    });
    if (droppedFile == null) {
      return;
    } else if (kIsWeb) {
      try {
        var ref = FirebaseStorage.instance
            .ref('files/${Constants.myID}/${boxname}/${droppedFile.name}');

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
            text: overflowtext(name),
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
}
