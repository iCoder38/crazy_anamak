import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crazy_anamak/classes/bottom_bar/rooms/rooms_bottom_bar.dart';
import 'package:crazy_anamak/classes/headers/utils/utils.dart';
import 'package:crazy_anamak/classes/rooms/all_rooms/all_rooms.dart';
import 'package:crazy_anamak/classes/rooms/create_room/create_room.dart';
import 'package:crazy_anamak/classes/set_name/online_chat_entry.dart';
import 'package:crazy_anamak/classes/stories/all_stories/all_stories.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../communities/all_communities/all_communities.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //
  var arrHomeList = [];
  //
  @override
  void initState() {
    super.initState();

    //

    //
    /*arrHomeList = [
      {
        'name': 'Adventure',
        'active': 'yes',
      },
      {
        'name': 'Mystery',
        'active': 'yes',
      },
      {
        'name': 'Romance',
        'active': 'yes',
      },
      {
        'name': 'Science Fiction',
        'active': 'yes',
      },
      {
        'name': 'Fantasy',
        'active': 'yes',
      },
      {
        'name': 'Horror',
        'active': 'yes',
      },
      {
        'name': 'Humor',
        'active': 'yes',
      },
      {
        'name': 'Bildungsroman',
        'active': 'yes',
      },
      {
        'name': 'Dystopian',
        'active': 'yes',
      },
      {
        'name': 'Fairytale',
        'active': 'yes',
      },
      {
        'name': 'Historical Fiction',
        'active': 'yes',
      },
      {
        'name': 'Magical Realism',
        'active': 'yes',
      },
      {
        'name': 'Thriller',
        'active': 'yes',
      },
      {
        'name': 'Biography',
        'active': 'yes',
      },
      {
        'name': 'Memory',
        'active': 'yes',
      },
      {
        'name': 'History',
        'active': 'yes',
      },
      {
        'name': 'True Crime',
        'active': 'yes',
      },
      {
        'name': 'Science',
        'active': 'yes',
      },
      {
        'name': 'Travel',
        'active': 'yes',
      },
      {
        'name': 'Food',
        'active': 'yes',
      },
      {
        'name': 'Sports',
        'active': 'yes',
      },
      {
        'name': 'Self-Help',
        'active': 'yes',
      },
      {
        'name': 'Humor',
        'active': 'yes',
      },
      {
        'name': 'Opinion',
        'active': 'yes',
      },
    ];
    if (kDebugMode) {
      print('length ===> ${arrHomeList.length}');
    }
    //
    for (int i = 0; i < arrHomeList.length; i++) {
      //
      CollectionReference users = FirebaseFirestore.instance.collection(
        '${strFirebaseMode}category_story',
      );

      users
          .add(
            {
              'name': arrHomeList[i]['name'].toString(),
              'active': arrHomeList[i]['active'].toString(),
            },
          )
          .then(
            (value) =>
                //
                FirebaseFirestore.instance
                    .collection("${strFirebaseMode}category_story")
                    .doc(value.id)
                    .set(
              {
                'documentId': value.id,
              },
              SetOptions(merge: true),
            ).then(
              (value1) {
                // success
                print('done ===> $i');
                // successAndPerform();
              },
            ),
          )
          .catchError(
            (error) => print("Failed to add user: $error"),
          );
    }*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('data'),
      // ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(
              top: 60.0,
              bottom: 0,
            ),
            color: Colors.transparent,
            // width: 48.0,
            height: 48.0,
            child: Align(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 50,
                  ),
                  Expanded(
                    child: textWithSemiBoldStyle(
                      'Home',
                      14.0,
                      Colors.pink,
                      // 'left',
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => const SettingsScreen(),
                      //   ),
                      // );
                    },
                    icon: const Icon(
                      Icons.settings,
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 40, top: 40.0),
                color: Colors.transparent,
                width: 24.0,
                height: 24.0,
                child: Image.asset(
                  'assets/images/music.png',
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 40, left: 40, top: 40.0),
                color: Colors.transparent,
                width: 24,
                height: 24,
                child: Image.asset(
                  'assets/images/link.png',
                ),
              ),
            ],
          ),
          //
          Expanded(
            child: Center(
              child: Container(
                margin: const EdgeInsets.all(10.0),
                color: Colors.transparent,
                width: MediaQuery.of(context).size.width,
                // height: 48.0,
                child: Image.asset(
                  'assets/images/logo_3.png',
                ),
              ),
            ),
          ),
          //
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 40, top: 40.0, bottom: 40),
                color: Colors.transparent,
                width: 38.0,
                height: 38.0,
                child: Image.asset(
                  'assets/images/ice-cream.png',
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                    right: 40, left: 40, top: 40.0, bottom: 40),
                color: Colors.transparent,
                width: 38.0,
                height: 38.0,
                child: Image.asset(
                  'assets/images/chat.png',
                ),
              ),
            ],
          ),
          //
          Container(
            // height: 400,
            margin: const EdgeInsets.only(
              bottom: 0,
            ),
            decoration: BoxDecoration(
              color: app_blue_color,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(
                  52,
                ),
                topRight: Radius.circular(
                  52,
                ),
              ),
            ),
            child: Align(
              alignment: Alignment.topLeft,
              child: Column(
                children: [
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(
                            left: 20,
                            top: 40,
                            right: 5,
                          ),

                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.only(
                              // 14,
                              topLeft: Radius.circular(
                                14,
                              ),
                              topRight: Radius.circular(
                                14,
                              ),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(
                                  0,
                                  3,
                                ), // changes position of shadow
                              ),
                            ],
                          ),
                          // width: 48.0,
                          height: 110.0,
                          child: Align(
                            child: Container(
                              margin: const EdgeInsets.all(10.0),
                              color: Colors.transparent,
                              width: 66.0,
                              height: 66.0,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const OnlineChatEntryScreen(),
                                    ),
                                  );
                                },
                                child: Image.asset(
                                  'assets/images/chat.png',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            //
                            if (kDebugMode) {
                              print('====> PUSH : BOTTOM BAR ====');
                            }
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const BottomBarRoomsScreen(),
                              ),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.only(
                              left: 10,
                              top: 40.0,
                              right: 20,
                            ),

                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(
                                  14,
                                ),
                                topRight: Radius.circular(
                                  14,
                                ),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(
                                    0,
                                    3,
                                  ), // changes position of shadow
                                ),
                              ],
                            ),
                            // width: 48.0,
                            height: 110.0,
                            child: Align(
                              child: Container(
                                margin: const EdgeInsets.all(10.0),
                                color: Colors.transparent,
                                width: 66.0,
                                height: 66.0,
                                child: Image.asset(
                                  'assets/images/group.png',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      //
                    ],
                  ),
                  // 2
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(
                            left: 20,
                            top: 0.0,
                            right: 5,
                          ),

                          decoration: BoxDecoration(
                            // color: const Color.fromRGBO(96, 190, 248, 1),
                            color: Colors.white,
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(
                                14,
                              ),
                              bottomRight: Radius.circular(
                                14,
                              ),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(
                                  0,
                                  3,
                                ), // changes position of shadow
                              ),
                            ],
                          ),
                          // width: 48.0,
                          height: 40,
                          child: Align(
                            child: InkWell(
                              onTap: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) =>
                                //         const SetProfileNameScreen(),
                                //   ),
                                // );
                              },
                              child: text_with_regular_style(
                                'Chat',
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            if (kDebugMode) {
                              print('object 1');
                            }
                            // func_image_alert_popup();
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) =>
                            //         const ReviewCategoryScreen(),
                            //   ),
                            // );
                          },
                          child: Container(
                            margin: const EdgeInsets.only(
                              left: 10,
                              top: 0.0,
                              right: 20,
                            ),

                            decoration: BoxDecoration(
                              // color: Colors.brown,
                              color: Colors.white,
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(
                                  14,
                                ),
                                bottomRight: Radius.circular(
                                  14,
                                ),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(
                                    0,
                                    3,
                                  ), // changes position of shadow
                                ),
                              ],
                            ),
                            // width: 48.0,
                            height: 40,
                            child: Align(
                              child: text_with_regular_style(
                                'Rooms',
                              ),
                            ),
                          ),
                        ),
                      ),
                      //
                    ],
                  ),

                  //
                  storiesUI(context),
                  //
                  const SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  GestureDetector storiesUI(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AllStoriesScreen(),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(
          left: 20,
          top: 20,
          right: 20,
        ),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(
                0,
                3,
              ), // changes position of shadow
            ),
          ],
        ),
        // width: 48.0,
        // height: 80,
        child: Align(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(10.0),
                color: Colors.transparent,
                width: 66.0,
                height: 66.0,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AllStoriesScreen(),
                      ),
                    );
                  },
                  child: Image.asset(
                    'assets/images/stories.png',
                  ),
                ),
              ),
              //
              // textWithRegularStyle(
              //     'Stories', 14.0, Colors.black, 'left'),
              Container(
                margin: const EdgeInsets.only(
                  left: 0,
                  top: 0.0,
                  right: 0,
                ),

                decoration: BoxDecoration(
                  // color: Colors.brown,
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(
                      14,
                    ),
                    bottomRight: Radius.circular(
                      14,
                    ),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(
                        0,
                        3,
                      ), // changes position of shadow
                    ),
                  ],
                ),
                // width: 48.0,
                height: 40,
                child: Align(
                  child: text_with_regular_style(
                    'Stories',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
