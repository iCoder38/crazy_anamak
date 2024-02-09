import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../headers/utils/utils.dart';

class AddStoryScreen extends StatefulWidget {
  const AddStoryScreen({super.key});

  @override
  State<AddStoryScreen> createState() => _AddStoryScreenState();
}

class _AddStoryScreenState extends State<AddStoryScreen> {
  //
  var strLoader = '0';
  final formKey = GlobalKey<FormState>();
  //
  late final TextEditingController contStoryTitle;
  late final TextEditingController contStoryDescription;
  //
  @override
  void initState() {
    //
    contStoryTitle = TextEditingController();
    contStoryDescription = TextEditingController();
    //
    // getLoginUserData();
    super.initState();
  }

  @override
  void dispose() {
    contStoryTitle.dispose();
    contStoryDescription.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: textWithSemiBoldStyle('Add story', 16.0, Colors.black),
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
                  controller: contStoryTitle,
                  obscureText: false,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Title',
                    labelStyle: GoogleFonts.poppins(
                      fontSize: 16.0,
                      color: Colors.grey,
                    ),
                    hintText: 'title...',
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

              //
              // UI : about
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: contStoryDescription,
                  obscureText: false,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Description',
                    labelStyle: GoogleFonts.poppins(
                      fontSize: 16.0,
                      color: Colors.grey,
                    ),
                    hintText: 'description...',
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 12.0,
                      color: Colors.grey,
                    ),
                  ),
                  maxLines: 6,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
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

                      createStory();
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
                              'Add', 14.0, Colors.white, 'left'),
                    ),
                  ),
                ),
              ),
              //
              // const Spacer(),
              textWithRegularStyle(
                'Express about anything.',
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
  createStory() {
    //
    if (kDebugMode) {
      print('========================');
      print('adding story document id');
      print('========================');
    }
    FocusScope.of(context).requestFocus(FocusNode());
    //

    CollectionReference users = FirebaseFirestore.instance.collection(
      '${strFirebaseMode}stories',
    );

    users
        .add(
          {
            // admin details
            'adminId': FirebaseAuth.instance.currentUser!.uid,
            //
            'admin_id': [
              FirebaseAuth.instance.currentUser!.uid,
            ],
            // details
            'title': contStoryTitle.text.toString(),
            'description': contStoryDescription.text.toString(),
            'time_stamp': DateTime.now().millisecondsSinceEpoch,
            //
            'total_likes': '0',
            'total_comments': '0',
            'total_shares': '0',
            'total_views':'0',
            //
            'type': 'story',
            'story_type': 'all',
            'active': 'yes',
          },
        )
        .then(
          (value) =>
              //
              //
              FirebaseFirestore.instance
                  .collection("$strFirebaseMode$collection_all_stories")
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
                print('STORY : SUCCESSFULLY ADDED');
              }
              //

              setState(() {
                strLoader = '0';
                contStoryTitle.text = '';
                contStoryDescription.text = '';
              });
              Navigator.pop(context);
              // Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.green[200],
                content: textWithRegularStyle(
                  'Success!!!',
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
