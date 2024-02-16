import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../headers/custom/app_bar.dart';
import '../headers/utils/utils.dart';
// import 'package:my_new_orange/header/utils/Utils.dart';
// import 'package:my_new_orange/header/utils/custom/app_bar.dart';
// import 'package:visibility_detector/visibility_detector.dart';
// import 'package:my_new_orange/header/utils/Utils.dart';

class PrivateChatScreenTwo extends StatefulWidget {
  const PrivateChatScreenTwo(
      {super.key,
      required this.strSenderName,
      required this.strReceiverName,
      required this.strReceiverFirebaseId,
      required this.strSenderChatId,
      required this.strReceiverChatId});

  // sender
  final String strSenderChatId;
  final String strSenderName;

  // receiver
  final String strReceiverName;
  final String strReceiverFirebaseId;
  final String strReceiverChatId;

  @override
  State<PrivateChatScreenTwo> createState() => _PrivateChatScreenTwoState();
}

class _PrivateChatScreenTwoState extends State<PrivateChatScreenTwo> {
  //
  bool _needsScroll = false;
  final ScrollController _scrollController = ScrollController();
  //
  TextEditingController contTextSendMessage = TextEditingController();
  //
  final int _currentItem = 0;
  var strScrollOnlyOneTime = '1';
  //
  var roomId;
  var reverseRoomId;
  var lastMessage = '';
  //
  @override
  void initState() {
    super.initState();

    // print(FirebaseAuth.instance.currentUser!.uid);
    /*if (kDebugMode) {
      print('SENDER CHAT ID =====>${widget.strSenderChatId}');
      print('SENDER NAME =====>${widget.strSenderName}');
      print('SENDER RECEIVER NAME =====>${widget.strReceiverName}');
      print('SENDER RECEIVER FID =====>${widget.strReceiverFirebaseId}');
      print('SENDER RECEIVER CHAT ID =====>${widget.strReceiverChatId}');
    }*/
    //
    roomId = '${widget.strSenderChatId}+${widget.strReceiverChatId}';
    reverseRoomId = '${widget.strReceiverChatId}+${widget.strSenderChatId}';

    if (kDebugMode) {
      print(roomId);
      print(reverseRoomId);
    }

    //
  }

  //
  /*_scrollToEnd() async {
    if (_needsScroll) {
      _needsScroll = false;
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
    }
  }*/

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarScreen(
        str_app_bar_title: widget.strReceiverName.toString(),
        str_status: '1',
      ),
      body: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 0, bottom: 60),
            width: MediaQuery.of(context).size.width,
            color: Colors.transparent,
            child: FirestoreListView<Map<String, dynamic>>(
              cacheExtent: 9999,
              // pageSize: 4,
              reverse: true,
              query: FirebaseFirestore.instance
                  .collection(
                    // "${strFirebaseMode}message/India/private_chats",
                    "${strFirebaseMode}chats/private_chats/data",
                  )
                  .orderBy('time_stamp', descending: true)
                  .where(
                'room_id',
                whereIn: [
                  roomId,
                  reverseRoomId,
                ],
              ),
              itemBuilder: (context, snapshot) {
                Map<String, dynamic> communityData = snapshot.data();
                //
                return (communityData['sender_firebase_id'].toString() ==
                        FirebaseAuth.instance.currentUser!.uid)
                    ? receiverUIKIT(communityData)
                    : senderUIKIT(communityData);
              },
            ),
          ),
          sendMessageuIKIT()
        ],
      ),
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
                    sendMessageViaFirebase(contTextSendMessage.text);
                    lastMessage = contTextSendMessage.text.toString();
                    contTextSendMessage.text = '';
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

  //
