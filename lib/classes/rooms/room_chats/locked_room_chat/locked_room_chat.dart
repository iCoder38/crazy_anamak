// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crazy_anamak/classes/rooms/room_chats/locked_room_chat/locked_room_settings/locked_room_settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../headers/utils/utils.dart';

class LockedRoomChatScreen extends StatefulWidget {
  const LockedRoomChatScreen({super.key, this.getAllDataForLockedRoom});

  final getAllDataForLockedRoom;

  @override
  State<LockedRoomChatScreen> createState() => _LockedRoomChatScreenState();
}

class _LockedRoomChatScreenState extends State<LockedRoomChatScreen> {
  //
  TextEditingController contTextSendMessage = TextEditingController();
  //
  var strMessage = '';
  bool _needsScroll = false;
  final ScrollController controller = ScrollController();
  //
  @override
  void initState() {
    //
    // dummyChat(); // scrollToEnd();
    super.initState();
  }

  sendAndSaveMessageInDB() {
    strMessage = contTextSendMessage.text;
    contTextSendMessage.text = '';
    CollectionReference users = FirebaseFirestore.instance.collection(
      '${strFirebaseMode}room_chats/locked_room_chat/${widget.getAllDataForLockedRoom['documentId'].toString()}',
    );

    users
        .add(
          {
            'sender_id': FirebaseAuth.instance.currentUser!.uid,
            'message': strMessage.toString(),
            'time_stamp': DateTime.now().millisecondsSinceEpoch,
            //
            'room_document_id':
                widget.getAllDataForLockedRoom['documentId'].toString(),
            //
            // chat type
            'type': 'text'
          },
        )
        .then((value) =>
            //

            FirebaseFirestore.instance
                .collection(
                  '${strFirebaseMode}room_chats/locked_room_chat/${widget.getAllDataForLockedRoom['documentId'].toString()}',
                )
                .doc(value.id)
                .set(
              {
                'documentId': value.id,
              },
              SetOptions(merge: true),
            ).then(
              (value1) {
                // success
                if (kDebugMode) {
                  print('LOCKED ROOM CHAT DONE ');
                }
              },
            ))
        .catchError(
          (error) => print("Failed to add user: $error"),
        );
  }

