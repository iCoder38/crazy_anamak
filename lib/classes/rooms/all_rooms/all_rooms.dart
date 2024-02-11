import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crazy_anamak/classes/rooms/create_room/create_room.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../headers/utils/utils.dart';
import '../../stories/all_stories/widgets/description.dart';
import '../../stories/all_stories/widgets/story_title.dart';
import '../../stories/all_stories/widgets/total_view.dart';

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
      pageSize: 4,
      query: FirebaseFirestore.instance
          .collection(
            "$strFirebaseMode$collection_room",
          )
          // .where('story_type', isEqualTo: 'all')
          // .where('active', isEqualTo: 'yes')
          .orderBy('time_stamp', descending: true),
      itemBuilder: (context, snapshot) {
        Map<String, dynamic> communityData = snapshot.data();
        return
            //
            // UI : List of all stories
            GestureDetector(
          onTap: () {
            //

            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => StoryDetailsScreen(
            //       getAllData: communityData,
            //     ),
            //   ),
            // );
            /*Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    BottomBarScreen(getStoryFullData: communityData),
              ),
            );*/
          },
          child: Column(
            children: [
              ListTile(
                title: textWithSemiBoldStyle(
                  //
                  communityData['title'],
                  16.0,
                  Colors.black,
                ),
                subtitle: textWithRegularStyle(
                  //
                  communityData['documentId'],
                  12.0,
                  Colors.black,
                  'left',
                ),
              ),
              /*ListTile(
                title: StoryTitleScreen(
                  getStoryTitle: communityData['title'],
                ),
                subtitle: StoryDescriptionScreen(
                  //
                  getDescription: communityData['description'],
                  strForDetails: 'no',
                ),
              ),*/
              //
              //
              /*TotalViewsOnStoryScreen(
                strViewCount: communityData['total_views'],
                strLikeCount: communityData['total_likes'],
              ),*/
              //
              const Divider(
                height: 2,
              ),
            ],
          ),
        );
      },
    );
  }
}
