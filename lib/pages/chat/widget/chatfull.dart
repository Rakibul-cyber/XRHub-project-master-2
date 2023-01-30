import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:urlnav2/appState.dart';
import 'package:urlnav2/constants/custom_text.dart';
import 'package:urlnav2/constants/style.dart';
import 'package:urlnav2/helpers/reponsiveness.dart';
import 'package:urlnav2/pages/chat/widget/chatfunction.dart';
import 'package:urlnav2/pages/chat/widget/constants.dart';

class ChatFullPage extends StatefulWidget {
  final AppState appState;
  const ChatFullPage({Key key, this.appState}) : super(key: key);
  @override
  _ChatFullPage createState() => _ChatFullPage();
}

class _ChatFullPage extends State<ChatFullPage> {
  TextEditingController messageEditingController = new TextEditingController();
  TextEditingController searchController = new TextEditingController();
  Stream chatRooms;
  String mychatroomid = "Chats";
  bool issearch = false;
  bool isLoading = false;
  QuerySnapshot searchResultSnapshot;
  QuerySnapshot nameSnapshot;
  @override
  void initState() {
    getUserInfogetChats();
    super.initState();
  }

  getUserInfogetChats() async {
    await getmyusername().then((snapshot) {
      setState(() {
        nameSnapshot = snapshot;
      });
    });
    Constants.myName = nameSnapshot.docs[0]["firstname"];
    //Constants.myName = "Vikram";
    getUserChats(Constants.myName).then((snapshots) {
      setState(() {
        chatRooms = snapshots;
      });
    });
  }

