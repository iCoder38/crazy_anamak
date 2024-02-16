import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../headers/utils/utils.dart';
import '../../private_chat/private_chat_room_two.dart';

class NewPublicChatRoomScreen extends StatefulWidget {
  const NewPublicChatRoomScreen(
      {super.key,
      required this.strSenderName,
      required this.strSenderChatId,
      required this.strGetGender});

  final String strSenderName;
  final String strSenderChatId;
  final String strGetGender;

  @override
  State<NewPublicChatRoomScreen> createState() =>
      _NewPublicChatRoomScreenState();
}

class _NewPublicChatRoomScreenState extends State<NewPublicChatRoomScreen> {
  TextEditingController contTextSendMessage = TextEditingController();
  //
  @override
  Widget build(BuildContext context) {
    //
    Size size = MediaQuery.of(context).size;
    //
    return Scaffold(
      appBar: AppBar(
        title: textWithSemiBoldStyle(
          'Public',
          16.0,
          Colors.white,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.white,
          ),
        ),
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
                    '${strFirebaseMode}chats/public_chats/data',
                  )
                  .orderBy('time_stamp', descending: true),
              itemBuilder: (context, snapshot) {
                Map<String, dynamic> communityData = snapshot.data();
                //
                return (communityData['sender_id'].toString() ==
                        FirebaseAuth.instance.currentUser!.uid.toString())
                    ? senderUIKIT(communityData) //receiverUIKIT(communityData)
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
                    sendMessageViaFirebase(contTextSendMessage.text);
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
          child: GestureDetector(
            onTap: () {
              //
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PrivateChatScreenTwo(
                    strSenderName: widget.strSenderName.toString(),
                    strReceiverName: communityData['sender_name'].toString(),
                    strReceiverFirebaseId:
                        communityData['sender_firebase_id'].toString(),
                    strSenderChatId: widget.strSenderChatId.toString(),
                    strReceiverChatId:
                        communityData['sender_chat_user_id'].toString(),
                  ),
                ),
              );
            },
            child: Container(
              color: Colors.transparent,
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
                    if (communityData['sender_gender'] == '1') ...[
                      //
                      const Icon(
                        Icons.person,
                        color: Colors.blue,
                        size: 18.0,
                      ),
                    ] else if (communityData['sender_gender'] == '2') ...[
                      //
                      const Icon(
                        Icons.person,
                        color: Colors.pink,
                        size: 18.0,
                      ),
                    ] else ...[
                      //
                      const Icon(
                        Icons.abc,
                        color: Colors.black,
                        size: 18.0,
                      ),
                    ],
                    const SizedBox(
                      width: 6.0,
                    ),
                    textWithRegularStyle(
                      //
                      //
                      communityData['sender_name'],
                      12.0,
                      Colors.black,
                      'left',
                    ),
                  ],
                ),
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

  sendMessageViaFirebase(strLastMessageEntered) {
    // print(cont_txt_send_message.text);

    CollectionReference users = FirebaseFirestore.instance.collection(
      '${strFirebaseMode}chats/public_chats/data',
    );

    users
        .add(
          {
            'sender_chat_user_id': widget.strSenderChatId.toString(),
            'sender_name': widget.strSenderName.toString(),
            'sender_gender': widget.strGetGender,
            'sender_id': FirebaseAuth.instance.currentUser!.uid,
            'message': strLastMessageEntered.toString(),
            'time_stamp': DateTime.now().millisecondsSinceEpoch,
            'room': 'public',
            'type': 'text',
          },
        )
        .then(
          (value) => FirebaseFirestore.instance
              .collection(
                '${strFirebaseMode}chats/public_chats/data',
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
                print('==============================================');
                print('MESSAGE SENT SUCCESSFULLY IN PUBLIC CHAT ROOM');
                print('==============================================');
              }
            },
          ),
        )
        .catchError(
          (error) => print("Failed to add user: $error"),
        );
  }
}
