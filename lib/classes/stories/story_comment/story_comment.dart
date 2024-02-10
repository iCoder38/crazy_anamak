// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';

import '../../headers/utils/utils.dart';

class StoryCommentScreen extends StatefulWidget {
  const StoryCommentScreen({super.key, this.storyFullDetails});

  final storyFullDetails;
  @override
  State<StoryCommentScreen> createState() => _StoryCommentScreenState();
}

class _StoryCommentScreenState extends State<StoryCommentScreen> {
  @override
  void initState() {
    if (kDebugMode) {
      print(widget.storyFullDetails);
    }
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
      ),
      body: textWithRegularStyle(
        'str',
        14.0,
        Colors.black,
        'left',
      ),
    );
  }
}
