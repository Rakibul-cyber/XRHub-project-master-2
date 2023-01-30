import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:urlnav2/appState.dart';
import 'package:urlnav2/constants/custom_text.dart';
import 'package:urlnav2/constants/style.dart';
import 'package:urlnav2/pages/tasks/selectedtaskstate.dart';

class DragTask2 extends StatefulWidget {
  final SelectedTaskState myindex;
  final AppState appState;
  DragTask2({
    Key key,
    this.appState,
    this.myindex,
  }) : super(key: key);

  @override
  _DragHandle2Example createState() => _DragHandle2Example();
}

class _DragHandle2Example extends State<DragTask2> {
  CollectionReference addtask;
  String taskipnum;
  String tasktdnum;
  String taskcpnum;

  bool isontarget = false;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
  var mytaskstatus;
  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    addtask = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.appState.myid)
        .collection('tasks')
        .doc(widget.myindex.selectedTask)
        .collection('taskscol');

    super.initState();
  }

  Widget taskcell(String task, String category, String priority, String duedate,
      bool isdrag) {
    return InkWell(
      child: Container(
        margin: const EdgeInsets.all(paddingMid),
        width: MediaQuery.of(context).size.width / 4,
        //padding: const EdgeInsets.all(paddingMid),
        decoration: BoxDecoration(
            boxShadow: [
              isdrag
                  ? BoxShadow(
                      offset: const Offset(0, 6),
                      color: lightGrey.withOpacity(0.4),
                      blurRadius: 5)
                  : BoxShadow(
                      offset: const Offset(0, 0),
                      color: lightGrey.withOpacity(0.0),
                      blurRadius: 5)
            ],
            color: isdrag ? legistwhite : legistwhite.withOpacity(0.4),
            //border: Border.all(color: lightGrey, width: .5),
            borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: const EdgeInsets.all(paddingMid),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(space_20)),
                    child: CustomText(
                      text: category,
                      color: legistwhitefont,
                      size: 10,
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: const Icon(
                      Icons.more_horiz_outlined,
                      color: lightGrey,
                    ),
                  ),
                ],
              ),
              CustomText(
                text: task,
                weight: FontWeight.bold,
              ),
              CustomText(
                text: priority,
                color: lightGrey,
                size: 12,
              ),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                leading: const Icon(
                  Icons.date_range_outlined,
                  color: lightGrey,
                ),
                title: CustomText(
                  text: duedate,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(
                    Icons.person_outline,
                    color: lightGrey,
                  ),
                  Row(
                    children: const [
                      Icon(
                        Icons.attach_file,
                        color: lightGrey,
                      ),
                      CustomText(
                        text: "5",
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var backgroundColor = const Color.fromARGB(255, 243, 242, 248);
    List<DropdownMenuItem> taskstatusitems = [
      const DropdownMenuItem(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: CustomText(text: "In Progress"),
        ),
        value: "In Progress",
      ),
      const DropdownMenuItem(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: CustomText(text: "To Do"),
        ),
        value: "To Do",
      ),
      const DropdownMenuItem(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: CustomText(text: "Completed"),
        ),
        value: "Completed",
      )
    ];

    return Column(
      children: [
        Row(
          children: [
            getcurrentnum(0),
            getcurrentnum(1),
            getcurrentnum(2),
            //reloadbtn()
          ],
        ),
        CustomText(
          text: "TESTING ${statusController.text}",
        ),
        Expanded(
          child: Scaffold(
            body: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                    child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.alarm_sharp,
                          color: grey,
                        ),
                        CustomText(
                          text: "In Progress",
                          weight: FontWeight.bold,
                          color: grey,
                        ),
                      ],
                    ),
                    Expanded(child: taskcontainer2(0)),
                  ],
                )),
                Flexible(
                    child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.alarm_add_sharp,
                          color: grey,
                        ),
                        CustomText(
                          text: "To Do",
                          weight: FontWeight.bold,
                          color: grey,
                        ),
                      ],
                    ),
                    Expanded(child: taskcontainer2(1)),
                  ],
                )),
                Flexible(
                    child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.alarm_on,
                          color: grey,
                        ),
                        CustomText(
                          text: "Completed",
                          weight: FontWeight.bold,
                          color: grey,
                        ),
                      ],
                    ),
                    Expanded(child: taskcontainer2(2)),
                  ],
                )),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add),
              backgroundColor: Colors.blue,
              onPressed: () async {
                await showDialog(
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(builder: (context, setState) {
                        return AlertDialog(
                          content: Form(
                              //key: _formKey,
                              child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CustomText(
                                text: "Add Task",
                                weight: FontWeight.bold,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: _titleController,
                                validator: (value) {
                                  return value.isNotEmpty
                                      ? null
                                      : "Invalid Field";
                                },
                                decoration: InputDecoration(
                                    hintText: "Enter Name",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton2(
                                    buttonDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: lightGrey,
                                      ),
                                      color: Colors.transparent,
                                    ),
                                    items: taskstatusitems,
                                    onChanged: (statusvalue) {
                                      setState(() {
                                        mytaskstatus = statusvalue;
                                        statusController.text = statusvalue;
                                      });
                                    },
                                    value: mytaskstatus,
                                    isExpanded: true,
                                    hint: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: CustomText(
                                          text: 'Select Status',
                                          color: dark.withOpacity(.8)),
                                    ),
                                  ),
                                ),
                              ),
                              /*TextFormField(
                                controller: statusController,
                                validator: (value) {
                                  return value.isNotEmpty
                                      ? null
                                      : "Invalid Field";
                                },
                                decoration: InputDecoration(
                                    hintText: "Enter Status",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                              ),*/
                              TextFormField(
                                controller: descriptionController,
                                validator: (value) {
                                  return value.isNotEmpty
                                      ? null
                                      : "Invalid Field";
                                },
                                decoration: InputDecoration(
                                    hintText: "Enter Description",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          )),
                          actions: <Widget>[
                            mypresswidget(context),
                          ],
                        );
                      });
                    });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget taskcontainer2(int mynum) {
    return ListView(
      children: [
        mydragtarget(mynum, 0),
        StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(widget.appState.myid)
                .collection('tasks')
                .doc(widget.myindex.selectedTask)
                .collection('taskscol')
                .where('status', isEqualTo: mynum)
                .orderBy('priority', descending: false)
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
                  child: ElevatedButton(
                    onPressed: () async {
                      statusController.text = inttostatus(mynum);
                      await showDialog(
                          context: context,
                          builder: (context) {
                            return StatefulBuilder(
                                builder: (context, setState) {
                              return AlertDialog(
                                content: Form(
                                    //key: _formKey,
                                    child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const CustomText(
                                      text: "Add Task",
                                      weight: FontWeight.bold,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      controller: _titleController,
                                      validator: (value) {
                                        return value.isNotEmpty
                                            ? null
                                            : "Invalid Field";
                                      },
                                      decoration: InputDecoration(
                                          hintText: "Enter Name",
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10))),
                                    ),
                                    TextFormField(
                                      controller: statusController,
                                      validator: (value) {
                                        return value.isNotEmpty
                                            ? null
                                            : "Invalid Field";
                                      },
                                      decoration: InputDecoration(
                                          hintText: "Enter Status",
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10))),
                                    ),
                                    TextFormField(
                                      controller: descriptionController,
                                      validator: (value) {
                                        return value.isNotEmpty
                                            ? null
                                            : "Invalid Field";
                                      },
                                      decoration: InputDecoration(
                                          hintText: "Enter Description",
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10))),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                )),
                                actions: <Widget>[
                                  mypresswidget(context),
                                ],
                              );
                            });
                          });
                    },
                    child: const CustomText(
                      text: "Please Add a Task",
                      color: legistwhitefont,
                    ),
                  ),
                );
              }

              final data = snapshot.requireData;

              return ListView.builder(
                  itemCount: data.size,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return mydraglist(
                        data.docs[index]["name"],
                        data.docs[index]["priority"],
                        data.docs[index]["status"]);
                  });
            }),
      ],
    );
  }

  String inttostatus(int mynum) {
    if (mynum == 0) {
      return "In Progress";
    } else if (mynum == 1) {
      return "To Do";
    } else {
      return "Completed";
    }
  }

  int statustoint(String mystring) {
    if (mystring == "In Progress") {
      return 0;
    } else if (mystring == "To Do") {
      return 1;
    } else {
      return 2;
    }
  }

  Widget mydraglist(String task, int dragitem, int draglist) {
    return Column(
      children: [
        mydraggablemain(task, draglist, dragitem),
        mydragtarget(draglist, dragitem + 1),
      ],
    );
  }

