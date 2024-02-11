// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crazy_anamak/classes/rooms/create_room/create_room.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/foundation.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shimmer/shimmer.dart';
// import 'package:flutter/widgets.dart';

import '../../headers/utils/utils.dart';
/*import '../../stories/all_stories/widgets/description.dart';
import '../../stories/all_stories/widgets/story_title.dart';
import '../../stories/all_stories/widgets/total_view.dart';*/

class AllRoomsScreen extends StatefulWidget {
  const AllRoomsScreen({super.key});

  @override
  State<AllRoomsScreen> createState() => _AllRoomsScreenState();
}

class _AllRoomsScreenState extends State<AllRoomsScreen> {
  //
  var strPasswordIs = '';
  final TextEditingController textFieldController = TextEditingController();
  //
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: textWithSemiBoldStyle('Rooms', 16.0, Colors.black),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              //
              // allStoriesList();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CreateRoomScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.add,
            ),
          ),
        ],
      ),
      body: allStories(),
      //
    );
  }

  FirestoreListView<Map<String, dynamic>> allStories() {
    return FirestoreListView<Map<String, dynamic>>(
      cacheExtent: 9999,
      pageSize: 6,
      query: FirebaseFirestore.instance
          .collection(
            "$strFirebaseMode$collection_room",
          )
          // .where('story_type', isEqualTo: 'all')
          .where('active', isEqualTo: 'yes')
          .orderBy('time_stamp', descending: true),
      itemBuilder: (context, snapshot) {
        Map<String, dynamic> communityData = snapshot.data();
        return
            //
            // UI : List of all stories
            Column(
          children: [
            if (communityData['room_password'] == '') ...[
              //
              roomWithoutLockUI(communityData)
              //
            ] else ...[
              FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection(
                        "$strFirebaseMode$collection_room_premission",
                      )
                      .where('room_document_id',
                          isEqualTo: communityData['documentId'])
                      .where('id',
                          isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                      //
                      .get(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      if (kDebugMode) {
                        print('=====> YES, DATA');
                        print(snapshot.data!.docs.length);
                      }
                      return (snapshot.data!.docs.isEmpty)
                          ? ListTile(
                              title: textWithSemiBoldStyle(
                                //
                                communityData['title'],
                                16.0,
                                Colors.black,
                              ),
                              trailing: const Icon(
                                Icons.lock,
                                size: 16.0,
                                color: Colors.redAccent,
                              ),
                              subtitle: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  if (communityData['total_members'] ==
                                      '0') ...[
                                    //
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: textWithRegularStyle(
                                        //
                                        '${communityData['total_members']} participant',
                                        12.0,
                                        Colors.black,
                                        'left',
                                      ),
                                    ),
                                  ] else if (communityData['total_members'] ==
                                      '1') ...[
                                    //
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: textWithRegularStyle(
                                        //
                                        '${communityData['total_members']} participant',
                                        12.0,
                                        Colors.black,
                                        'left',
                                      ),
                                    ),
                                  ] else ...[
                                    //
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: textWithRegularStyle(
                                        //
                                        '${communityData['total_members']} participants',
                                        12.0,
                                        Colors.black,
                                        'left',
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                              onTap: () {
                                //
                                displayTextInputDialog(
                                  context,
                                  communityData['title'].toString(),
                                  communityData['documentId'].toString(),
                                );
                              },
                            )
                          : ListTile(
                              title: textWithSemiBoldStyle(
                                //
                                communityData['title'],
                                16.0,
                                Colors.black,
                              ),
                              trailing: const Icon(
                                Icons.lock_open,
                                size: 16.0,
                                color: Colors.green,
                              ),
                              subtitle: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  if (communityData['total_members'] ==
                                      '0') ...[
                                    //
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: textWithRegularStyle(
                                        //
                                        '${communityData['total_members']} participant',
                                        12.0,
                                        Colors.black,
                                        'left',
                                      ),
                                    ),
                                  ] else if (communityData['total_members'] ==
                                      '1') ...[
                                    //
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: textWithRegularStyle(
                                        //
                                        '${communityData['total_members']} participant',
                                        12.0,
                                        Colors.black,
                                        'left',
                                      ),
                                    ),
                                  ] else ...[
                                    //
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: textWithRegularStyle(
                                        //
                                        '${communityData['total_members']} participants',
                                        12.0,
                                        Colors.black,
                                        'left',
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            );
                    } else if (snapshot.hasError) {
                      if (kDebugMode) {
                        print(snapshot.error);
                      }
                    }
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey,
                        highlightColor: Colors.transparent,
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                height: 20,
                                width: 120.0,
                                color: Colors.amber,
                              ),
                            )
                          ],
                        ),
                      ),
                      /*Center(
                        child: CircularProgressIndicator(
                          color: Colors.black,
                          strokeWidth: 0.8,
                        ),
                      ),*/
                    );
                  }),
            ],
            /*ListTile(
              trailing: (communityData['room_password'] == '')
                  ? const Icon(
                      Icons.chevron_right,
                      size: 22.0,
                      color: Colors.grey,
                    )
                  : const Icon(
                      Icons.lock_open,
                      size: 18.0,
                      color: Colors.green,
                    ),

              // title: Text(communityData.toString()),
              title: (communityData['room_password'] == '')
                  ? textWithSemiBoldStyle(
                      //
                      communityData['title'],
                      16.0,
                      Colors.black,
                    )
                  : FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection(
                            "$strFirebaseMode$collection_room_premission",
                          )
                          .where('id',
                              isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                          //
                          .get(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          if (kDebugMode) {
                            print('=====> YES, DATA');
                            print(snapshot.data!.docs.length);
                          }
                          return Text('data');
                        } else if (snapshot.hasError) {
                          if (kDebugMode) {
                            print(snapshot.error);
                          }
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }),
              /*textWithSemiBoldStyle(
                //
                communityData['title'],
                16.0,
                Colors.black,
              ),*/
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (communityData['total_members'] == '0') ...[
                    //
                    Align(
                      alignment: Alignment.centerLeft,
                      child: textWithRegularStyle(
                        //
                        '${communityData['total_members']} participant',
                        12.0,
                        Colors.black,
                        'left',
                      ),
                    ),
                  ] else if (communityData['total_members'] == '1') ...[
                    //
                    Align(
                      alignment: Alignment.centerLeft,
                      child: textWithRegularStyle(
                        //
                        '${communityData['total_members']} participant',
                        12.0,
                        Colors.black,
                        'left',
                      ),
                    ),
                  ] else ...[
                    //
                    Align(
                      alignment: Alignment.centerLeft,
                      child: textWithRegularStyle(
                        //
                        '${communityData['total_members']} participants',
                        12.0,
                        Colors.black,
                        'left',
                      ),
                    ),
                  ],
                ],
              ),
            ),*/

            //
            const Divider(
              height: 2,
            ),
          ],
        );
      },
    );
  }

  ListTile roomWithoutLockUI(Map<String, dynamic> communityData) {
    return ListTile(
      title: textWithSemiBoldStyle(
        //
        communityData['title'],
        16.0,
        Colors.black,
      ),
      trailing: const Icon(
        Icons.chevron_right,
        size: 22.0,
        color: Colors.grey,
      ),
      subtitle: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (communityData['total_members'] == '0') ...[
            //
            Align(
              alignment: Alignment.centerLeft,
              child: textWithRegularStyle(
                //
                '${communityData['total_members']} participant',
                12.0,
                Colors.black,
                'left',
              ),
            ),
          ] else if (communityData['total_members'] == '1') ...[
            //
            Align(
              alignment: Alignment.centerLeft,
              child: textWithRegularStyle(
                //
                '${communityData['total_members']} participant',
                12.0,
                Colors.black,
                'left',
              ),
            ),
          ] else ...[
            //
            Align(
              alignment: Alignment.centerLeft,
              child: textWithRegularStyle(
                //
                '${communityData['total_members']} participants',
                12.0,
                Colors.black,
                'left',
              ),
            ),
          ],
        ],
      ),
    );
  }

  Future<void> displayTextInputDialog(
    BuildContext context,
    strGroupName,
    getRoomDocumentId,
  ) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Column(
              children: [
                textWithSemiBoldStyle(
                    'Please enter password \n', 18.0, Colors.black),
                textWithRegularStyle(
                  //
                  strGroupName,
                  14.0,
                  Colors.black,
                  'left',
                ),
              ],
            ),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  // valueText = value;
                  print(value);
                });
              },
              controller: textFieldController,
              decoration: const InputDecoration(hintText: "password..."),
            ),
            actions: <Widget>[
              MaterialButton(
                color: Colors.green,
                textColor: Colors.white,
                child: textWithRegularStyle(
                  'submit',
                  14.0,
                  Colors.white,
                  'left',
                ),
                onPressed: () {
                  // setState(() {
                  strPasswordIs = textFieldController.text;
                  Navigator.pop(context);

                  // });
                  checkPasswordIsCorrectOrNot(getRoomDocumentId);
                },
              ),
            ],
          );
        });
  }

  //
  checkPasswordIsCorrectOrNot(docId) {
    //
    FirebaseFirestore.instance
        .collection("$strFirebaseMode$collection_room")
        //
        .where('documentId', isEqualTo: docId)
        .where('room_password', isEqualTo: strPasswordIs.toString())
        //
        .get()
        .then((value) {
      if (kDebugMode) {
        print(value.docs);
      }

      if (value.docs.isEmpty) {
        if (kDebugMode) {
          print('================================');
          print('====== PASSWORD NOT MATCHED =====');
          print('================================');
        }
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red[200],
          content: textWithRegularStyle(
            'Password is not correct. Please check and try again.',
            14.0,
            Colors.black,
            'left',
          ),
        ));
      } else {
        for (var element in value.docs) {
          if (kDebugMode) {
            print('================================');
            print('======= PASSWORD MATCHED =======');
            print('================================');
            print(element.id);
          }
          //
          textFieldController.text = '';

          //
          //
          // create data
          CollectionReference users = FirebaseFirestore.instance.collection(
            '$strFirebaseMode$collection_room_premission',
          );
          users
              .add(
                {
                  'room_document_id': docId.toString(),
                  'id': FirebaseAuth.instance.currentUser!.uid,
                  'time_stamp': DateTime.now().millisecondsSinceEpoch,
                },
              )
              .then((value) =>
                  //
                  //     print(
                  //   'USER SUCCESSFULLY ENTERED PASSWORD... NOW ADD PARTICIPANT',
                  // ),
                  addOneParticipantCountInRoom(docId.toString(),
                      element.data()['total_members'].toString()))
              .catchError(
                (error) => print("Failed to add user: $error"),
              );

          //
        }
      }
    });
  }

  //
  // GET PARTICIPANTS
  addOneParticipantCountInRoom(
    roomDocId,
    participantCount,
  ) {
    //
    var sumOne = 0;
    sumOne = int.parse(participantCount.toString()) + 1;
    print(sumOne);
    FirebaseFirestore.instance
        .collection(
          '$strFirebaseMode$collection_room',
        )
        .doc(roomDocId)
        .set(
      {
        'total_members': sumOne.toString(),
      },
      SetOptions(merge: true),
    ).then(
      (value1) {
        // success
        print('DONE : SUCCESS');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green[200],
          content: textWithRegularStyle(
            '!!! Successfully Joined !!!',
            14.0,
            Colors.black,
            'left',
          ),
        ));
      },
    );
  }
}
