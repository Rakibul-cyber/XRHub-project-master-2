import 'dart:convert';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:urlnav2/appState.dart';
import 'package:urlnav2/constants/style.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';

class MailScreen2 extends StatefulWidget {
  final QuerySnapshot data;
  final AppState appState;
  const MailScreen2({Key key, this.data, this.appState}) : super(key: key);

  @override
  _MailScreen2State createState() => _MailScreen2State();
}

class _MailScreen2State extends State<MailScreen2> {
  final controllerName = TextEditingController();
  final controllerTo = TextEditingController();
  final controllerSubject = TextEditingController();
  final controllerMessage = TextEditingController();

  String createdViewId = Random().nextInt(1000).toString();

  @override
  void initState() {
    super.initState();
  }

  int myindex = 0;

  bool notClicked = true;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        IntrinsicHeight(
          child: Row(
            children: [
              Flexible(
                child: Container(child: mails(context)),
              ),
              if (notClicked) ...[
                Flexible(
                  child: Container(child: mailform()),
                ),
              ] else ...[
                Flexible(
                    child: Container(
                  child: maildetails(context, myindex),
                )),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget mailform() {
    CollectionReference firestore = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.appState.myid)
        .collection('emails');
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Container(
        decoration: BoxDecoration(
          color: legistwhite,
          border: Border.all(color: active.withOpacity(.4), width: .5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              buildTextField(title: 'Your Name:', controller: controllerName),
              const SizedBox(
                height: 8,
              ),
              buildTextField(title: 'To:', controller: controllerTo),
              const SizedBox(height: 8),
              buildTextField(title: 'Subject:', controller: controllerSubject),
              const SizedBox(height: 20),

              buildOutlinedTextField(
                title: '\nMessage:',
                controller: controllerMessage,
                maxLines: 20,
              ),
              //const SizedBox(height: 10),

              // SizedBox(
              //   height: 340,
              //   child: HtmlElementView(
              //     viewType: createdViewId,
              //   ),
              // ),

              const SizedBox(height: 20),
              Container(
                constraints: BoxConstraints(maxWidth: 150),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        alignment: Alignment.center,
                        minimumSize: Size.fromHeight(50),
                        textStyle: TextStyle(fontSize: 18),
                        primary: legistblue),
                    child: Center(
                      child: Row(
                        children: [
                          Icon(Icons.send),
                          SizedBox(width: 10),
                          Text('SEND'),
                        ],
                      ),
                    ),
                    onPressed: () => {
                          //WHY CAN SEND WHEN EMPTY
                          sendEmail(
                            name: controllerName.text,
                            email: FirebaseAuth.instance.currentUser.email,
                            toEmail: controllerTo.text,
                            subject: controllerSubject.text,
                            message: controllerMessage.text,
                          ),
                          firestore.add({
                            'name': controllerName.text,
                            'email': FirebaseAuth.instance.currentUser.email,
                            'sendto': controllerTo.text,
                            'subject': controllerSubject.text,
                            'message': controllerMessage.text,
                          }).then((value) {
                            print("Email successfully recorded");
                          }),
                          controllerName.clear(),
                          controllerTo.clear(),
                          controllerSubject.clear(),
                          controllerMessage.clear(),
                        }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget maildetails(BuildContext context, int myindex) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Container(
        decoration: BoxDecoration(
          color: legistwhite,
          border: Border.all(color: active.withOpacity(.4), width: .5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(22.0),
              child: maildata2(myindex),
            ),
          ],
        ),
      ),
    );
  }

  Widget maildata2(int myindex) {
    return mailpage(
        widget.data.docs[myindex]['sendto'],
        widget.data.docs[myindex]['subject'],
        widget.data.docs[myindex]['message'],
        widget.data.docs[myindex]['name'],
        myindex);
  }

  Widget mailpage(
      String sendto, String subject, String message, String name, int index) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
        child: InkWell(
            child: Column(
          children: [
            Row(
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 30, 0, 0),
                    child: Text(
                      subject,
                      maxLines: 3,
                      style: TextStyle(
                        fontSize: 26.0,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0, 0, 0),
                  child: Container(
                      height: 45.0,
                      width: 45.0,
                      decoration: BoxDecoration(
                          color: Colors.pink[400], shape: BoxShape.circle),
                      child: Center(
                        child: Text(
                          'A'.toUpperCase(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Text(
                            sendto,
                            maxLines: 3,
                            style:
                                TextStyle(color: Colors.black, fontSize: 20.0),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          'from ${name}'.substring(0, 1).toUpperCase(),
                          style: TextStyle(
                              color: Colors.grey[800], fontSize: 14.0),
                        ),
                      ],
                    ),
                    Text(
                      '11:45PM',
                      style: TextStyle(color: Colors.grey[800], fontSize: 11.0),
                    )
                  ],
                ),
                Spacer(
                  flex: 1,
                ),
                Row(
                  children: [
                    PopupMenuButton<String>(
                      //offset: Offset(10, 40),
                      onSelected: (value) {
                        print(value);
                      },
                      itemBuilder: (BuildContext context) {
                        return [
                          PopupMenuItem(
                            child: Text("Forward"),
                            value: "Forward",
                          ),
                          PopupMenuItem(
                            child: Text("Add star"),
                            value: "Add star",
                          ),
                          PopupMenuItem(
                            child: Text("Print"),
                            value: "Print",
                          ),
                        ];
                      },
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 50),
            Container(
              padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Text(
                message,
                style: TextStyle(
                  fontSize: 18.0,
                  letterSpacing: 1.0,
                ),
              ),
            ),
            SizedBox(height: 60),
            Divider(
              height: 10,
              thickness: 1,
              indent: 20,
              endIndent: 20,
              color: Colors.grey,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        notClicked = true;
                      });
                    },
                    child: Text('Close')),
                ElevatedButton(
                    onPressed: () {
                      AlertDialog(
                        title: Text('Please Confirm'),
                        content: Text('Delete email?'),
                        actions: [
                          TextButton(
                              onPressed: () {
                                // mails.removeAt(widget.index - 1);
                                // setState(() {
                                //   notClicked = true;
                                // });
                              },
                              child: Text('Yes')),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('No'))
                        ],
                      );
                    },
                    child: Text('Delete')),
              ],
            )
          ],
        )));
  }