//  Column receiverUI() {
  Column receiverUI(getSnapshot, int index) {
    return Column(
      children: [
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            margin: const EdgeInsets.only(
              right: 40,
            ),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
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
              color: Colors.blue[200],
            ),
            padding: const EdgeInsets.all(
              16,
            ),
            child: textWithRegularStyle(
              getSnapshot[index]['message'].toString(),
              14.0,
              Colors.black,
              'left',
            ),
          ),
        ),
        //
        Align(
          alignment: Alignment.bottomLeft,
          child: textWithRegularStyle(
            // getSnapshot[index]['time_stamp'].toString(),
            // '123',
            funcConvertTimeStampToDateAndTime(
              getSnapshot[index]['time_stamp'],
            ),
            12.0,
            Colors.black,
            'left',
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

  //
  // Column senderUI() {
  Column senderUI(getSnapshot, int index) {
    return Column(
      children: [
        Align(
          alignment: Alignment.bottomRight,
          child: Container(
            margin: const EdgeInsets.only(
              left: 40,
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
              color: Color.fromARGB(255, 228, 232, 235),
            ),
            padding: const EdgeInsets.all(
              16,
            ),
            child: Text(
              //
              getSnapshot[index]['message'].toString(),
              //
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
          ),
        ),
        //
        Align(
          alignment: Alignment.bottomRight,
          child: textWithRegularStyle(
            // getSnapshot[index]['time_stamp'].toString(),
            // '123',
            funcConvertTimeStampToDateAndTime(
              getSnapshot[index]['time_stamp'],
            ),
            12.0,
            Colors.black,
            'right',
          ),
        ),
        //
      ],
    );
  }

  //
  Container sendMessageUI() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      color: const Color.fromARGB(
        255,
        60,
        182,
        195,
      ),
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

              sendMessageViaFirebase(contTextSendMessage.text);
              lastMessage = contTextSendMessage.text.toString();
              contTextSendMessage.text = '';

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
      '${strFirebaseMode}chats/private_chats/data',
    );

    /*
    if (kDebugMode) {
      print('SENDER CHAT ID =====>${widget.strSenderChatId}');
      print('SENDER NAME =====>${widget.strSenderName}');
      print('SENDER RECEIVER NAME =====>${widget.strReceiverName}');
      print('SENDER RECEIVER FID =====>${widget.strReceiverFirebaseId}');
      print('SENDER RECEIVER CHAT ID =====>${widget.strReceiverChatId}');
    }
    */

    users
        .add(
          {
            'sender_firebase_id': FirebaseAuth.instance.currentUser!.uid,
            'sender_chat_user_id': widget.strSenderChatId,
            'sender_name': widget.strSenderName,
            'receiver_name': widget.strReceiverName,
            'receiver_firebase_id': widget.strReceiverFirebaseId,
            'receiver_chat_user_id': widget.strReceiverChatId,
            'message': strLastMessageEntered.toString(),
            'time_stamp': DateTime.now().millisecondsSinceEpoch,
            'room': 'private',
            'type': 'text_message',

            // save room id
            'room_id': roomId.toString(),
            'users': [
              roomId,
              reverseRoomId,
            ]
          },
        )
        .then(
          (value) =>
              //
              funcCheckUsersIsAlreadyChatWithEachOther(),
          //
        )
        .catchError(
          (error) => print("Failed to add user: $error"),
        );
  }

  //
  funcCheckUsersIsAlreadyChatWithEachOther() {
    if (kDebugMode) {
      print('bottle');
    }
    FirebaseFirestore.instance
        .collection("${strFirebaseMode}dialog")
        // .doc("India")
        // .collection("details")
        .where(
          "users",
          arrayContainsAny: [roomId, reverseRoomId],
        )
        .get()
        .then(
          (value) {
            if (kDebugMode) {
              print(value.docs.length);
            }

            if (value.docs.isEmpty) {
              if (kDebugMode) {
                print('======> NO, DIALOG NOT CREATED <======');
              }

              //
              funcCreateDialog();
              //
            } else {
              if (kDebugMode) {
                print('===> YES, THEY ALREADY CHATTED <===');
              }
              for (var element in value.docs) {
                if (kDebugMode) {
                  print(element.id);
                }
                //
                funcEditDialogWithTimeStamp(element.id);
                return;
              }
              //
              //
              //
            }
          },
        );
  }

  //
  funcCreateDialog() {
    CollectionReference users = FirebaseFirestore.instance.collection(
      // '${strFirebaseMode}dialog/India/details',
      '${strFirebaseMode}dialog',
    );
    /*
    if (kDebugMode) {
      print('SENDER CHAT ID =====>${widget.strSenderChatId}');
      print('SENDER NAME =====>${widget.strSenderName}');
      print('SENDER RECEIVER NAME =====>${widget.strReceiverName}');
      print('SENDER RECEIVER FID =====>${widget.strReceiverFirebaseId}');
      print('SENDER RECEIVER CHAT ID =====>${widget.strReceiverChatId}');
    }
    */
    users
        .add(
          {
            // sender
            'sender_firebase_id': FirebaseAuth.instance.currentUser!.uid,
            'sender_name': widget.strSenderName,
            'sender_chat_user_id': widget.strSenderChatId,
            //time stamp
            'time_stamp': DateTime.now().millisecondsSinceEpoch,
            //receiver
            'receiver_name': widget.strReceiverName,
            'receiver_firebase_id': widget.strReceiverFirebaseId,
            'receiver_chat_user_id': widget.strReceiverChatId,
            'message': lastMessage,
            'users': [
              roomId,
              reverseRoomId,
            ],
            'match': [
              widget.strSenderChatId,
              widget.strReceiverChatId,
            ]
          },
        )
        .then(
          (value) => print("==> DIALOG CREATED SUCCESSFULLY ==> ${value.id}"),
        )
        .catchError(
          (error) => print("Failed to add user: $error"),
        );
  }

  // UPDATE DIALOG AFTER SEND MESSAGE
  funcEditDialogWithTimeStamp(
    elementWithId,
  ) {
    FirebaseFirestore.instance
        .collection('${strFirebaseMode}dialog')
        //.doc('India')
        // .collection('details')
        .doc(elementWithId.toString())
        .set(
      {
        'time_stamp': DateTime.now().millisecondsSinceEpoch,
        'message': lastMessage,
      },
      SetOptions(merge: true),
    ).then(
      (value) {
        if (kDebugMode) {
          print('===========================');
          print('Dialog updated successfully');
          print('===========================');
        }
        //
        // setState(() {
        // strSetLoader = '1';
        // });
        //
      },
    );
  }
}
