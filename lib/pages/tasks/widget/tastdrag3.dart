import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:urlnav2/appState.dart';
import 'package:urlnav2/constants/custom_text.dart';
import 'package:urlnav2/constants/style.dart';
import 'package:urlnav2/pages/tasks/selectedtaskstate.dart';

class DragTask3 extends StatefulWidget {
  final SelectedTaskState myindex;
  final AppState appState;
  DragTask3({
    Key key,
    this.appState,
    this.myindex,
  }) : super(key: key);

  @override
  _DragHandle3Example createState() => _DragHandle3Example();
}

class _DragHandle3Example extends State<DragTask3> {
  QuerySnapshot tasksip;
  QuerySnapshot taskstd;
  QuerySnapshot taskscp;
  QuerySnapshot tasksfl;
  CollectionReference addtask;
  String taskipnum;
  String tasktdnum;
  String taskcpnum;
  String mydragdatastring = "draghere";

  CollectionReference testtask;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    addtask = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.appState.myid)
        .collection('tasks')
        .doc(widget.myindex.selectedTask)
        .collection('taskscol');

    getRelatedTasks();

    super.initState();
  }

  Future<List> getRelatedTasks() async {
    tasksfl = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.appState.myid)
        .collection('tasks')
        .doc(widget.myindex.selectedTask)
        .collection('taskscol')
        .get();

    tasksip = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.appState.myid)
        .collection('tasks')
        .doc(widget.myindex.selectedTask)
        .collection('taskscol')
        .where('status', isEqualTo: 0)
        .orderBy('priority', descending: false)
        .get();

    taskstd = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.appState.myid)
        .collection('tasks')
        .doc(widget.myindex.selectedTask)
        .collection('taskscol')
        .where('status', isEqualTo: 1)
        //.orderBy('status')
        .orderBy('priority', descending: false)
        .get();

    taskscp = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.appState.myid)
        .collection('tasks')
        .doc(widget.myindex.selectedTask)
        .collection('taskscol')
        .where('status', isEqualTo: 2)
        .orderBy('priority', descending: false)
        .get();

    /*setState(() {
      _lists.add(InnerList(
        name: "IN PROGRESS",
        title:
            List.generate(tasksip.size, (index) => tasksip.docs[index]["name"]),
        summary: List.generate(tasksip.size,
            (index) => tasksip.docs[index]["priority"].toString()),
      ));

      _lists.add(InnerList(
        name: "TO DO",
        title:
            List.generate(taskstd.size, (index) => taskstd.docs[index]["name"]),
        summary: List.generate(taskstd.size,
            (index) => taskstd.docs[index]["priority"].toString()),
      ));

      _lists.add(InnerList(
        name: "COMPLETED",
        title:
            List.generate(taskscp.size, (index) => taskscp.docs[index]["name"]),
        summary: List.generate(taskscp.size,
            (index) => taskscp.docs[index]["priority"].toString()),
      ));
    });

    return _lists;*/
  }

  _buildList(int outerIndex) {
    return DragAndDropList(
      header: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomText(
            color: lightGrey,
            text: outerIndex == 0
                ? "IN PROGRESS"
                : outerIndex == 1
                    ? "TO DO"
                    : "COMPLETED",
            weight: FontWeight.bold,
          ),
        ],
      ),
      children: outerIndex == 0
          ? List.generate(
              tasksip.size,
              (index) => _buildItem(tasksip.docs[index]["name"],
                  tasksip.docs[index]["priority"].toString()))
          : outerIndex == 1
              ? List.generate(
                  taskstd.size,
                  (index) => _buildItem(taskstd.docs[index]["name"],
                      taskstd.docs[index]["priority"].toString()))
              : List.generate(
                  taskscp.size,
                  (index) => _buildItem(taskscp.docs[index]["name"],
                      taskscp.docs[index]["priority"].toString())),
    );
  }

  getRelatedTasks22() async {
    tasksip = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.appState.myid)
        .collection('tasks')
        .doc(widget.myindex.selectedTask)
        .collection('taskscol')
        .where('status', isEqualTo: 0)
        .orderBy('priority', descending: false)
        .get();

    List<String> docInfo = [/* 'docId', 'taskName' */];

    for (var document in tasksip.docs) {
      docInfo.add("");
      return docInfo;
    }
  }

  _buildItem(String item, String summary) {
    return DragAndDropItem(
      child: taskcell(item, "category", summary, "duedate"),
    );
  }

  Widget taskcell(
      String task, String category, String summary, String duedate) {
    return InkWell(
      child: Container(
        margin: const EdgeInsets.all(paddingMid),
        width: MediaQuery.of(context).size.width / 4,
        //padding: const EdgeInsets.all(paddingMid),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 6),
                  color: lightGrey.withOpacity(0.4),
                  blurRadius: 5)
            ],
            color: legistwhite,
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
                text: summary,
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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(child: taskcontainer2(0)),
        Flexible(child: taskcontainer2(1)),
        Flexible(child: taskcontainer2(2)),
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
                  child: CustomText(
                    text: "Please Add Notes",
                  ),
                );
              }

              final data = snapshot.requireData;

              return ListView.builder(
                  itemCount: data.size,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return mydraggable(
                        data.docs[index]["name"],
                        data.docs[index]["priority"],
                        data.docs[index]["status"]);
                  });
            }),
      ],
    );
  }

  Widget mydragtarget(int status, int priority) {
    double height = 150;
    double width = 150;
    return DragTarget(
      builder: (
        BuildContext context,
        List<dynamic> accepted,
        List<dynamic> rejected,
      ) {
        return Container(
          height: height,
          width: width,
          color: grey,
          child: CustomText(text: mydragdatastring),
        );
      },
      onAccept: (String data) {
        setState(() {
          mydragdatastring = data;
          addtask.doc(data).update({'status': status});
          height = 200;
          width = 200;
          //acceptedData += data;
        });
      },
    );
  }

  Widget mydraggable2(String task, int summary, int status) {
    return Draggable(
        data: mydragdata(summary, status, taskscp).toString(),
        //data: "teststse",
        child: taskcell(task, "category", summary.toString(), "duedate"),
        feedback: taskcell(task, "category", summary.toString(), "duedate"),
        childWhenDragging: Container(
          width: MediaQuery.of(context).size.width / 4,
          //padding: const EdgeInsets.all(paddingMid),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    offset: const Offset(0, 6),
                    color: lightGrey.withOpacity(0.4),
                    blurRadius: 5)
              ],
              color: legistwhite,
              //border: Border.all(color: lightGrey, width: .5),
              borderRadius: BorderRadius.circular(5)),
          child: CustomText(text: "isdrag"),
        ));
  }

  Widget mydraggable(String task, int summary, int status) {
    return FutureBuilder(
      future: mydragdata(summary, status, taskscp),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Column(
            children: [
              Draggable(
                  data: snapshot.data[0],
                  //data: "teststse",
                  child:
                      taskcell(task, "category", summary.toString(), "duedate"),
                  feedback:
                      taskcell(task, "category", summary.toString(), "duedate"),
                  childWhenDragging: Container(
                    width: MediaQuery.of(context).size.width / 4,
                    //padding: const EdgeInsets.all(paddingMid),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              offset: const Offset(0, 6),
                              color: lightGrey.withOpacity(0.4),
                              blurRadius: 5)
                        ],
                        color: legistwhite,
                        //border: Border.all(color: lightGrey, width: .5),
                        borderRadius: BorderRadius.circular(5)),
                    child: CustomText(text: "isdrag"),
                  )),
              mydragtarget(status, summary),
            ],
          );
        } else {
          return taskcell(task, "category", summary.toString(), "duedate");
        }
      },
    );
  }

  Future<List> mydragdata(
      int prior, int status, QuerySnapshot<Object> mysnap) async {
    QuerySnapshot snap = await await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.appState.myid)
        .collection('tasks')
        .doc(widget.myindex.selectedTask)
        .collection('taskscol')
        .get();

    List<String> docInfo = [/* 'docId', 'taskName' */];

    for (var document in snap.docs) {
      if (document['priority'] == prior && document['status'] == status) {
        //return document.id;
        docInfo.add(document.id);
        //  } else {
        //    return "empty";
        //  }
        return docInfo;
      }
    }
  }

  Widget taskcontainer() {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              CustomText(
                text: isloaded(),
              ),
              getcurrentnum(0),
              getcurrentnum(1),
              getcurrentnum(2),
              //reloadbtn()
            ],
          ),
          Expanded(
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Padding(
                padding: const EdgeInsets.all(paddingMain),
                child: DragAndDropLists(
                  contentsWhenEmpty: CircularProgressIndicator(),
                  axis: Axis.horizontal,
                  listWidth: MediaQuery.of(context).size.width / 4,
                  listDraggingWidth: MediaQuery.of(context).size.width / 4,
                  children: List.generate(3, (index) => _buildList(index)),
                  onItemReorder: _onItemReorder,
                  onListReorder: _onListReorder,
                  listPadding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  itemDivider: Divider(
                    thickness: 2,
                    height: 2,
                    color: backgroundColor,
                  ),
                  itemDecorationWhileDragging: BoxDecoration(
                    color: legistwhite,
                    boxShadow: [
                      BoxShadow(
                          offset: const Offset(0, 6),
                          color: lightGrey.withOpacity(0.4),
                          blurRadius: 5)
                    ],
                  ),
                  listInnerDecoration: const BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  lastItemTargetHeight: 8,
                  addLastItemTargetHeightToTop: true,
                  lastListTargetSize: 40,
                  listDragHandle: const DragHandle(
                    verticalAlignment: DragHandleVerticalAlignment.top,
                    child: Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Icon(
                        Icons.drag_indicator_sharp,
                        color: Colors.black26,
                      ),
                    ),
                  ),
                  itemDragHandle: const DragHandle(
                    child: Padding(
                      padding: EdgeInsets.only(right: 30),
                      child: Icon(
                        Icons.drag_indicator,
                        color: Colors.blueGrey,
                      ),
                    ),
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
                        return StatefulBuilder(builder: (context, setState) {
                          return AlertDialog(
                            content: myskillss(),
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
      ),
    );
  }

  String isloaded() {
    //getRelatedTasks();
    return "Loaded";
  }

  Widget myskillss() {
    return Form(
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
            return value.isNotEmpty ? null : "Invalid Field";
          },
          decoration: const InputDecoration(hintText: "Enter Name"),
        ),
        TextFormField(
          controller: statusController,
          validator: (value) {
            return value.isNotEmpty ? null : "Invalid Field";
          },
          decoration: const InputDecoration(hintText: "Enter Status"),
        ),
        TextFormField(
          controller: descriptionController,
          validator: (value) {
            return value.isNotEmpty ? null : "Invalid Field";
          },
          decoration: const InputDecoration(hintText: "Enter Description"),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    ));
  }

  Widget mypresswidget(BuildContext context) {
    return TextButton(
      child: const CustomText(text: 'Okay'),
      onPressed: () {
        addtask
            .add({
              'name': _titleController.text,
              'status': int.parse(statusController.text),
              'description': descriptionController.text,
              'priority': int.parse(statusController.text) < 1
                  ? int.parse(taskipnum)
                  : int.parse(statusController.text) > 1
                      ? int.parse(taskcpnum)
                      : int.parse(tasktdnum),
            })
            .then((value) => print('Task added successfully'))
            .catchError((error) => print('Failed to create new Task: $error'));
        Navigator.pop(context);
        return;
      },
    );
  }

  _onItemReorder(
      int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    setState(() {
      //var movedItem = _lists[oldListIndex].title.removeAt(oldItemIndex);
      //_lists[newListIndex].title.insert(newItemIndex, movedItem);
      updateitemsup(oldItemIndex, newItemIndex, oldListIndex, newListIndex);
      //initState();
      Navigator.pop(context);
      /*Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DragTask(
                  appState: widget.appState,
                  myindex: widget.myindex,
                )),
      );*/
      //widget.appState.selectedIndex = 13;
      //widget.myindex.selectedTask = "case0008_060722";
    });
  }

  _onListReorder(int oldListIndex, int newListIndex) {
    setState(() {
      //var movedList = _lists.removeAt(oldListIndex);
      // _lists.insert(newListIndex, movedList);
    });
  }

  void updatelist(int i, int j, int k, int l) {
    testtask
        .add({'itemold': i, 'listold': j, 'itemnew': k, 'listnew': l})
        .then((value) => print('Notes added successfully'))
        .catchError((error) => print('Failed to create new Notes: $error'));
  }

  //void updateitem(int i, int j, int k, int l) {}

  void updateitemsup(int olditem, int newitem, int oldlist, int newlist) {
    if (oldlist == newlist) {
      if (oldlist < 1) {
        if (olditem == newitem) {
        } else if (olditem > newitem) {
          updateitemsup2(olditem, newitem, tasksip);
        } else {
          updateitemsdown2(olditem, newitem, tasksip);
        }
      } else if (oldlist > 1) {
        if (olditem == newitem) {
        } else if (olditem > newitem) {
          updateitemsup2(olditem, newitem, taskscp);
        } else {
          updateitemsdown2(olditem, newitem, taskscp);
        }
      } else {
        if (olditem == newitem) {
        } else if (olditem > newitem) {
          updateitemsup2(olditem, newitem, taskstd);
        } else {
          updateitemsdown2(olditem, newitem, taskstd);
        }
      }
    } else {
      if (oldlist < 1) {
        updateitemoldlist(olditem, newitem, oldlist, newlist, tasksip);
      } else if (oldlist > 1) {
        updateitemoldlist(olditem, newitem, oldlist, newlist, taskscp);
      } else {
        updateitemoldlist(olditem, newitem, oldlist, newlist, taskstd);
      }

      if (newlist < 1) {
        updateitemnewlist(olditem, newitem, oldlist, newlist, tasksip);
      } else if (newlist > 1) {
        updateitemnewlist(olditem, newitem, oldlist, newlist, taskscp);
      } else {
        updateitemnewlist(olditem, newitem, oldlist, newlist, taskstd);
      }
    }
  }

  void updateitemsup2(int olditem, int newitem, QuerySnapshot<Object> mysnap) {
    for (var document in mysnap.docs) {
      if (document['priority'] == olditem) {
        //document[0][''].toString();
        //testtask.add({'name': document[0]['name'].toString()});
        addtask.doc(document.id).update({'priority': newitem});
      } else if (document['priority'] < newitem) {
      } else if (document['priority'] > olditem) {
      } else {
        addtask
            .doc(document.id)
            .update({'priority': (document['priority'] + 1)});
      }
    }
  }

  void updateitemsdown2(
      int olditem, int newitem, QuerySnapshot<Object> mysnap) {
    for (var document in mysnap.docs) {
      if (document['priority'] == olditem) {
        //document[0][''].toString();
        //testtask.add({'name': document[0]['name'].toString()});
        addtask.doc(document.id).update({'priority': newitem});
      } else if (document['priority'] > newitem) {
      } else if (document['priority'] < olditem) {
      } else {
        addtask
            .doc(document.id)
            .update({'priority': (document['priority'] - 1)});
      }
    }
  }

  updateitemoldlist(int oldItem, int newItem, int oldList, int newList,
      QuerySnapshot<Object> mysnap) {
    for (var document in mysnap.docs) {
      if (document['status'] == oldList) {
        if (document['priority'] == oldItem) {
          addtask
              .doc(document.id)
              .update({'priority': newItem, 'status': newList});
        } else if (document['priority'] > oldItem) {
          addtask
              .doc(document.id)
              .update({'priority': (document['priority'] - 1)});
        } else if (document['priority'] > oldItem) {}
      }
    }
  }

  updateitemnewlist(int oldItem, int newItem, int oldList, int newList,
      QuerySnapshot<Object> mysnap) {
    for (var document in mysnap.docs) {
      if (document['status'] == newList) {
        if (document['priority'] >= newItem) {
          addtask.doc(document.id).update({
            'priority': (document['priority'] + 1),
          });
        } else if (document['priority'] > newItem) {}
      }
    }
  }

  Widget reloadbtn() {
    return ElevatedButton(
        onPressed: () {
          widget.appState.selectedIndex = 11;
          widget.myindex.selectedTask = "case0003_080722";
        },
        child: CustomText(
          text: "RELOAD",
        ));
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
}

class InnerList {
  final String name;
  List<String> title;
  List<String> summary;
  InnerList({@required this.name, @required this.title, this.summary});
}
