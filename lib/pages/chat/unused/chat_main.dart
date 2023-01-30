import 'package:flutter/material.dart';
import 'package:urlnav2/appState.dart';
import 'package:urlnav2/constants/custom_text.dart';
import 'package:urlnav2/helpers/reponsiveness.dart';
import 'package:urlnav2/pages/chat/unused/chat.dart';
import 'package:urlnav2/pages/chat/unused/chatrooms.dart';
import 'package:urlnav2/pages/chat/unused/search.dart';

class ChatPage extends StatelessWidget {
  AppState appState;
  ChatPage({this.appState, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Container(
                  margin: EdgeInsets.only(
                      top: ResponsiveWidget.isSmallScreen(context) ? 56 : 6),
                  child: CustomText(
                    text: "My Contacts",
                    size: 24,
                    weight: FontWeight.bold,
                  )),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          Expanded(
            child: Container(
              child: Row(
                children: [
                  Flexible(
                      flex: 1,
                      child: Column(
                        children: [
                          Flexible(flex: 1, child: Search()),
                          Flexible(flex: 5, child: ChatRoom()),
                        ],
                      )),
                  Flexible(
                    flex: 4,
                    child: Chat(
                      chatRoomId: "test5_test6",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
