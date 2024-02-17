import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../headers/utils/utils.dart';

class DialogScreen extends StatefulWidget {
  const DialogScreen({super.key, required this.chatIdForDialog});

  final String chatIdForDialog;

  @override
  State<DialogScreen> createState() => _DialogScreenState();
}

class _DialogScreenState extends State<DialogScreen> {
  //
  @override
  void initState() {
    if (kDebugMode) {
      print('========= MY CHAT ID ===========');
      print(widget.chatIdForDialog.toString());
      print('================================');
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
      body: FirestoreListView<Map<String, dynamic>>(
        cacheExtent: 9999,
        // pageSize: 4,
        reverse: false,
        query: FirebaseFirestore.instance
            .collection('${strFirebaseMode}dialog')
            .orderBy('time_stamp', descending: true)
            .where('match', arrayContainsAny: [
          //
          widget.chatIdForDialog.toString(),
        ]),
        itemBuilder: (context, snapshot) {
          Map<String, dynamic> communityData = snapshot.data();
          //
          return Column(
            children: [
              if (communityData['sender_firebase_id'].toString() ==
                  FirebaseAuth.instance.currentUser!.uid) ...[
                //
                ListTile(
                  title: textWithSemiBoldStyle(
                    //
                    communityData['receiver_name'].toString(),
                    18.0,
                    Colors.black,
                  ),
                  subtitle: textWithRegularStyle(
                    'str',
                    12.0,
                    Colors.black,
                    'left',
                  ),
                  trailing: textWithRegularStyle(
                    funcConvertTimeStampToDateAndTimeForChat(
                      int.parse(
                        communityData['time_stamp'].toString(),
                      ),
                    ),
                    12.0,
                    Colors.black,
                    'left',
                  ),
                ),
              ] else ...[
                ListTile(
                  title: textWithSemiBoldStyle(
                    //
                    communityData['sender_name'].toString(),
                    18.0,
                    Colors.black,
                  ),
                  subtitle: textWithRegularStyle(
                    'str',
                    12.0,
                    Colors.black,
                    'left',
                  ),
                  trailing: textWithRegularStyle(
                    funcConvertTimeStampToDateAndTimeForChat(
                      int.parse(
                        communityData['time_stamp'].toString(),
                      ),
                    ),
                    12.0,
                    Colors.black,
                    'left',
                  ),
                ),
              ],
            ],
          );
        },
      ),
      /**/
    );
  }
}
