// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../firebase_methods/story/story_details.dart';
import '../../firebase_methods/story/story_like.dart';
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
  var strLikeDocumentIdForDelete = '0';
  var strLikeStatus = '0';
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
    // like
    checkUserAllActivityForLikes2(strSaveStoryDocumentId);
    // add one view
    checkUserAllActivity(strSaveStoryDocumentId);

    //
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        actions: [
          Column(
            children: [
              if (strLikeStatus == '0') ...[
                //
                IconButton(
                    onPressed: () {
                      //
                    },
                    icon: const SizedBox(
                      height: 0,
                    )),
              ] else if (strLikeStatus == '1') ...[
                //
                IconButton(
                  onPressed: () {
                    //
                    setState(() {
                      strLikeStatus = '2';
                    });
                    //
                    getDetailsOfThatStory(strSaveStoryDocumentId, 'add');
                  },
                  icon: const Icon(
                    Icons.favorite_border,
                    color: Colors.pinkAccent,
                  ),
                ),
              ] else ...[
                IconButton(
                  onPressed: () {
                    //
                    setState(() {
                      strLikeStatus = '1';
                    });
                    //
                    getDetailsOfThatStory(strSaveStoryDocumentId, 'minus');
                  },
                  icon: const Icon(
                    Icons.favorite,
                    color: Colors.pinkAccent,
                  ),
                ),
              ],
            ],
          ),
        ],
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

// get story details
  checkUserAllActivityForLikes2(storyDocumentId) async {
    //
    if (kDebugMode) {
      print('========= ID ========');
      print(storyDocumentId);
      print('=====================');
    }
    //
    await FirebaseFirestore.instance
        .collection(
          // '${strFirebaseMode}story_data/story_like/$storyDocumentId/${FirebaseAuth.instance.currentUser!.uid}/data',
          '${strFirebaseMode}story_data/story_like/$storyDocumentId',
        )
        .get()
        .then((value) {
      // if (kDebugMode) {
      //   print(value.docs);
      // }

      if (value.docs.isEmpty) {
        if (kDebugMode) {
          print('==============================================');
          print('===== NO, YOU DID NOT LIKE THIS STORY ====');
          print('==============================================');
        }
        //
        setState(() {
          strLikeStatus = '1';
        });
        //
        //
      } else {
        for (var element in value.docs) {
          if (kDebugMode) {
            print('======> YES,  USER FOUND');
            print(element.id);
            print(element.id.runtimeType);
            print('==============================================');
            print('====== YES, YOU ALREADY LIKE THIS STORY ======');
            print('==============================================');
          }
          //
          strLikeDocumentIdForDelete = element.id.toString();
          //
          setState(() {
            strLikeStatus = '2';
          });
        }
      }
    });
  }

  //
  //
  getDetailsOfThatStory(storyDocumentId, addStatus) {
    //
    FirebaseFirestore.instance
        .collection(
          '${strFirebaseMode}stories',
        )
        .where('documentId', isEqualTo: storyDocumentId)
        .get()
        .then((value) {
      if (kDebugMode) {
        print(value.docs);
      }

      if (value.docs.isEmpty) {
        if (kDebugMode) {
          print('==============================================');
          print('===== NO STORY FOUND ====');
          print('==============================================');
        }
        //
        //
      } else {
        for (var element in value.docs) {
          //
          if (addStatus == 'add') {
            var strTotalLikeIs = 0;
            strTotalLikeIs =
                int.parse(element.data()['total_likes'].toString()) + 1;
            // print('TOTAL LIKES =====> $strTotalLikeIs');
            //////////////////////////////////
            /////////////////////////////////////
            // UPDATE +1 LIKE
            /////////////////////////////////////
            /////////////////////////////////////

            CollectionReference users = FirebaseFirestore.instance.collection(
              // '${strFirebaseMode}story_data/story_view/$storyDocumentId/${FirebaseAuth.instance.currentUser!.uid}/data',
              '${strFirebaseMode}story_data/story_like/$storyDocumentId',
            );
            users
                .add(
                  {
                    'story_id': storyDocumentId.toString(),
                    'viewer_id':
                        FirebaseAuth.instance.currentUser!.uid.toString(),
                    'time_Stamp': DateTime.now().millisecondsSinceEpoch,
                  },
                )
                .then(
                  (likeValue) =>
                      //
                      //
                      FirebaseFirestore.instance
                          .collection(
                            '${strFirebaseMode}story_data/story_like/$storyDocumentId',
                          )
                          .doc(likeValue.id)
                          .set(
                    {
                      'document_id': likeValue.id.toString(),
                    },
                    SetOptions(merge: true),
                  ).then(
                    (value1) {
                      //
                      // setState(() {
                      //   strLikeStatus = '2';
                      // });
                      // print(likeValue.id);
                      strLikeDocumentIdForDelete = likeValue.id;
                      updateOneLike(storyDocumentId, strTotalLikeIs, 'ADD');
                    },
                  ),

                  //
                )
                .catchError(
                  (error) => print("Failed to add user: $error"),
                );
          } else if (addStatus == 'minus') {
            var strTotalLikeIs = 0;
            strTotalLikeIs =
                int.parse(element.data()['total_likes'].toString()) - 1;
            // print('TOTAL LIKES =====> $strTotalLikeIs');
            // print(storyDocumentId);
            // print(strLikeDocumentIdForDelete);
            //
            // UPDATE -1 LIKE
            FirebaseFirestore.instance
                .collection(
                  '${strFirebaseMode}story_data/story_like/$storyDocumentId',
                )
                .doc(strLikeDocumentIdForDelete)
                .delete()
                .then((value) => {
                      //
                      // print('deleted'),
                      updateOneLike(storyDocumentId, strTotalLikeIs, 'MINUS'),
                    });
          }
        }
      }
    });
  }

  //
  //
  updateOneLike(documentId, totalLikes, status) {
    //

    FirebaseFirestore.instance
        .collection("${strFirebaseMode}stories")
        .doc(documentId)
        .set(
      {
        'total_likes': totalLikes.toString(),
      },
      SetOptions(merge: true),
    ).then(
      (value1) {
        // success
        if (kDebugMode) {
          print('==============================================');
          print('========== SUCCESSFULLY $status ===============');
          print('==============================================');
        }
        //
        // CHECK LIKE STATUS
        // checkUserAllActivityForLikes(storyDocumentId);
      },
    );
  }
}
