// import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lazy_load_indexed_stack/lazy_load_indexed_stack.dart';

import '../../headers/utils/utils.dart';
import '../add_community/add_community.dart';
import 'widgets/title_subtitle.dart';

class AllCommunitiesScreen extends StatefulWidget {
  const AllCommunitiesScreen({super.key});

  @override
  State<AllCommunitiesScreen> createState() => _AllCommunitiesScreenState();
}

class _AllCommunitiesScreenState extends State<AllCommunitiesScreen>
    with AutomaticKeepAliveClientMixin<AllCommunitiesScreen> {
  //
  var searchText = '';
  late Stream streamQuery;
  //
  @override
  bool get wantKeepAlive => true;
  //
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.only(top: 12, left: 8),
            child: textWithRegularStyle('Explore', 14.0, Colors.black, 'left'),
          ),
          backgroundColor: Colors.white,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                onPressed: () {
                  //
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddEditCommunityScreen(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.add,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        body: LazyLoadIndexedStack(
          index: 0,
          children: [
            //
            // UI : All Communities
            allCommunitiesUI(),
          ],
        ),
      ),
    );
  }

  FirestoreListView<Map<String, dynamic>> allCommunitiesUI() {
    return FirestoreListView<Map<String, dynamic>>(
      cacheExtent: 9999,
      // pageSize: 6,
      query: FirebaseFirestore.instance
          .collection(
            "$strFirebaseMode$collection_community",
          )
          .orderBy('time_stamp', descending: true),
      itemBuilder: (context, snapshot) {
        Map<String, dynamic> communityData = snapshot.data();
        return
            //
            // UI : List of all communities
            TitleSubtitleScreen(dataForTitleAndSubtitle: communityData);
      },
    );
  }

  Container communityDisplayImageUI(data) {
    return Container(
      margin: const EdgeInsets.only(
        left: 10.0,
      ),
      height: 80,
      width: 80,
      color: Colors.transparent,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          12.0,
        ),
        child: CachedNetworkImage(
          imageUrl: data['communityImage'].toString(),
          fit: BoxFit.cover,
          memCacheHeight: 120,
          // memCacheWidth: 140,
          placeholder: (context, url) => SizedBox(
              height: 40,
              width: 40,
              child: ShimmerLoader(width: MediaQuery.of(context).size.width)),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}
