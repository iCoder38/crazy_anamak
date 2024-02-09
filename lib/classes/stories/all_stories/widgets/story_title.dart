// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../headers/utils/utils.dart';

class StoryTitleScreen extends StatefulWidget {
  const StoryTitleScreen({super.key, required this.getStoryTitle});
  final String getStoryTitle;
  @override
  State<StoryTitleScreen> createState() => _StoryTitleScreenState();
}

class _StoryTitleScreenState extends State<StoryTitleScreen> {
  @override
  Widget build(BuildContext context) {
    return textWithSemiBoldStyle(
      //
      widget.getStoryTitle,
      22.0,
      Colors.black,
    );
  }
}
