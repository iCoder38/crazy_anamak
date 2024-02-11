// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../headers/utils/utils.dart';

class CreateRoomScreen extends StatefulWidget {
  const CreateRoomScreen({super.key});

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  //
  var strRoomType = '1';
  //
  var strRoomPaid = 'no';
  var strLoader = '0';
  final formKey = GlobalKey<FormState>();
  //
  late final TextEditingController contRoomTitle;
  late final TextEditingController contRoomPrivatePassword;
  late final TextEditingController contRoomCategory;
  late final TextEditingController contRoomDescription;
  //
  @override
  void initState() {
    //
    contRoomTitle = TextEditingController();
    contRoomCategory = TextEditingController();
    contRoomDescription = TextEditingController();
    contRoomPrivatePassword = TextEditingController();
    //
    // getLoginUserData();
    super.initState();
  }

  @override
  void dispose() {
    contRoomTitle.dispose();
    contRoomCategory.dispose();
    contRoomDescription.dispose();
    contRoomPrivatePassword.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: textWithSemiBoldStyle('Create room', 16.0, Colors.black),
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
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          key: formKey,
          child: Column(
            children: [
              //
              // UI : Pick image
              //pickImageUI(context),
              //
              // UI : name
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: contRoomTitle,
                  obscureText: false,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Title',
                    labelStyle: GoogleFonts.poppins(
                      fontSize: 14.0,
                      color: Colors.grey,
                    ),
                    hintText: 'title...',
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 12.0,
                      color: Colors.grey,
                    ),
                  ),
                  maxLines: 1,
                  maxLength: 40,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              ),

