import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crazy_anamak/classes/comment_bottom_bar/comment_bottom_bar.dart';
import 'package:crazy_anamak/classes/stories/add_Story/add_story.dart';
import 'package:crazy_anamak/classes/stories/all_stories/widgets/description.dart';
import 'package:crazy_anamak/classes/stories/all_stories/widgets/story_title.dart';
import 'package:crazy_anamak/classes/stories/all_stories/widgets/total_view.dart';
import 'package:crazy_anamak/classes/stories/story_details/story_details.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../headers/utils/utils.dart';

class AllStoriesScreen extends StatefulWidget {
  const AllStoriesScreen({super.key});

  @override
  State<AllStoriesScreen> createState() => _AllStoriesScreenState();
}

class _AllStoriesScreenState extends State<AllStoriesScreen> {
  //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: textWithSemiBoldStyle('Stories', 16.0, Colors.black),
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
                  builder: (context) => const AddStoryScreen(),
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
            "$strFirebaseMode$collection_all_stories",
          )
          .where('story_type', isEqualTo: 'all')
          .where('active', isEqualTo: 'yes')
          .orderBy('time_stamp', descending: true),
      itemBuilder: (context, snapshot) {
        Map<String, dynamic> communityData = snapshot.data();
        return
            //
            // UI : List of all stories
            GestureDetector(
          onTap: () {
            //

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StoryDetailsScreen(
                  getAllData: communityData,
                ),
              ),
            );
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
                title: StoryTitleScreen(
                  getStoryTitle: communityData['title'],
                ),
                subtitle: StoryDescriptionScreen(
                  //
                  getDescription: communityData['description'],
                  strForDetails: 'no',
                ),
              ),
              //
              //
              TotalViewsOnStoryScreen(
                strViewCount: communityData['total_views'],
                strLikeCount: communityData['total_likes'],
              ),
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
