// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../headers/utils/utils.dart';

checkUserAllActivityForLikes(storyDocumentId) async {
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
    if (kDebugMode) {
      print(value.docs);
    }

    if (value.docs.isEmpty) {
      if (kDebugMode) {
        print('===== NO, YOU DID NOT LIKE THIS STORY ====');
      }
      //
      // addStoryDataAndOneLike(storyDocumentId);
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
      }
    }
  });
}

//
addStoryDataAndOneLike(storyDocumentId) {
  //
  CollectionReference users = FirebaseFirestore.instance.collection(
    // '${strFirebaseMode}story_data/story_like/$storyDocumentId/${FirebaseAuth.instance.currentUser!.uid}/data',
    '${strFirebaseMode}story_data/story_like/$storyDocumentId',
  );
  users
      .add(
        {
          'story_id': storyDocumentId.toString(),
          'viewer_id': FirebaseAuth.instance.currentUser!.uid.toString(),
          'time_Stamp': DateTime.now().millisecondsSinceEpoch,
        },
      )
      .then(
        (value) =>
            //
            storyDetailsToLikeEdit(storyDocumentId),
        //
      )
      .catchError(
        (error) => print("Failed to add user: $error"),
      );
}

// get story details
storyDetailsToLikeEdit(storyDocumentId) {
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
        print('===== NO STORY FOUND ====');
      }
      //
    } else {
      for (var element in value.docs) {
        /*if (kDebugMode) {
            print('======> YES STORY FOUND ======');
            print(element.id);
            print(element.data());
          }*/
        //
        var strTotalLikeIs = 0;
        strTotalLikeIs =
            int.parse(element.data()['total_likes'].toString()) + 1;
        print('total likes ===> +$strTotalLikeIs');
        //
        FirebaseFirestore.instance
            .collection("${strFirebaseMode}stories")
            .doc(storyDocumentId)
            .set(
          {
            'total_likes': strTotalLikeIs.toString(),
          },
          SetOptions(merge: true),
        ).then(
          (value1) {
            // success
            if (kDebugMode) {
              print('==============================================');
              print('====== SUCCESSFULLY LIKED ===========');
              print('==============================================');
            }
          },
        );
      }
    }
  });
}
