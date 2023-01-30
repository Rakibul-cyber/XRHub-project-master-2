import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:urlnav2/appState.dart';
import 'package:urlnav2/constants/custom_text.dart';
import 'package:urlnav2/constants/style.dart';
import 'package:urlnav2/pages/tasks/selectedtaskstate.dart';

class DragTask4 extends StatefulWidget {
  final SelectedTaskState myindex;
  final AppState appState;
  DragTask4({
    Key key,
    this.appState,
    this.myindex,
  }) : super(key: key);

  @override
  _DragHandle4Example createState() => _DragHandle4Example();
}

class _DragHandle4Example extends State<DragTask4> {
  CollectionReference addtask;
  String taskipnum;
  String tasktdnum;
  String taskcpnum;
  CollectionReference testtask;
  String mydragdatastring = "draghere";

  @override
  void initState() {
    addtask = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.appState.myid)
        .collection('tasks')
        .doc(widget.myindex.selectedTask)
        .collection('taskscol');

    testtask = FirebaseFirestore.instance.collection('mytask');

    super.initState();
  }

  Widget taskcell(
      String task, String category, String priority, String duedate) {
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
                    return mydraglist(
                        data.docs[index]["name"],
                        data.docs[index]["priority"],
                        data.docs[index]["status"]);
                  });
            }),
      ],
    );
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
    return FutureBuilder(
      future: mydragdata(dragitem, draglist),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Draggable(
              data:
                  "${snapshot.data[0]},${snapshot.data[1]},${snapshot.data[2]}",
              //data: "teststse",
              child: taskcell(task, "category",
                  "${draglist.toString()} ${dragitem.toString()}", "duedate"),
              feedback: taskcell(task, "category",
                  "${draglist.toString()} ${dragitem.toString()}", "duedate"),
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
        } else {
          return taskcell(task, "category", draglist.toString(), "duedate");
        }
      },
    );
  }

  Future<List> mydragdata(int dragitem, int draglist) async {
    QuerySnapshot snap = await await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.appState.myid)
        .collection('tasks')
        .doc(widget.myindex.selectedTask)
        .collection('taskscol')
        .get();

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
          child: CustomText(text: "$mydragdatastring $targetlist $targetitem"),
        );
      },
      onAccept: (String data) {
        setState(() {
          final splitstring = data.split(",");
          mydragdatastring = splitstring[0];

          int draglist = int.parse(splitstring[2]);
          int dragitem = int.parse(splitstring[1]);

          //addtask.doc(data).update({'status': splitstring[2]});
          updatelist(dragitem, draglist, targetitem, targetlist);
        });
      },
    );
  }

  void updatelist(int dragitem, int draglist, int targetitem, int targetlist) {
    testtask
        .add({
          'dragitem': dragitem,
          'draglist': draglist,
          'targetitem': targetitem,
          'targetlist': targetlist
        })
        .then((value) => print('Notes added successfully'))
        .catchError((error) => print('Failed to create new Notes: $error'));
  }

  void onmyitemreorder(String data, int status) {
    setState(() {
      //mydragdatastring = data;
      addtask.doc(data).update({'status': status});
    });
  }

  _onItemReorder(int dragitemIndex, int draglistIndex, int targetitemIndex,
      int targetlistIndex) {
    setState(() {
      //updateitemsup(dragitemIndex, targetitemIndex, draglistIndex, targetlistIndex);
    });
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

  /*Widget mydragtargetmain(
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
