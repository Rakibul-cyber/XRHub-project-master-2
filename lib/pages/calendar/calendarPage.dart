import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:urlnav2/appState.dart';
import 'package:urlnav2/constants/custom_text.dart';
import 'package:urlnav2/constants/style.dart';
import 'package:urlnav2/helpers/reponsiveness.dart';
import 'package:urlnav2/pages/calendar/eventClient.dart';
import 'package:urlnav2/pages/calendar/eventclientlist.dart';

class CalendarPage extends StatefulWidget {
  final AppState appState;
  const CalendarPage({Key key, this.appState}) : super(key: key);
  @override
  _CalendarPage createState() => _CalendarPage();
}

class _CalendarPage extends State<CalendarPage> {
  Stream<QuerySnapshot> events;
  Stream<QuerySnapshot> clients;
  CollectionReference eventsCollection;
  EventClient clientname = new EventClient();

  final TextEditingController eventtitleCont = TextEditingController();
  final TextEditingController eventdescCont = TextEditingController();

  @override
  void initState() {
    super.initState();
    events = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.appState.myid)
        .collection('events')
        .snapshots();
    clients = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.appState.myid)
        .collection('clients')
        .snapshots();
    eventsCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.appState.myid)
        .collection('events');
  }

  Future<void> showInformationDialog2(BuildContext context,
      AsyncSnapshot<QuerySnapshot> snapshot, CalendarTapDetails details) async {
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
                                return EventClientList(
                                  data: snapshot.data,
                                  index: index,
                                  clientname: clientname,
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
                    await showInformationDialog(context, details);
                  },
                ),
              ],
            );
          });
        });
  }

  Future<void> showInformationDialog(
    BuildContext context,
    CalendarTapDetails details,
  ) async {
    return await showDialog(
        context: context,
        builder: (context) {
          bool isAllDay = false;
          String starttime = '00:00';
          String endtime = '00:00';
          String repeatValue = 'Doesn\'t repeat';

          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: Container(
                width: MediaQuery.of(context).size.width / 3,
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
                          ListTile(
                            leading: Icon(
                              Icons.more_time_sharp,
                              color: Colors.transparent,
                            ),
                            title: CustomText(
                              text: "Add Event",
                              weight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ListTile(
                            leading: Icon(Icons.person_add_outlined),
                            title: StreamBuilder<QuerySnapshot>(
                              stream: clients,
                              builder: (
                                BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot,
                              ) {
                                if (!snapshot.hasData) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else {
                                  return InkWell(
                                    onTap: () async {
                                      Navigator.pop(context);
                                      await showInformationDialog2(
                                        context,
                                        snapshot,
                                        details,
                                      );
                                    },
                                    child: Container(
                                      child: CustomText(
                                        text: clientname.getmyName,
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                            trailing: Icon(Icons.arrow_drop_down_outlined),
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.edit,
                            ),
                            title: TextFormField(
                              controller: eventtitleCont,
                              validator: (value) {
                                return value.isNotEmpty
                                    ? null
                                    : "Invalid Field";
                              },
                              decoration:
                                  InputDecoration(hintText: "Add Event Title"),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ListTile(
                            leading: Icon(Icons.list_outlined),
                            title: TextFormField(
                              controller: eventdescCont,
                              validator: (value) {
                                return value.isNotEmpty
                                    ? null
                                    : "Invalid Field";
                              },
                              decoration:
                                  InputDecoration(hintText: "Add Desciption"),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ListTile(
                            leading: Icon(Icons.calendar_today),
                            title: Row(
                              children: [
                                CustomText(
                                  text:
                                      "${_getDayDate(details.date.weekday)}, ${details.date.day.toString()} ${_getMonthDate(details.date.month)}",
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          ListTile(
                            leading: Icon(Icons.more_time_sharp),
                            title: Row(
                              children: [
                                DropdownButton<String>(
                                  //key: ,
                                  value: starttime,
                                  menuMaxHeight: 200,
                                  isDense: true,
                                  //elevation: 16,
                                  icon: null,
                                  style: const TextStyle(color: Colors.black),
                                  onChanged: (value) {
                                    setState(() {
                                      starttime = value;
                                    });
                                  },
                                  items: <String>[
                                    '00:00',
                                    '01:00',
                                    '02:00',
                                    '03:00',
                                    '04:00',
                                    '05:00',
                                    '06:00',
                                    '07:00',
                                    '08:00',
                                    '09:00',
                                    '10:00',
                                    '11:00',
                                    '12:00',
                                    '13:00',
                                    '14:00',
                                    '15:00',
                                    '16:00',
                                    '17:00',
                                    '18:00',
                                    '19:00',
                                    '20:00',
                                    '21:00',
                                    '22:00',
                                    '23:00',
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                DropdownButton<String>(
                                  //key: ,
                                  value: endtime,
                                  //elevation: 16,
                                  menuMaxHeight: 200,
                                  isDense: true,
                                  icon: null,
                                  style: const TextStyle(color: Colors.black),
                                  onChanged: (value) {
                                    setState(() {
                                      endtime = value;
                                    });
                                  },
                                  items: <String>[
                                    '00:00',
                                    '01:00',
                                    '02:00',
                                    '03:00',
                                    '04:00',
                                    '05:00',
                                    '06:00',
                                    '07:00',
                                    '08:00',
                                    '09:00',
                                    '10:00',
                                    '11:00',
                                    '12:00',
                                    '13:00',
                                    '14:00',
                                    '15:00',
                                    '16:00',
                                    '17:00',
                                    '18:00',
                                    '19:00',
                                    '20:00',
                                    '21:00',
                                    '22:00',
                                    '23:00',
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.more_time_sharp,
                              color: Colors.transparent,
                            ),
                            title: Row(
                              children: [
                                Checkbox(
                                    activeColor: legistblue,
                                    value: isAllDay,
                                    onChanged: (checked) {
                                      setState(() {
                                        isAllDay = checked;
                                      });
                                    }),
                                CustomText(
                                  text: "All Day",
                                ),
                              ],
                            ),
                          ),
                          ListTile(
                              leading: Icon(Icons.more_time_sharp),
                              title: DropdownButton<String>(
                                value: repeatValue,
                                //elevation: 16,
                                icon: null,
                                style: const TextStyle(color: Colors.black),
                                onChanged: (value) {
                                  setState(() {
                                    repeatValue = value;
                                  });
                                },
                                items: <String>[
                                  'Doesn\'t repeat',
                                  'Daily',
                                  'Every Week',
                                  'Every Month',
                                  'Annually'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              )),
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
                  onPressed: () {
                    //if (_formKey.currentState.validate()) {
                    // Do something like updating SharedPreferences or User Settings etc.
                    if (eventtitleCont.text.isEmpty) {
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Creating new Event in database...'),
                      ));
                      eventsCollection
                          .add({
                            'eventyear': "${details.date.year.toString()}",
                            'eventdate': "${details.date.day.toString()}",
                            'eventtitle': eventtitleCont.text.toString(),
                            'eventdesc': eventdescCont.text.toString(),
                            'eventmonth': "${details.date.month.toString()}",
                            'starttime': starttime,
                            'endtime': endtime,
                            'isallday': isAllDay,
                            'repeat': repeatValue,
                            'clientname': clientname.getmyName,
                          })
                          .then((value) => print('Event added successfully'))
                          .catchError((error) =>
                              print('Failed to create new event: $error'));
                    }
                    Navigator.pop(context);
                    //}
                  },
                ),
              ],
            );
          });
        });
  }

  String _getMonthDate(int month) {
    if (month == 01) {
      return 'January';
    } else if (month == 02) {
      return 'February';
    } else if (month == 03) {
      return 'March';
    } else if (month == 04) {
      return 'April';
    } else if (month == 05) {
      return 'May';
    } else if (month == 06) {
      return 'June';
    } else if (month == 07) {
      return 'July';
    } else if (month == 08) {
      return 'August';
    } else if (month == 09) {
      return 'September';
    } else if (month == 10) {
      return 'October';
    } else if (month == 11) {
      return 'November';
    } else {
      return 'December';
    }
  }

  String _getDayDate(int day) {
    if (day == 01) {
      return 'Monday';
    } else if (day == 02) {
      return 'Tuesday';
    } else if (day == 03) {
      return 'Wednesday';
    } else if (day == 04) {
      return 'Thursday';
    } else if (day == 05) {
      return 'Friday';
    } else if (day == 06) {
      return 'Saturday';
    } else {
      return 'Sunday';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
          stream: events,
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
            //final data = snapshot.requireData;

            return Container(
              margin: EdgeInsets.all(
                  ResponsiveWidget.isLargeScreen(context) ? 50 : 10),
              padding: EdgeInsets.all(
                  ResponsiveWidget.isLargeScreen(context) ? 50 : 10),
              decoration: BoxDecoration(
                color: legistwhite,
                border: Border.all(color: active.withOpacity(.4), width: .5),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 6),
                      color: legistbluelight,
                      blurRadius: 12)
                ],
                borderRadius: BorderRadius.circular(15),
              ),
              child: mysfcalendar(snapshot, calendarTapped),
            );
          }),
    );
  }

  void calendarTapped(CalendarTapDetails details) async {
    await showInformationDialog(context, details);
    //await showClientList2(context);
  }

  Widget mysfcalendar(AsyncSnapshot<QuerySnapshot> snapshot,
      CalendarTapCallback calendarTapCallback) {
    return SfCalendar(
      //controller: calendarController,
      view: CalendarView.month,
      firstDayOfWeek: 1,
      dataSource: MeetingDataSource(getAppointments(snapshot)),
      showNavigationArrow: true,
      showDatePickerButton: true,
      allowViewNavigation: false,
      monthViewSettings: MonthViewSettings(
          appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
          showTrailingAndLeadingDates: true,
          appointmentDisplayCount: 4),
      allowedViews: <CalendarView>[
        CalendarView.day,
        CalendarView.week,
        CalendarView.workWeek,
        CalendarView.month,
        CalendarView.schedule
      ],
      onTap: calendarTapCallback,
    );
  }

  List<Appointment> getAppointments(AsyncSnapshot<QuerySnapshot> snapshot) {
    List<Appointment> meetings = <Appointment>[];
    final data = snapshot.requireData;

    for (int i = 0; i < snapshot.data.docs.length; i++) {
      //DocumentSnapshot snap = snapshot.data.docs[i];
      meetings.add(Appointment(
        startTime: DateTime(
            int.parse(data.docs[i]["eventyear"]),
            int.parse(data.docs[i]["eventmonth"]),
            int.parse(data.docs[i]["eventdate"]),
            int.parse(data.docs[i]["starttime"].substring(0, 2)),
            0,
            0),
        endTime: DateTime(
            int.parse(data.docs[i]["eventyear"]),
            int.parse(data.docs[i]["eventmonth"]),
            int.parse(data.docs[i]["eventdate"]),
            int.parse(data.docs[i]["endtime"].substring(0, 2)),
            0,
            0),
        subject: data.docs[i]["eventtitle"],
        notes: data.docs[i]["eventdesc"],
        color: Colors.blue,
        //recurrenceRule: 'FREQ=DAILY',
        isAllDay: data.docs[i]["isallday"],
      ));
    }

    return meetings;
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}
