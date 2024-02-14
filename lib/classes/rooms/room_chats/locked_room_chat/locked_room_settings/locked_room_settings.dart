// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print, invalid_return_type_for_catch_error

// import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../headers/utils/utils.dart';

class LockedRoomSettingsScreen extends StatefulWidget {
  const LockedRoomSettingsScreen({super.key, this.getLockedRoomSettings});

  final getLockedRoomSettings;

  @override
  State<LockedRoomSettingsScreen> createState() =>
      _LockedRoomSettingsScreenState();
}

class _LockedRoomSettingsScreenState extends State<LockedRoomSettingsScreen> {
  //
  var screenLoader = true;
  bool messageSwitch = true;
  bool imageSwitch = true;
  bool videoSwitch = true;
  //
  var strRoomSettingsDocumentId = '';
  var strPermissionMessage = '0';
  var strPermissionImage = '0';
  var strPermissionVideo = '0';
  //
  var strRoomDocumentId = '';
  //
  @override
  void initState() {
    if (kDebugMode) {
      print('======== FULL ROOM DATA =============');
      print(widget.getLockedRoomSettings);
      print('=====================================');
    }
    //
    strRoomDocumentId = widget.getLockedRoomSettings['documentId'].toString();
    //
    checkAllPermissionStatus();
    // getThisGroupSetting();
    super.initState();
  }

  checkAllPermissionStatus() {
    //
    /*
    bool messageSwitch = true;
    bool imageSwitch = true;
    bool videoSwitch = true;
    */
    //
    // print(messageSwitch);
    // print(imageSwitch);
    // print(videoSwitch);
    // print(widget
    // .getLockedRoomSettings['permissions']['permission_video'].runtimeType);
    messageSwitch =
        widget.getLockedRoomSettings['permissions']['permission_message'];
    imageSwitch =
        widget.getLockedRoomSettings['permissions']['permission_image'];
    videoSwitch =
        widget.getLockedRoomSettings['permissions']['permission_video'];
    // print(messageSwitch);
    // print(imageSwitch);
    // print(videoSwitch);
    /*if (widget.getLockedRoomSettings['permissions']['permission_message']
            .toString() ==
        '0') {
      //
      messageSwitch = widget.getLockedRoomSettings['permissions']['permission_message'];
    } else {
      //
      messageSwitch = true;
    }
    //
    // image
    if (widget.getLockedRoomSettings['permissions']['permission_image']
            .toString() ==
        '0') {
      //
      imageSwitch = false;
    } else {
      //
      imageSwitch = true;
    }
    //
    // video
    if (widget.getLockedRoomSettings['permissions']['permission_video']
            .toString() ==
        '0') {
      //
      videoSwitch = false;
    } else {
      //
      videoSwitch = true;
    }

    if (kDebugMode) {
      print('======== FULL ROOM DATA =============');
      print(messageSwitch);
      print('=====================================');
    }*/
    //
    setState(() {
      screenLoader = false;
    });
    // check image
    // check video
  }