  //
  scrollToEnd() async {
    if (_needsScroll) {
      _needsScroll = false;
      controller.animateTo(controller.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
    }
  }

//
  @override
  Widget build(BuildContext context) {
    //
    Size size = MediaQuery.of(context).size;
    //

    return Scaffold(
      appBar: AppBar(
        title: textWithSemiBoldStyle(
          //
          widget.getAllDataForLockedRoom['title'].toString(),
          16.0,
          Colors.white,
        ),
        leading: IconButton(
          onPressed: () {
            FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.white,
          ),
        ),
        actions: [
          //
          if (widget.getAllDataForLockedRoom['roomAdminId'].toString() ==
              FirebaseAuth.instance.currentUser!.uid) ...[
            //
            IconButton(
              onPressed: () {
                //
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LockedRoomSettingsScreen(
                      getLockedRoomSettings: widget.getAllDataForLockedRoom,
                    ),
                  ),
                );
              },
              icon: const Icon(
                Icons.settings,
                color: Colors.white,
              ),
            ),
          ]
        ],
        backgroundColor: const Color.fromRGBO(31, 43, 66, 1),
      ),
      body: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 0, bottom: 60),
            width: size.width,
            color: Colors.transparent,
            child: FirestoreListView<Map<String, dynamic>>(
              cacheExtent: 9999,
              // pageSize: 4,
              reverse: true,
              query: FirebaseFirestore.instance
                  .collection(
                    '${strFirebaseMode}room_chats/locked_room_chat/${widget.getAllDataForLockedRoom['documentId'].toString()}',
                  )
                  .orderBy('time_stamp', descending: true),
              itemBuilder: (context, snapshot) {
                Map<String, dynamic> communityData = snapshot.data();
                //
                return (communityData['sender_id'].toString() ==
                        FirebaseAuth.instance.currentUser!.uid)
                    ? receiverUIKIT(communityData)
                    : senderUIKIT(communityData);
              },
            ),
          ),
          sendMessageuIKIT()
        ],
      ),
      /**/
    );
  }

  Align sendMessageuIKIT() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        color: Colors.transparent,
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  controller: contTextSendMessage,
                  minLines: 1,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    // labelText: '',
                    hintText: 'write something',
                  ),
                ),
              ),
            ),
            //
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 40,
                width: 40,
                child: IconButton(
                  onPressed: () {
                    //
                    sendAndSaveMessageInDB();
                  },
                  icon: const Icon(
                    Icons.send,
                  ),
                ),
              ),
            ),

            //
          ],
        ),
      ),
    );
  }

  Column receiverUIKIT(Map<String, dynamic> communityData) {
    return Column(
      children: [
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            margin: const EdgeInsets.only(
              right: 40,
              left: 0.0,
              top: 12.0,
            ),
            // color: const Color.fromARGB(
            //     255, 228, 232, 235),
            // child: Padding(
            //   padding: const EdgeInsets.all(6.0),
            //   child: Row(
            //     children: [
            // const Icon(
            //   Icons.person,
            //   color: Colors.pink,
            //   size: 18.0,
            //       // ),
            //       const SizedBox(
            //         width: 6.0,
            //       ),
            //       textWithRegularStyle(
            //         'dishu',
            //         12.0,
            //         Colors.black,
            //         'left',
            //       ),
            //     ],
            //   ),
            // ),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Container(
            margin: const EdgeInsets.only(
              right: 10,
              left: 40.0,
            ),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(
                  16,
                ),
                bottomLeft: Radius.circular(
                  16,
                ),
                topRight: Radius.circular(
                  16,
                ),
              ),
              color: Color.fromRGBO(31, 43, 66, 1),
            ),
            padding: const EdgeInsets.all(
              16,
            ),
            child: textWithRegularStyle(
              //
              communityData['message'],
              14.0,
              Colors.white,
              'left',
            ),
          ),
        ),
        //
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            margin: const EdgeInsets.only(
              right: 10,
              left: 40.0,
              top: 0.0,
            ),
            // color: const Color.fromARGB(
            //     255, 228, 232, 235),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Icon(
                    Icons.schedule,
                    color: Colors.grey,
                    size: 0,
                  ),
                  const SizedBox(
                    width: 4.0,
                  ),
                  textWithRegularStyle(
                    convertTimeAndStampForChat(
                      int.parse(communityData['time_stamp'].toString()),
                    ),
                    10.0,
                    Colors.grey,
                    'left',
                  ),
                ],
              ),
            ),
          ),
        ),
        //
      ],
    );
  }

  Column senderUIKIT(Map<String, dynamic> communityData) {
    return Column(
      children: [
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            margin: const EdgeInsets.only(
              right: 40,
              left: 0.0,
              top: 12.0,
            ),
            // color: const Color.fromARGB(
            //     255, 228, 232, 235),
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Row(
                children: [
                  const Icon(
                    Icons.person,
                    color: Colors.pink,
                    size: 18.0,
                  ),
                  const SizedBox(
                    width: 6.0,
                  ),
                  textWithRegularStyle(
                    'dishu',
                    12.0,
                    Colors.black,
                    'left',
                  ),
                ],
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            margin: const EdgeInsets.only(
              right: 40,
              left: 10.0,
            ),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(
                  16,
                ),
                bottomRight: Radius.circular(
                  16,
                ),
                topRight: Radius.circular(
                  16,
                ),
              ),
              color: Color.fromARGB(255, 228, 232, 235),
            ),
            padding: const EdgeInsets.all(
              16,
            ),
            child: textWithRegularStyle(
              //
              communityData['message'],
              14.0,
              Colors.black,
              'left',
            ),
          ),
        ),
        //
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            margin: const EdgeInsets.only(
              right: 40,
              left: 10.0,
              top: 0.0,
            ),
            // color: const Color.fromARGB(
            //     255, 228, 232, 235),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                children: [
                  const Icon(
                    Icons.schedule,
                    color: Colors.grey,
                    size: 14.0,
                  ),
                  const SizedBox(
                    width: 4.0,
                  ),
                  textWithRegularStyle(
                    convertTimeAndStampForChat(
                      int.parse(communityData['time_stamp'].toString()),
                    ),
                    10.0,
                    Colors.grey,
                    'left',
                  ),
                ],
              ),
            ),
          ),
        ),
        //
      ],
    );
  }
}
