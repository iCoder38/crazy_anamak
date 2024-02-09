import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:my_new_orange/classes/all_chat_list/all_chats_list.dart';
// import 'package:my_new_orange/classes/public_chat/public_room_chats.dart';
// import 'package:my_new_orange/header/utils/Utils.dart';
// import 'package:shaawl/classes/headers/utils/utils.dart';
// import 'package:shaawl/classes/tabbar/chat/all_chat_list/all_chats_list.dart';
// import 'package:shaawl/classes/tabbar/chat/public_chat_room/public_room_header/public_chat_room_chats/public_room_chats.dart';
// import 'package:shaawl/classes/tabbar/chat/public_chat_room/public_room_header/public_room_header.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../headers/utils/utils.dart';
import 'public_room_chats.dart';

class PublicChatRoomScreen extends StatefulWidget {
  const PublicChatRoomScreen(
      {super.key, required this.strSenderName, required this.strSenderChatId});

  final String strSenderName;
  final String strSenderChatId;

  @override
  State<PublicChatRoomScreen> createState() => _PublicChatRoomScreenState();
}

class _PublicChatRoomScreenState extends State<PublicChatRoomScreen> {
  //
  final formGlobalKey = GlobalKey<FormState>();
  ScrollController controller = ScrollController();
  //
  TextEditingController contTextSendMessage = TextEditingController();
  //

  @override
  void initState() {
    super.initState();
    /*******************************************/
    /*******************************************/
    if (kDebugMode) {
      print(widget.strSenderName);
    }
    if (kDebugMode) {
      print(widget.strSenderChatId);
    }
    /*******************************************/
    /*******************************************/

    //
    // controller.jumpTo(controller.position.maxScrollExtent);
    //
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(40.0),
          child: AppBar(
            // title: textWithSemiBoldStyle('Chat Room', 16.0, Colors.white),
            automaticallyImplyLeading: false,
            bottom: TabBar(
              padding: const EdgeInsets.all(4.0),
              // controller: _tabController,
              indicatorColor: Colors.purpleAccent,
              isScrollable: false,
              tabs: [
                textWithRegularStyle('Public', 16.0, Colors.black, 'left'),
                textWithRegularStyle('My Chats', 16.0, Colors.black, 'left'),
              ],
            ),
            // actions: const [
            //   Icon(
            //     Icons.exit_to_app,
            //   ),
            // ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            //
          },
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Stack(
              children: [
                // ======> ALL CHATS LIST <======
                // ========================
                PublicChatRoomChats(
                  strLoginSenderChatIdForPublic:
                      widget.strSenderChatId.toString(),
                  strLoginSenderNameForPublic: widget.strSenderName.toString(),
                ),
                // ========================
                // ========================

                // ======> SEND MESSAGE UI <======
                // ========================
                Align(
                  alignment: Alignment.bottomCenter,
                  child: sendMessageUI(),
                ),
                // ========================
                // ========================
                //
              ],
            ),

            // ======> SECOND TAB <======
            // ========================
            // AllChatsListScreen(
            //   str_dialog_login_user_chat_id: widget.strSenderChatId,
            //   // str_dialog_login_user_gender: 'g',
            // ),
            // ========================
            // ========================
          ],
        ),
      ),
    );
  }

  Container sendMessageUI() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      color: Colors.white,
      // height: 60,
      // width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: contTextSendMessage,
                minLines: 1,
                maxLines: 5,
                decoration: const InputDecoration(
                  // border: Border(),
                  // labelText: '',
                  hintText: 'write something',
                ),
              ),
            ),
          ),
          //
          IconButton(
            onPressed: () {
              if (kDebugMode) {
                print('send');
              }
              //

              //
              // if (formGlobalKey.currentState!.validate()) {
              //   if (kDebugMode) {
              //     print('object');
              //   }
              sendMessageViaFirebase(contTextSendMessage.text);
              contTextSendMessage.text = '';
              //
              // sendMessage(contTextSendMessage.text.toString());
              //
              // }
            },
            icon: const Icon(
              Icons.send,
            ),
          ),
          //
        ],
      ),
    );
  }

  //
  // send message
  sendMessageViaFirebase(strLastMessageEntered) {
    // print(cont_txt_send_message.text);

    CollectionReference users = FirebaseFirestore.instance.collection(
      '${strFirebaseMode}message/India/public_chats',
    );

    users
        .add(
          {
            'sender_chat_user_id': widget.strSenderChatId.toString(),
            'sender_name': widget.strSenderName.toString(),
            'sender_gender': 'gender',
            'sender_firebase_id': FirebaseAuth.instance.currentUser!.uid,
            'message': strLastMessageEntered.toString(),
            'time_stamp': DateTime.now().millisecondsSinceEpoch,
            'room': 'public',
            'type': 'text_message',
          },
        )
        .then(
          (value) => print(
              "Message send successfully. Message id is =====> ${value.id}"),
          // func_scroll_to_bottom(),

          // func_check_scrolling(),
        )
        .catchError(
          (error) => print("Failed to add user: $error"),
        );
  }
  //
}
