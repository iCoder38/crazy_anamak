// lazy load index
// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crazy_anamak/classes/headers/utils/utils.dart';
import 'package:crazy_anamak/classes/stories/story_details/story_details.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lazy_load_indexed_stack/lazy_load_indexed_stack.dart';

import '../stories/all_stories/widgets/description.dart';
import '../stories/all_stories/widgets/story_title.dart';

//
class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({super.key, this.getStoryFullData});

  final getStoryFullData;

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  //
  final PageStorageBucket bucket = PageStorageBucket();
  int selectedIndex = 0;

  /// Controller to handle PageView and also handles initial page
  final _pageController = PageController(initialPage: 0);

  /// Controller to handle bottom nav bar and also handles initial page
  // final controller = NotchBottomBarController(index: 0);

  int maxCount = 5;

// lazy index stack
  int lazyIndex = 0;
//
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: textWithSemiBoldStyle(
          'Stories',
          16.0,
          Colors.black,
        ),
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
      ),*/
      body: LazyLoadIndexedStack(
        index: lazyIndex,
        children: [
          //
          // story details
          StoryDetailsScreen(getAllData: widget.getStoryFullData),
          //
          // comments list
          allCommentsListUI()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        onTap: (index) {
          setState(() => lazyIndex = index);
        },
        currentIndex: lazyIndex,
        items: const [
          BottomNavigationBarItem(
            backgroundColor: Colors.pink,
            // backgroundColor: Colors.white,
            icon: Icon(
              Icons.data_array,
              color: Colors.black,
            ),
            label: 'Details',
            // activeIcon: Icon(
            //   Icons.feed,
            //   color: Colors.pink,
            // ),
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.amber,
            icon: Icon(
              Icons.comment,
              color: Colors.black,
            ),
            label: 'comments',
          ),
        ],
      ),
    );
  }

  FirestoreListView<Map<String, dynamic>> allCommentsListUI() {
    return FirestoreListView<Map<String, dynamic>>(
      cacheExtent: 9999,
      pageSize: 4,
      query: FirebaseFirestore.instance
          .collection(
            "${strFirebaseMode}story_data/story_comments/${widget.getStoryFullData['documentId'].toString()}",
          )
          // .where('story_type', isEqualTo: 'all')
          // .where('active', isEqualTo: 'yes')
          .orderBy('time_stamp', descending: true),
      itemBuilder: (context, snapshot) {
        Map<String, dynamic> communityData = snapshot.data();
        return
            //

            // UI : List of all stories
            communityData.isEmpty
                ? Center(
                    child: textWithRegularStyle(
                      'str',
                      14.0,
                      Colors.black,
                      'left',
                    ),
                  )
                : Center(
                    child: textWithRegularStyle(
                      //
                      communityData['test'],
                      14.0,
                      Colors.black,
                      'left',
                    ),
                  );
      },
    );
  }
}
