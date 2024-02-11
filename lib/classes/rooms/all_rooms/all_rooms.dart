import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crazy_anamak/classes/rooms/create_room/create_room.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/foundation.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
                                  if (communityData['member_count'] == '0') ...[
                                    //
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: textWithRegularStyle(
                                        //
                                        '${communityData['member_count']} participant',
                                        12.0,
                                        Colors.black,
                                        'left',
                                      ),
                                    ),
                                  ] else if (communityData['member_count'] ==
                                      '1') ...[
                                    //
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: textWithRegularStyle(
                                        //
                                        '${communityData['member_count']} participant',
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
                                        '${communityData['member_count']} participants',
                                        12.0,
                                        Colors.black,
                                        'left',
                                      ),
                                    ),
                                  ],
                                ],
                              ),
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
                                  if (communityData['member_count'] == '0') ...[
                                    //
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: textWithRegularStyle(
                                        //
                                        '${communityData['member_count']} participant',
                                        12.0,
                                        Colors.black,
                                        'left',
                                      ),
                                    ),
                                  ] else if (communityData['member_count'] ==
                                      '1') ...[
                                    //
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: textWithRegularStyle(
                                        //
                                        '${communityData['member_count']} participant',
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
                                        '${communityData['member_count']} participants',
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
                    return const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.black,
                          strokeWidth: 0.8,
                        ),
                      ),
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
                  if (communityData['member_count'] == '0') ...[
                    //
                    Align(
                      alignment: Alignment.centerLeft,
                      child: textWithRegularStyle(
                        //
                        '${communityData['member_count']} participant',
                        12.0,
                        Colors.black,
                        'left',
                      ),
                    ),
                  ] else if (communityData['member_count'] == '1') ...[
                    //
                    Align(
                      alignment: Alignment.centerLeft,
                      child: textWithRegularStyle(
                        //
                        '${communityData['member_count']} participant',
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
                        '${communityData['member_count']} participants',
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
          if (communityData['member_count'] == '0') ...[
            //
            Align(
              alignment: Alignment.centerLeft,
              child: textWithRegularStyle(
                //
                '${communityData['member_count']} participant',
                12.0,
                Colors.black,
                'left',
              ),
            ),
          ] else if (communityData['member_count'] == '1') ...[
            //
            Align(
              alignment: Alignment.centerLeft,
              child: textWithRegularStyle(
                //
                '${communityData['member_count']} participant',
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
                '${communityData['member_count']} participants',
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
}
