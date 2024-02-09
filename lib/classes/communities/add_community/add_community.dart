import 'dart:io';
import 'dart:math';

import 'package:crazy_anamak/classes/headers/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:synapse_new/controllers/update_data_on_firebase/counters/add_in_community/community.dart';
import 'package:uuid/uuid.dart';

// import '../../../common/alert/alert.dart';
// import '../../../firebase_modals/firebase_auth_modals/firebase_firestore_utils/firebase_firestore_utils.dart';
// import '../../utils/utils.dart';

class AddEditCommunityScreen extends StatefulWidget {
  const AddEditCommunityScreen({super.key});

  @override
  State<AddEditCommunityScreen> createState() => _AddEditCommunityScreenState();
}

class _AddEditCommunityScreenState extends State<AddEditCommunityScreen> {
  //
  var strLoader = '0';
  File? imageFile;
  XFile? image;
  final ImagePicker picker = ImagePicker();
  var communityImageUrl = '';
  //
  final formKey = GlobalKey<FormState>();
  //
  var uuid = const Uuid().v4();
  late final TextEditingController contCommunityName;
  late final TextEditingController contCommunityAbout;
  //
  var documentIdForCommunitiesCount = '0';
  var totalCoummunities = '0';
  var totalCoummunitiesAfterAdd = '0';
  //
  @override
  void initState() {
    //
    contCommunityName = TextEditingController();
    contCommunityAbout = TextEditingController();
    //
    // getLoginUserData();
    super.initState();
  }

  @override
  void dispose() {
    contCommunityName.dispose();
    contCommunityAbout.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: textWithSemiBoldStyle('Add community', 16.0, Colors.black),
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
              pickImageUI(context),
              //
              // UI : name
              nameUI(),
              //
              // UI : about
              aboutUI(),
              //
              // UI : add community
              addCommunityButtonUI(context),
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector pickImageUI(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //
        pickImage();
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 160,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              12.0,
            ),
            border: Border.all(
              width: 0.4,
            ),
          ),
          child: image == null
              ? const Center(
                  child: Icon(
                    Icons.camera_alt,
                    size: 40,
                  ),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(
                    12.0,
                  ),
                  child: Image.file(
                    File(image!.path),
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                  ),
                ),
        ),
      ),
    );
  }

  Padding addCommunityButtonUI(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          //
          if (formKey.currentState!.validate()) {
            //
            setState(() {
              strLoader = '1';
            });

            imageValidationCheckBeforeUpload();
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
                    'Add community', 14.0, Colors.white, 'left'),
          ),
        ),
      ),
    );
  }

  Padding nameUI() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: contCommunityName,
        obscureText: false,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: 'Name',
          labelStyle: GoogleFonts.poppins(
            fontSize: 16.0,
            color: Colors.grey,
          ),
          hintText: 'name...',
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
    );
  }

  Padding aboutUI() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: contCommunityAbout,
        obscureText: false,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: 'About',
          labelStyle: GoogleFonts.poppins(
            fontSize: 16.0,
            color: Colors.grey,
          ),
          hintText: 'about...',
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
    );
  }

  //
  Future<void> pickImage() async {
    var img = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      image = img;
      //
      communityImageUrl = 'yes';
    });
    //
  }

  // Generate random strings
  String generateRandomString(int lengthOfString) {
    final random = Random();
    const allChars =
        'AaBbCcDdlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1EeFfGgHhIiJjKkL234567890';
    // below statement will generate a random string of length using the characters
    // and length provided to it
    final randomString = List.generate(lengthOfString,
        (index) => allChars[random.nextInt(allChars.length)]).join();
    return randomString; // return the generated string
  }

  //
  Future uploadImageToFirebase(BuildContext context, savedUUID) async {
    if (kDebugMode) {
      print('dishu');
    }
    //
    // var generateRandomNumber = generateRandomString(10);
    var file = File(image!.path);
    var snapshot = await FirebaseStorage.instance
        .ref()
        // .child('communities/images/${generateRandomString(10)}')
        .child('test_image/$savedUUID/content/display_image')
        //
        .putFile(file);
    // .onComplete;
    var downloadUrl = await snapshot.ref.getDownloadURL();
    setState(() {
      if (kDebugMode) {
        print(downloadUrl);
      }
      communityImageUrl = downloadUrl;
      //
      createCommunityWithFirebase(
        savedUUID,
      );
    });
  }

  imageValidationCheckBeforeUpload() {
    //
    var setUUID = uuid.toString();
    //
    if (kDebugMode) {
      print(communityImageUrl);
    }
    if (communityImageUrl == 'yes') {
      //
      uploadImageToFirebase(context, setUUID);
    } else {
      //
      createCommunityWithFirebase(setUUID);
    }
  }

  // add community in firebase
  createCommunityWithFirebase(setUUID) {
    //
    if (kDebugMode) {
      print('=======================');
      print('adding community');
      print('=======================');
    }

    CollectionReference users = FirebaseFirestore.instance.collection(
      '${strFirebaseMode}communities',
    );

    users
        .add(
          {
            'communityImage': communityImageUrl.toString(),
            'communityId': setUUID.toString(),
            'communityName': contCommunityName.text.toString(),
            'communityAbout': contCommunityAbout.text.toString(),
            // counter
            'joined_members_count': '0',
            'like_count': '',
            'time_stamp': DateTime.now().millisecondsSinceEpoch,
            // admin details
            'adminId': FirebaseAuth.instance.currentUser!.uid,
            'adminName':
                'Anamak Admin', // FirebaseAuth.instance.currentUser!.displayName,
            'adminEmail':
                'dishantrajput2021@gmail.com', // FirebaseAuth.instance.currentUser!.email,
            'adminProfilePicture': ''.toString(),
            //
            'communityAdminId': [
              FirebaseAuth.instance.currentUser!.uid,
            ],
            'community_id': [
              setUUID.toString(),
            ],
            'category': 'random',
            'only_admin': 'no',
            'type': 'community',
            'active': 'yes',
          },
        )
        .then(
          (value) =>
              //
              addCommunityIdInCommunity(
            value.id,
            setUUID.toString(),
          ),
        )
        .catchError(
          (error) => print("Failed to add user: $error"),
        );
  }

  //
  addCommunityIdInCommunity(elementId, cid) {
    //
    if (kDebugMode) {
      print('add community id in id');
      print(elementId);
      print('=======================');
    }

    FirebaseFirestore.instance
        .collection("${strFirebaseMode}communities")
        // .doc('India')
        // .collection('data')
        .doc(elementId)
        .set(
      {
        'documentId': elementId,
      },
      SetOptions(merge: true),
    ).then(
      (value1) {
        // success
        successAndPerform();
      },
    );
  }

  successAndPerform() {
    if (kDebugMode) {
      print('COMMUNITY ADDED SUCCESSFULLY');
      print('=======================');
    }
    setState(() {
      strLoader = '0';
    });
    Navigator.pop(context);
  }
}
