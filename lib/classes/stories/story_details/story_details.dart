// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../firebase_methods/story/story_details.dart';
import '../../headers/utils/utils.dart';
import '../all_stories/widgets/description.dart';
import '../all_stories/widgets/story_title.dart';

class StoryDetailsScreen extends StatefulWidget {
  const StoryDetailsScreen({super.key, this.getAllData});

  final getAllData;

  @override
  State<StoryDetailsScreen> createState() => _StoryDetailsScreenState();
}

class _StoryDetailsScreenState extends State<StoryDetailsScreen> {
  //
  var strSaveStoryDocumentId = '';
  //
  @override
  void initState() {
    if (kDebugMode) {
      print('==================');
      print(widget.getAllData);
      print('==================');
    }
    //
    strSaveStoryDocumentId = widget.getAllData['documentId'].toString();
    //
    // FIREBASE
    checkUserAllActivity(strSaveStoryDocumentId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: textWithSemiBoldStyle('Stories', 16.0, Colors.black,),
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
        actions: [IconButton(onPressed: (){
          //
        }, icon: const Icon(Icons.favorite,color: Colors.pinkAccent,)
        ,)
        ,]
        ,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            ListTile(
              title: StoryTitleScreen(
                getStoryTitle: widget.getAllData['title'],
              ),
              subtitle: StoryDescriptionScreen(
                //
                getDescription: widget.getAllData['description'],
                strForDetails: 'yes',
              ),
            )
          ],
        ),
      ),
    );
  }
  //
  
}
