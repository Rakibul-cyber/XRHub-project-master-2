import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:urlnav2/appState.dart';
import 'package:urlnav2/constants/custom_text.dart';
import 'package:urlnav2/constants/style.dart';
import 'package:urlnav2/helpers/reponsiveness.dart';
import 'package:urlnav2/pages/notes/notecase.dart';
import 'package:urlnav2/pages/notes/notescaselist.dart';
import 'package:url_launcher/url_launcher.dart';

class NotesMainPage extends StatefulWidget {
  final AppState appState;
  const NotesMainPage({Key key, this.appState}) : super(key: key);
  @override
  _NotesMainPage createState() => _NotesMainPage();
}

class _NotesMainPage extends State<NotesMainPage> {
  CollectionReference notes;
  final Uri _url = Uri.parse(
      'reflect://reflect.unity3d.com/p/L1fayd2F3swAtSOVVajjoi9d0nDbANhU4qvrjHkO7gIRB');
  NoteCase casename = new NoteCase();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _mynotesController = TextEditingController();
  @override
  void initState() {
    super.initState();
    notes = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.appState.myid)
        .collection('notes');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _mynotesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
              child: Container(
            child: StreamBuilder<QuerySnapshot>(
                stream: notes.snapshots(),
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
                    return Scaffold(
                      body: Center(
                        child: ElevatedButton(
                          onPressed: () {
                            _launchUrl();
                          },
                          child: CustomText(
                            text: "Open Teczo XRHub",
                          ),
                        ),
                      ),
                      floatingActionButton: FloatingActionButton(
                        child: const Icon(Icons.add),
                        backgroundColor: Colors.blue,
                        onPressed: () async {
                          await showDialog(
                              context: context,
                              builder: (context) {
                                return StatefulBuilder(
                                    builder: (context, setState) {
                                  return AlertDialog(
                                    content: myskillss("Notes"),
                                    actions: <Widget>[
                                      mypresswidget("Notes", context),
                                    ],
                                  );
                                });
                              });
                        },
                      ),
                    );
                  }

                  final data = snapshot.requireData;

                  return mynotes(data);
                }),
          )),
        ],
      ),
    );
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }

  Widget mynotes(QuerySnapshot<Object> data) {
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.all(paddingMain),
          child: GridView.builder(
              itemCount: data.size,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 10,
                crossAxisSpacing: 20,
                crossAxisCount: ResponsiveWidget.isLargeScreen(context)
                    ? 8
                    : ResponsiveWidget.isMediumScreen(context)
                        ? 3
                        : 2,
              ),
              itemBuilder: (context, index) {
                return notecontainer(data.docs[index]["title"],
                    data.docs[index]["mynotes"], data, index);
              })),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue,
        onPressed: () {
          opendialog();
        },
      ),
    );
  }

  void opendialog() async {
    await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: myskillss("Notes"),
              actions: <Widget>[
                mypresswidget("Notes", context),
              ],
            );
          });
        });
  }

  Widget notecontainer(
      String mmytitle, String mynotess, QuerySnapshot data, int index) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.amberAccent[100],
        border: Border.all(color: lightGrey, width: .5),
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 6),
              color: lightGrey.withOpacity(0.5),
              blurRadius: 5)
        ],
      ),
      child: Column(
        children: [
          Flexible(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  CustomText(
                    text: mmytitle,
                    size: 18,
                    weight: FontWeight.bold,
                    talign: TextAlign.center,
                  ),
                  CustomText(text: mynotess),
                ],
              ),
            ),
          ),
          ElevatedButton(
              style: chooseButtonStyle,
              onPressed: () async {
                _titleController.text = mmytitle;
                _mynotesController.text = mynotess;
                await showDialog(
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(builder: (context, setState) {
                        return AlertDialog(
                          content: myskillss2("Notes"),
                          actions: <Widget>[
                            mypresswidget2(
                                "Notes", context, data.docs[index].id),
                          ],
                        );
                      });
                    });
              },
              child: CustomText(
                text: "Edit",
              ))
        ],
      ),
    );
  }

  Widget myskillss(String title) {
    return Form(
        //key: _formKey,
        child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: "Add $title",
          weight: FontWeight.bold,
        ),
        SizedBox(
          height: 10,
        ),
        ListTile(
          leading: Icon(Icons.cases_outlined),
          title: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(widget.appState.myid)
                .collection('cases')
                .snapshots(),
            builder: (
              BuildContext context,
              AsyncSnapshot<QuerySnapshot> snapshot,
            ) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return InkWell(
                  onTap: () async {
                    Navigator.pop(context);
                    await showInformationDialog2(
                      context,
                      snapshot,
                    );
                  },
                  child: Container(
                    child: CustomText(
                      text: casename.getmyName,
                    ),
                  ),
                );
              }
            },
          ),
          trailing: Icon(Icons.arrow_drop_down_outlined),
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: _titleController,
          validator: (value) {
            return value.isNotEmpty ? null : "Invalid Field";
          },
          decoration: InputDecoration(
              labelText: "Enter Note Title",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          maxLines: 8,
          controller: _mynotesController,
          validator: (value) {
            return value.isNotEmpty ? null : "Invalid Field";
          },
          decoration: InputDecoration(
              labelText: "Enter Description",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    ));
  }

  Widget myskillss2(String title) {
    return Form(
        //key: _formKey,
        child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: "Add $title",
          weight: FontWeight.bold,
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: _titleController,
          validator: (value) {
            return value.isNotEmpty ? null : "Invalid Field";
          },
          decoration: InputDecoration(
              hintText: "Enter Notes",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          maxLines: 8,
          controller: _mynotesController,
          validator: (value) {
            return value.isNotEmpty ? null : "Invalid Field";
          },
          decoration: InputDecoration(
              hintText: "Enter description",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    ));
  }

  Widget mypresswidget(String title, BuildContext context) {
    return ElevatedButton(
      style: chooseButtonStyle,
      child: Text('Add Note'),
      onPressed: () {
        notes
            .add({
              'title': _titleController.text,
              'mynotes': _mynotesController.text,
              'case': casename.getmyName,
            })
            .then((value) => print('Notes added successfully'))
            .catchError((error) => print('Failed to create new Notes: $error'));

        _titleController.text = "";
        _mynotesController.text = "";

        Navigator.pop(context);
        //Navigator.pop(context);
      },
    );
  }

  Widget mypresswidget2(String title, BuildContext context, String dataid) {
    return ElevatedButton(
      style: chooseButtonStyle,
      child: Text('Edit Note'),
      onPressed: () {
        notes
            .doc(dataid)
            .set({
              'title': _titleController.text,
              'mynotes': _mynotesController.text,
            })
            .then((value) => print('Notes added successfully'))
            .catchError((error) => print('Failed to create new Notes: $error'));

        _titleController.text = "";
        _mynotesController.text = "";

        Navigator.pop(context);
        //Navigator.pop(context);
      },
    );
  }

  final ButtonStyle chooseButtonStyle = ElevatedButton.styleFrom(
    onPrimary: grey,
    primary: Colors.transparent,
    minimumSize: Size(88, 36),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2)),
    ),
  );

  Future<void> showInformationDialog2(
      BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) async {
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
                              itemCount: snapshot.data.docs.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return NoteCaseList(
                                  data: snapshot.data,
                                  index: index,
                                  casename: casename,
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
                    opendialog();
                  },
                ),
              ],
            );
          });
        });
  }
}