//TODO change futurebuilder to dragtarget from draggable

  Widget mydraggablemain(String task, int draglist, int dragitem) {
    return Draggable(
      data: "$dragitem,$draglist",
      child: taskcell(task, "category",
          "${draglist.toString()} ${dragitem.toString()}", "duedate", true),
      feedback: taskcell(task, "category",
          "${draglist.toString()} ${dragitem.toString()}", "duedate", true),
      childWhenDragging: taskcell(task, "category",
          "${draglist.toString()} ${dragitem.toString()}", "duedate", false),
    );
  }

  List<String> mytaskupdater(List<String> docInfo, QuerySnapshot snap) {
    for (var document in snap.docs) {
      //if (document['priority'] == prior && document['status'] == status) {
      docInfo.add(document.id);
      docInfo.add(document["priority"].toString());
      docInfo.add(document["status"].toString());

      return docInfo;
      //}
    }

    return docInfo;
  }

  Widget mydragtarget(int targetlist, int targetitem) {
    return DragTarget(
      builder: (
        BuildContext context,
        List<dynamic> accepted,
        List<dynamic> rejected,
      ) {
        return AnimatedContainer(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: isontarget ? grey.withOpacity(0.3) : Colors.transparent,
          ),
          duration: const Duration(milliseconds: 300),
          height: isontarget ? 150 : 50,
          width: MediaQuery.of(context).size.width / 4,
          child: CustomText(
            text: "$isontarget",
            color: Colors.transparent,
          ),
        );
      },
      onAccept: (String data) async {
        //setState(() {
        final splitstring = data.split(",");

        int draglist = int.parse(splitstring[1]);
        int dragitem = int.parse(splitstring[0]);

        updatetest(dragitem, targetitem, draglist, targetlist);
        isontarget = false;
        //});
      },
      onMove: (DragTargetDetails<String> item) {
        isontarget = true;
      },
      onLeave: (String data) {
        isontarget = false;
      },
    );
  }

  updatetest(int dragitem, int targetitem, int draglist, int targetlist) async {
    QuerySnapshot tasksip = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.appState.myid)
        .collection('tasks')
        .doc(widget.myindex.selectedTask)
        .collection('taskscol')
        .where('status', isEqualTo: 0)
        .orderBy('priority', descending: false)
        .get();

    QuerySnapshot taskstd = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.appState.myid)
        .collection('tasks')
        .doc(widget.myindex.selectedTask)
        .collection('taskscol')
        .where('status', isEqualTo: 1)
        //.orderBy('status')
        .orderBy('priority', descending: false)
        .get();

    QuerySnapshot taskscp = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.appState.myid)
        .collection('tasks')
        .doc(widget.myindex.selectedTask)
        .collection('taskscol')
        .where('status', isEqualTo: 2)
        .orderBy('priority', descending: false)
        .get();

    //updatetest2(targetitem, targetlist, taskscp);
    updateitemsup(
        dragitem, targetitem, draglist, targetlist, tasksip, taskscp, taskstd);
  }

  void updatetest2(
      int targetitem, int targetlist, QuerySnapshot<Object> mysnap) {
    for (var document in mysnap.docs) {
      if (document['status'] == targetlist) {
        if (document['priority'] == targetitem) {
          addtask.doc(document.id).update({
            'status': (document['status'] - 1),
          });
        } else if (document['priority'] > targetitem) {}
      }
    }
  }

  void updateitemsup(int dragitem, int targetitem, int draglist, int targetlist,
      QuerySnapshot tasksip, QuerySnapshot taskscp, QuerySnapshot taskstd) {
    if (draglist == targetlist) {
      if (draglist < 1) {
        if (dragitem == targetitem) {
        } else if (dragitem > targetitem) {
          updateitemsup2(dragitem, targetitem, tasksip);
        } else {
          updateitemsdown2(dragitem, targetitem, tasksip);
        }
      } else if (draglist > 1) {
        if (dragitem == targetitem) {
        } else if (dragitem > targetitem) {
          updateitemsup2(dragitem, targetitem, taskscp);
        } else {
          updateitemsdown2(dragitem, targetitem, taskscp);
        }
      } else {
        if (dragitem == targetitem) {
        } else if (dragitem > targetitem) {
          updateitemsup2(dragitem, targetitem, taskstd);
        } else {
          updateitemsdown2(dragitem, targetitem, taskstd);
        }
      }
    } else {
      if (draglist < 1) {
        updateitemdraglist(dragitem, targetitem, draglist, targetlist, tasksip);
      } else if (draglist > 1) {
        updateitemdraglist(dragitem, targetitem, draglist, targetlist, taskscp);
      } else {
        updateitemdraglist(dragitem, targetitem, draglist, targetlist, taskstd);
      }

      if (targetlist < 1) {
        updateitemtargetlist(
            dragitem, targetitem, draglist, targetlist, tasksip);
      } else if (targetlist > 1) {
        updateitemtargetlist(
            dragitem, targetitem, draglist, targetlist, taskscp);
      } else {
        updateitemtargetlist(
            dragitem, targetitem, draglist, targetlist, taskstd);
      }
    }
  }

  void updateitemsup2(
      int dragitem, int targetitem, QuerySnapshot<Object> mysnap) {
    for (var document in mysnap.docs) {
      if (document['priority'] == dragitem) {
        //document[0][''].toString();
        //testtask.add({'name': document[0]['name'].toString()});
        addtask.doc(document.id).update({'priority': targetitem});
      } else if (document['priority'] < targetitem) {
      } else if (document['priority'] > dragitem) {
      } else {
        addtask
            .doc(document.id)
            .update({'priority': (document['priority'] + 1)});
      }
    }
  }

  void updateitemsdown2(
      int dragitem, int targetitem, QuerySnapshot<Object> mysnap) {
    for (var document in mysnap.docs) {
      if (document['priority'] == dragitem) {
        //document[0][''].toString();
        //testtask.add({'name': document[0]['name'].toString()});
        addtask.doc(document.id).update({'priority': targetitem});
      } else if (document['priority'] > targetitem) {
      } else if (document['priority'] < dragitem) {
      } else {
        addtask
            .doc(document.id)
            .update({'priority': (document['priority'] - 1)});
      }
    }
  }

  updateitemdraglist(int dragitem, int targetitem, int draglist, int targetlist,
      QuerySnapshot<Object> mysnap) {
    for (var document in mysnap.docs) {
      if (document['status'] == draglist) {
        if (document['priority'] == dragitem) {
          addtask
              .doc(document.id)
              .update({'priority': targetitem, 'status': targetlist});
        } else if (document['priority'] > dragitem) {
          addtask
              .doc(document.id)
              .update({'priority': (document['priority'] - 1)});
        } else if (document['priority'] > dragitem) {}
      }
    }
  }

  updateitemtargetlist(int dragitem, int targetitem, int draglist,
      int targetlist, QuerySnapshot<Object> mysnap) {
    for (var document in mysnap.docs) {
      if (document['status'] == targetlist) {
        if (document['priority'] >= targetitem) {
          addtask.doc(document.id).update({
            'priority': (document['priority'] + 1),
          });
        } else if (document['priority'] > targetitem) {}
      }
    }
  }

  Widget mypresswidget(BuildContext context) {
    return TextButton(
      child: const CustomText(text: 'Okay'),
      onPressed: () {
        addtask
            .add({
              'name': _titleController.text,
              'status': statustoint(statusController.text),
              'description': descriptionController.text,
              'priority': statustoint(statusController.text) < 1
                  ? int.parse(taskipnum)
                  : statustoint(statusController.text) > 1
                      ? int.parse(taskcpnum)
                      : int.parse(tasktdnum),
            })
            .then((value) => print('Task added successfully'))
            .catchError((error) => print('Failed to create new Task: $error'));
        Navigator.pop(context);
        _titleController.text = "";
        statusController.text = "";
        descriptionController.text = "";
        return;
      },
    );
  }

  Widget getcurrentnum(int mystatus) {
    return StreamBuilder<QuerySnapshot>(
        stream: addtask.where('status', isEqualTo: mystatus).snapshots(),
        builder: (
          BuildContext context,
          AsyncSnapshot<QuerySnapshot> snapshot,
        ) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          final data = snapshot.requireData;

          if (mystatus < 1) {
            return Container(
              child: _case1(getcaseipnum(data.size)),
            );
          } else if (mystatus > 1) {
            return Container(
              child: _case1(getcasecpnum(data.size)),
            );
          } else {
            return Container(
              child: _case1(getcasetdnum(data.size)),
            );
          }
        });
  }

  Widget _case1(String casenum) {
    return Text(
      casenum,
      style: TextStyle(color: Colors.transparent, fontSize: 15),
    );
  }

  String getcaseipnum(int num) {
    taskipnum = "$num";
    return taskipnum;
  }

  String getcasetdnum(int num) {
    tasktdnum = "$num";
    return tasktdnum;
  }

  String getcasecpnum(int num) {
    taskcpnum = "$num";
    return taskcpnum;
  }

  /* Future<List> mydragdata(int dragitem, int draglist) async {
    QuerySnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.appState.myid)
        .collection('tasks')
        .doc(widget.myindex.selectedTask)
        .collection('taskscol')
        .get();

    List<String> docInfo = [/* 'docId', 'taskName' */];

    for (var document in snap.docs) {
      if (document['priority'] == dragitem && document['status'] == draglist) {
        docInfo.add(document.id);
        docInfo.add(document["priority"].toString());
        docInfo.add(document["status"].toString());

        return docInfo;
      }
    }

    //return mytaskupdater(docInfo, snap);

    //updateitemsup(dragitem, targetitem, draglist, targetlist, tasksip, taskscp, taskstd);
  }

  Widget mydragtargetmain(
      String task, int draglist, int dragitem, int targetlist, int targetitem) {
    String mytitle = "draghere";
    return FutureBuilder(
      future: mydragdata(dragitem, draglist),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return DragTarget(
            builder: (
              BuildContext context,
              List<dynamic> accepted,
              List<dynamic> rejected,
            ) {
              return Container(
                height: 100,
                width: 100,
                color: grey,
                child: CustomText(text: "$mytitle $targetlist $targetitem"),
              );
            },
            onAccept: (String data) {
              setState(() {
                final splitstring = data.split(",");

                int draglist = int.parse(splitstring[1]);
                int dragitem = int.parse(splitstring[0]);

                //mytitle = "$draglist $dragitem";

                //addtask.doc(data).update({'status': splitstring[2]});
                updatelist(dragitem, draglist, targetlist, targetitem);
              });
            },
          );
        } else {
          return taskcell(task, "category", draglist.toString(), "duedate");
        }
      },
    );
  }*/

}