//TODO: Update later to exclude EmailJS Hosting.
  Future sendEmail({
    @required String name,
    @required String email,
    @required String toEmail,
    @required String subject,
    @required String message,
  }) async {
    final serviceId = 'service_5yt0w29';
    final templateId = 'template_9zxrgsq';
    final userId = 'g0g9MlOhqpy7fLWhn';

    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final response = await http.post(
      url,
      headers: {
        //'origin': 'http://localhost',
        'Content-Type': 'application/json',
      },
      body: json.encode(
        {
          'service_id': serviceId,
          'template_id': templateId,
          'user_id': userId,
          'template_params': {
            'user_name': name,
            'user_email': email,
            'to_email': toEmail,
            'user_subject': subject,
            'user_message': message,
          },
        },
      ),
    );
    if (name == null ||
        email == null ||
        toEmail == null ||
        subject == null ||
        message == null) {
      return;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Your mail is being sent...'),
      ));
    }
  }

  Widget buildTextField({
    @required String title, // may rm required
    @required TextEditingController controller,
    int maxLines = 1,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.getFont('Roboto', fontWeight: FontWeight.bold),
            textAlign: TextAlign.start,
          ),
          SizedBox(
            height: 10.0,
          ),
          const SizedBox(width: 16),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
            controller: controller,
            maxLines: maxLines,
          ),
        ],
      );

  Widget buildOutlinedTextField({
    @required String title,
    @required TextEditingController controller,
    int maxLines = 1,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.getFont('Roboto', fontWeight: FontWeight.bold),
            textAlign: TextAlign.start,
          ),
          const SizedBox(height: 10),
          // Expanded(
          //   child:
          TextField(
            controller: controller,
            maxLines: maxLines,
            style: TextStyle(fontSize: 14),
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
          //const SizedBox(height: 10),
          //HtmlElementView(viewType: createdViewId)
          // )
        ],
      );

  Widget mails(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(22.0),
              child: TextBox(),
            ),
            Expanded(
              child: SizedBox(
                  width: 500, height: 1000, child: emailslist(context)),
            ),
          ],
        ),
      ),
    );
  }

  Widget emailslist(BuildContext context) {
    return ListView.builder(
      itemCount: widget.data.size,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(bottom: 2.0),
        child: emailscard(
            widget.data.docs[index]['sendto'],
            widget.data.docs[index]['subject'],
            widget.data.docs[index]['message'],
            index),
      ),
    );
  }

  Widget emailscard(String sendto, String subject, String message, int index) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
      child: InkWell(
        onTap: (() {
          setState(() {
            myindex = index;
            notClicked = false;
          });
        }),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          elevation: 4,
          shadowColor: Colors.black,
          color: Colors.white,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text(
                sendto.substring(0, 1).toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
            title: Text(
              "${sendto}\n${subject}",
              style: GoogleFonts.oswald(
                  color: Colors.black, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              '${message}...',
              style: GoogleFonts.roboto(color: Colors.grey),
              maxLines: 2,
            ),
          ),
        ),
      ),
    );
  }
}

class TextBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        cursorHeight: 20,
        decoration: InputDecoration(
          hintText: 'Search in mail',
          border: InputBorder.none,
        ),
        onTap: () {
          showSearch(context: context, delegate: Datasearch());
        },
      ),
    );
  }
}

class Datasearch extends SearchDelegate<String> {
  final names = [];
  final recentSearches = [];
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.mic),
        onPressed: () {},
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? recentSearches
        : names.where((element) => element.startsWith(query)).toList();
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        leading: Icon(Icons.person_search),
        title: RichText(
            text: TextSpan(
                text: suggestionList[index].substring(0, query.length),
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                children: [
              TextSpan(
                  text: suggestionList[index].substring(query.length),
                  style: TextStyle(color: Colors.grey))
            ])),
      ),
      itemCount: suggestionList.length,
    );
  }
}