              //
              // UI : about
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: contRoomDescription,
                  obscureText: false,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Description',
                    labelStyle: GoogleFonts.poppins(
                      fontSize: 14.0,
                      color: Colors.grey,
                    ),
                    hintText: 'description...',
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 12.0,
                      color: Colors.grey,
                    ),
                  ),
                  maxLines: 4,
                  maxLength: 260,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              ),
              //
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 236, 234, 229),
                    borderRadius: BorderRadius.circular(
                      12.0,
                    ),
                  ),
                  child: Row(
                    children: [
                      if (strRoomType == '1') ...[
                        //
                        Expanded(
                          child: Container(
                            color: Colors.transparent,
                            child: Center(
                              child: textWithSemiBoldStyle(
                                'Public',
                                18.0,
                                Colors.black,
                              ),
                            ),
                          ),
                        ),
                        //
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              //
                              setState(() {
                                strRoomType = '2';
                              });
                            },
                            child: Container(
                              color: Colors.transparent,
                              child: Center(
                                child: textWithRegularStyle(
                                  'Private',
                                  14.0,
                                  Colors.black,
                                  'left',
                                ),
                              ),
                            ),
                          ),
                        ),
                        //
                      ] else ...[
                        //
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              //
                              setState(() {
                                strRoomType = '1';
                              });
                            },
                            child: Container(
                              color: Colors.transparent,
                              child: Center(
                                child: textWithRegularStyle(
                                  'Public',
                                  14.0,
                                  Colors.black,
                                  'left',
                                ),
                              ),
                            ),
                          ),
                        ),
                        //
                        Expanded(
                          child: Container(
                            color: Colors.transparent,
                            child: Center(
                              child: textWithSemiBoldStyle(
                                'Private',
                                18.0,
                                Colors.black,
                              ),
                            ),
                          ),
                        ),
                        //
                      ],

                      //
                      /**/

                      //
                    ],
                  ),
                ),
              ),
              //
              (strRoomType == '1')
                  ? const SizedBox(
                      height: 10.0,
                    )
                  : Column(
                      children: [
                        //
                        const Divider(
                          height: 2,
                        ),
                        //
                        const SizedBox(
                          height: 10.0,
                        ),
                        //
                        Row(
                          children: [
                            const SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: textWithRegularStyle(
                                  'You can update your password from your created room setting.',
                                  10.0,
                                  Colors.grey,
                                  'left',
                                ),
                              ),
                            ),
                          ],
                        ),
                        //
                        const SizedBox(
                          height: 10.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: contRoomPrivatePassword,
                            obscureText: false,
                            decoration: InputDecoration(
                              suffixIcon: const Icon(Icons.password),
                              border: const OutlineInputBorder(),
                              labelText: 'Password',
                              labelStyle: GoogleFonts.poppins(
                                fontSize: 14.0,
                                color: Colors.grey,
                              ),
                              hintText: 'set password...',
                              hintStyle: GoogleFonts.poppins(
                                fontSize: 12.0,
                                color: Colors.grey,
                              ),
                            ),
                            maxLines: 1,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
              //

              // UI : add community
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    //
                    if (formKey.currentState!.validate()) {
                      //
                      setState(() {
                        strLoader = '1';
                      });

                      createRoom();
                    }
                  },
                  child: Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(200, 0, 0, 0),
                      borderRadius: BorderRadius.circular(
                        12.0,
                      ),
                    ),
                    child: Center(
                      child: strLoader == '1'
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 1.0,
                            )
                          : textWithRegularStyle(
                              'Create',
                              14.0,
                              Colors.white,
                              'left',
                            ),
                    ),
                  ),
                ),
              ),
              //
              // const Spacer(),
              textWithRegularStyle(
                'You can create your room.',
                12.0,
                Colors.grey,
                'left',
              ),
            ],
          ),
        ),
      ),
    );
  }

  //
  // add community in firebase
  createRoom() {
    //
    if (kDebugMode) {
      print('========================');
      print('adding rooms document id');
      print('========================');
    }
    FocusScope.of(context).requestFocus(FocusNode());
    //

    CollectionReference users = FirebaseFirestore.instance.collection(
      '$strFirebaseMode$collection_room',
    );

    users
        .add(
          {
            //
            // admin details
            'roomAdminId': FirebaseAuth.instance.currentUser!.uid,
            //
            'roomAdmin_id': [
              FirebaseAuth.instance.currentUser!.uid,
            ],
            //
            // details
            'title': contRoomTitle.text.toString(),
            'description': contRoomDescription.text.toString(),
            'time_stamp': DateTime.now().millisecondsSinceEpoch,
            //
            'total_likes': '0',
            'total_comments': '0',
            'total_shares': '0',
            'total_views': '0',
            'total_members': '0',
            //
            // member
            'member_count': '0',
            //
            // password
            'room_password': contRoomPrivatePassword.text.toString(),
            //
            //
            'type': strRoomType.toString(),
            'room_type': 'all',
            'active': 'yes',
            //
            'liked_users': [],
            //
            'category': '',
            //
            //
            'room_profile_picture': '',
            //
            // paid
            'room_paid': strRoomPaid.toString(),
            'room_amount': '0',
          },
        )
        .then(
          (value) =>
              //
              FirebaseFirestore.instance
                  .collection("$strFirebaseMode$collection_room")
                  .doc(value.id)
                  .set(
            {
              'documentId': value.id,
            },
            SetOptions(merge: true),
          ).then(
            (value1) {
              // success
              if (kDebugMode) {
                print('==========================');
                print('ROOM : SUCCESSFULLY ADDED');
                print('==========================');
              }
              //
              setState(() {
                strLoader = '0';
                contRoomTitle.text = '';
                contRoomDescription.text = '';
              });
              Navigator.pop(context);
              // Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.green[200],
                content: textWithRegularStyle(
                  '!!! Successfully !!!',
                  14.0,
                  Colors.black,
                  'left',
                ),
              ));
            },
          ),
        )
        .catchError(
          // ignore: invalid_return_type_for_catch_error
          (error) => print("Failed to add user: $error"),
        );
  }
  //
}