  /*getThisGroupSetting() {
    //
    if (kDebugMode) {
      print('========= ROOM DOCUMENT ID ========');
      print(strRoomDocumentId);
      print('===================================');
    }
    //
    FirebaseFirestore.instance
        .collection(
          '${strFirebaseMode}settings/room_settings/$strRoomDocumentId',
        )
        .get()
        .then((value) {
      if (kDebugMode) {
        print(value.docs);
      }

      if (value.docs.isEmpty) {
        if (kDebugMode) {
          print('===== NO SETTINGS FOUND ====');
        }
        //
        CollectionReference users = FirebaseFirestore.instance.collection(
          '${strFirebaseMode}settings/room_settings/$strRoomDocumentId',
        );
        users
            .add(
              {
                'room_document_id': strRoomDocumentId.toString(),
                //
                'permission_message': strPermissionMessage.toString(),
                'permission_image': strPermissionImage.toString(),
                'permission_video': strPermissionVideo.toString(),
                //
              },
            )
            .then((value) =>
                    //
                    // edit document id  after create setting
                    FirebaseFirestore.instance
                        .collection(
                          '${strFirebaseMode}settings/room_settings/$strRoomDocumentId',
                        )
                        .doc(value.id)
                        .set(
                      {
                        'documentId': value.id,
                      },
                      SetOptions(merge: true),
                    ).then(
                      (value1) {
                        //
                        //
                        strRoomSettingsDocumentId = value.id;
                        // get all value in setting
                        getThisGroupSetting();
                      },
                    )

                //
                )
            .catchError(
              (error) => print("Failed to add user: $error"),
            );
        //
      } else {
        for (var element in value.docs) {
          if (kDebugMode) {
            print('======> YES,  USER FOUND');
            print(element.id);
            print('==============================================');
            print('====== YES, SETTINGS DATA ALREADY IN DB ======');
            print('==============================================');
          }
          //
          strRoomSettingsDocumentId = element.id;
          //
          if (element.data()['permission_message'].toString() == '0') {
            messageSwitch = false;
          } else {
            messageSwitch = true;
          }
          //
          if (element.data()['permission_image'].toString() == '0') {
            imageSwitch = false;
          } else {
            imageSwitch = true;
          }
          //
          if (element.data()['permission_video'].toString() == '0') {
            videoSwitch = false;
          } else {
            videoSwitch = true;
          }
          //
          setState(() {
            screenLoader = false;
          });
        }
      }
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: textWithSemiBoldStyle(
          //
          'Settings',
          16.0,
          Colors.white,
        ),
        leading: IconButton(
          onPressed: () {
            FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromRGBO(31, 43, 66, 1),
      ),
      body: screenLoader == true
          ? Center(
              child: textWithRegularStyle(
                'please wait...',
                12.0,
                Colors.black,
                'left',
              ),
            )
          : Column(
              children: [
                //
                ListTile(
                  title: textWithSemiBoldStyle(
                    'Message in group',
                    18.0,
                    Colors.black,
                  ),
                  subtitle: textWithRegularStyle(
                    'Anyone in this group will send message.',
                    12.0,
                    Colors.grey,
                    'left',
                  ),
                  trailing: Switch(
                    // This bool value toggles the switch.
                    value: messageSwitch,
                    activeColor: Colors.red,
                    onChanged: (bool value) {
                      // This is called when the user toggles the switch.
                      setState(() {
                        messageSwitch = value;
                      });
                      //
                      print(messageSwitch);
                      // HapticFeedback.lightImpact();
                      // // edit
                      /*messageSwitch == false
                          ? editRoomSettings('message', '0')
                          : editRoomSettings('message', '1');*/
                      editRoomSettings();
                    },
                  ),
                ),
                //
                const Divider(),
                ListTile(
                  title: textWithSemiBoldStyle(
                    'Image',
                    18.0,
                    Colors.black,
                  ),
                  subtitle: textWithRegularStyle(
                    'Anyone in this group will share images.',
                    12.0,
                    Colors.grey,
                    'left',
                  ),
                  trailing: Switch(
                    // This bool value toggles the switch.
                    value: imageSwitch,
                    activeColor: Colors.red,
                    onChanged: (bool value) {
                      // This is called when the user toggles the switch.
                      setState(() {
                        imageSwitch = value;
                      });
                      // print(imageSwitch);
                      //
                      HapticFeedback.lightImpact();
                      // edit
                      editRoomSettings();
                      //
                      /*imageSwitch == false
                          ? editRoomSettings('permission_image', '0')
                          : editRoomSettings('permission_image', '1');*/
                    },
                  ),
                ),
                //
                const Divider(),
                ListTile(
                  title: textWithSemiBoldStyle(
                    'Video',
                    18.0,
                    Colors.black,
                  ),
                  subtitle: textWithRegularStyle(
                    'Anyone in this group will share videos.',
                    12.0,
                    Colors.grey,
                    'left',
                  ),
                  trailing: Switch(
                    // This bool value toggles the switch.
                    value: videoSwitch,
                    activeColor: Colors.red,
                    onChanged: (bool value) {
                      // This is called when the user toggles the switch.
                      setState(() {
                        videoSwitch = value;
                      });
                      //
                      HapticFeedback.lightImpact();
                      // edit
                      editRoomSettings();
                      //
                      /*videoSwitch == false
                          ? editRoomSettings('permission_video', '0')
                          : editRoomSettings('permission_video', '1');*/
                    },
                  ),
                ),
                //
                const Divider(),
              ],
            ),
    );
  }

  //
  /// edit data
  editRoomSettings() {
    //
    /*print(strRoomDocumentId);
    print(strRoomSettingsDocumentId);
    print(key);
    print(value);*/
    //
    // if (key == 'message') {
    //
    FirebaseFirestore.instance
        .collection(
          '${strFirebaseMode}rooms',
        )
        .doc(strRoomDocumentId)
        .update(
      {
        'permissions': {
          'permission_image': imageSwitch,
          'permission_message': messageSwitch,
          'permission_video': videoSwitch,
        }
      },
      //  SetOptions(merge: true),
    ).then(
      (value1) {
        //
        //print('done');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green[200],
          content: textWithRegularStyle(
            '!!! Edited !!!',
            14.0,
            Colors.black,
            'left',
          ),
        ));
      },
    );
    //
    /*} else if (key == 'image') {
      FirebaseFirestore.instance
          .collection(
            '${strFirebaseMode}rooms',
          )
          .doc(strRoomDocumentId)
          .update(
        {
          'permissions': {
            'permission_image': '1.0',
            'permission_message': '1.0',
            // 'permission_video': '1.0',
          }
        },
        //  SetOptions(merge: true),
      ).then(
        (value1) {
          //
          //print('done');
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green[200],
            content: textWithRegularStyle(
              '!!! Edited !!!',
              14.0,
              Colors.black,
              'left',
            ),
          ));
        },
      );
    } else {
      //
      FirebaseFirestore.instance
          .collection(
            '${strFirebaseMode}rooms',
          )
          .doc(strRoomDocumentId)
          .update(
        {
          'permissions': {
            'permission_image': '1.0',
            'permission_message': '1.0',
            // 'permission_video': '1.0',
          }
        },
        //  SetOptions(merge: true),
      ).then(
        (value1) {
          //
          //print('done');
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green[200],
            content: textWithRegularStyle(
              '!!! Edited !!!',
              14.0,
              Colors.black,
              'left',
            ),
          ));
        },
      );
    }*/
  }
}