  getmyusername() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(widget.appState.myid)
        .collection('details')
        .get();
  }

  getUserChats(String itIsMyName) async {
    return await FirebaseFirestore.instance
        .collection("chatRoom")
        .where('users', arrayContains: itIsMyName)
        .snapshots();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.transparent,
              margin: ResponsiveWidget.isSmallScreen(context)
                  ? const EdgeInsets.all(10)
                  : const EdgeInsets.all(20),
              child: Row(
                children: [
                  Flexible(
                      flex: 1,
                      child: Column(
                        children: [
                          chatsearch(),
                          if (issearch) ...[
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: userList(),
                            ))
                          ] else ...[
                            Expanded(child: chatRoomsListmain())
                          ]
                        ],
                      )),
                  if (!ResponsiveWidget.isSmallScreen(context))
                    Container(
                      width: 1,
                      color: lightGrey,
                    ),
                  if (!ResponsiveWidget.isSmallScreen(context)) ...[
                    if (mychatroomid == "Chats") ...[
                      Flexible(
                        flex: 4,
                        child: Container(
                          color: silver,
                          child: ListView(
                            children: [
                              Image.asset(
                                'assets/images/chatimg.png',
                                width: 450,
                                height: 500,
                              ),
                              //Expanded(child: Container()),
                              Row(
                                children: [
                                  Flexible(flex: 1, child: Container()),
                                  Flexible(
                                    flex: 2,
                                    child: Column(
                                      children: [
                                        CustomText(
                                          text:
                                              "Chat with your clients and other members",
                                          color: grey,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.lock_outline,
                                              color: grey,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            CustomText(
                                              color: grey,
                                              text: "End-to-end Encripted",
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Flexible(flex: 1, child: Container()),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ] else ...[
                      Flexible(flex: 4, child: mychats()),
                    ]
                  ]
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget userList() {
    return issearch
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: searchResultSnapshot.docs.length,
            itemBuilder: (context, index) {
              return userTile(
                searchResultSnapshot.docs[index]["firstname"],
                searchResultSnapshot.docs[index]["email"],
              );
            })
        : Container();
  }

  Widget userTile(String name, String email) {
    return InkWell(
      onTap: () {
        sendMessage(name);
      },
      child: CustomText(
        text: name,
      ),
    );
  }

  sendMessage(String userName) {
    List<String> users = [Constants.myName, userName];

    String chatRoomId = getChatRoomId(Constants.myName, userName);

    Map<String, dynamic> chatRoom = {
      "users": users,
      "chatRoomId": chatRoomId,
    };

    addChatRoom(chatRoom, chatRoomId);

    setState(() {
      mychatroomid = chatRoomId;
    });
  }

  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  Future<bool> addChatRoom(chatRoom, chatRoomId) {
    FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .set(chatRoom)
        .catchError((e) {
      print(e);
    });
  }

  Widget chatsearch() {
    return Container(
      padding: const EdgeInsets.all(10),
      color: Colors.transparent,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                  padding: EdgeInsets.all(2),
                  margin: EdgeInsets.all(2),
                  child: CustomText(
                    text: "Messaging",
                    color: dark,
                    weight: FontWeight.bold,
                  )),
              Expanded(child: Container()),
              Icon(
                Icons.menu,
                color: dark,
              )
            ],
          ),
          Container(
            padding: const EdgeInsets.all(5),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
              decoration: BoxDecoration(
                border: Border.all(color: lightGrey, width: .5),
                color: light,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: InkWell(
                  onTap: () async {
                    if (searchController.text.isNotEmpty) {
                      setState(() {
                        isLoading = true;
                      });
                      await searchByName(searchController.text)
                          .then((snapshot) {
                        searchResultSnapshot = snapshot;

                        setState(() {
                          isLoading = false;
                          issearch = true;
                        });
                      });
                    }
                  },
                  child: const Icon(
                    Icons.search,
                    color: lightGrey,
                  ),
                ),
                title: TextField(
                  controller: searchController,
                  style: TextStyle(color: lightGrey, fontSize: 15),
                  decoration: InputDecoration(
                      hintText: "Search or start new chat",
                      hintStyle: TextStyle(
                        color: lightGrey,
                        fontSize: 15,
                      ),
                      border: InputBorder.none),
                ),
                trailing: searchController.text != ""
                    ? InkWell(
                        onTap: () {
                          setState(() {
                            issearch = false;
                            searchController.text = "";
                          });
                        },
                        child: CustomText(
                          text: "x",
                          color: lightGrey,
                        ),
                      )
                    : CustomText(
                        text: "X",
                        color: Colors.transparent,
                      ),
              ),
            ),
          ),
          Divider(
            height: 10,
            thickness: 1.0,
            indent: 5,
            endIndent: 5,
          )
        ],
      ),
    );
  }

  searchByName(String searchField) {
    return FirebaseFirestore.instance
        .collection("users")
        .where('firstname', isEqualTo: searchField)
        .get();
  }

  Widget mychats() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.transparent,
        //borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: [
          Flexible(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: Container()),
                CustomText(
                  text: mychatroomid
                      .toString()
                      .replaceAll("_", "")
                      .replaceAll(Constants.myName, ""),
                  size: 18,
                  weight: FontWeight.bold,
                  color: dark,
                ),
                Expanded(child: Container()),
                InkWell(
                  onTap: () async {
                    widget.appState.selectedIndex = 16;
                  },
                  child: Icon(
                    Icons.video_call_outlined,
                    color: dark,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                //SettingsIcons(),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Flexible(
            flex: 10,
            child: ChatFunction(
              chatRoomId: mychatroomid,
            ),
          )
        ],
      ),
    );
  }

  Widget chatclicked() {
    return Center(
      child: CustomText(
        text: mychatroomid,
      ),
    );
  }

  Widget chatRoomsListmain() {
    return StreamBuilder<QuerySnapshot>(
      stream: chatRooms,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ChatRoomsTile(
                      snapshot.data.docs[index]['chatRoomId']
                          .toString()
                          .replaceAll("_", "")
                          .replaceAll(Constants.myName, ""),
                      snapshot.data.docs[index]["chatRoomId"]);
                })
            : Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: legistwhite,
                  ),
                  child: CircularProgressIndicator(),
                ),
              );
      },
    );
  }

  Widget ChatRoomsTile(String userName, String chatRoomId) {
    return InkWell(
      onHover: (value) {},
      onTap: () {
        if (ResponsiveWidget.isSmallScreen(context)) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatFunction(
                        chatRoomId: chatRoomId,
                      )));
        } else {
          setState(() {
            mychatroomid = chatRoomId;
          });
        }
      },
      child: Container(
        color: Colors.white24,
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            Divider(
              height: 10,
              thickness: 1.0,
              indent: 5,
              endIndent: 5,
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      color: legistblue,
                      borderRadius: BorderRadius.circular(30)),
                  child: Text(userName.substring(0, 1).toUpperCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'OverpassRegular',
                          fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  width: 12,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(userName,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: dark,
                            fontSize: 16,
                            fontFamily: 'OverpassRegular',
                            fontWeight: FontWeight.w500)),
                    SizedBox(
                      height: 5,
                    ),
                    getlastmessage(chatRoomId),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget getlastmessage(String myid) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("chatRoom")
          .doc(myid)
          .collection("chats")
          .orderBy('time', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (snapshot.data.size == 0) {
          return CustomText(
            text: "",
          );
        } else {
          return CustomText(
            text: overflowtext(
                "${whosend(snapshot.data.docs[0]["sendBy"].toString())}: ${whatyousent(snapshot.data.docs[0]["ismessage"], snapshot.data.docs[0]["message"])}"),
            talign: TextAlign.start,
            color: grey,
            size: 15,
          );
        }
      },
    );
  }

  String whosend(String sendby) {
    if (sendby == Constants.myName) {
      return "You";
    } else {
      return sendby;
    }
  }

  IconData whaticonyousent(bool ismessage, String message) {
    if (!ismessage && message == "") {
      return Icons.camera_alt_outlined;
    } else {
      return null;
    }
  }

  String whatyousent(bool ismessage, String message) {
    if (!ismessage && message == "") {
      return "Photo";
    } else {
      return message;
    }
  }

  String overflowtext(String mystring) {
    int truncateAt = 20;
    String elepsis = "...";

    if (mystring.length > truncateAt) {
      return mystring.substring(0, truncateAt - elepsis.length) + elepsis;
    } else {
      return mystring;
    }
  }
}

class ItemModel {
  String title;
  IconData icon;
  String pageroute;

  ItemModel(this.title, this.icon, this.pageroute);
}
