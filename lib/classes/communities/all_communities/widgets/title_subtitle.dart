// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../headers/utils/utils.dart';
import 'display_image.dart';

class TitleSubtitleScreen extends StatefulWidget {
  const TitleSubtitleScreen({super.key, this.dataForTitleAndSubtitle});

  final dataForTitleAndSubtitle;

  @override
  State<TitleSubtitleScreen> createState() => _TitleSubtitleScreenState();
}

class _TitleSubtitleScreenState extends State<TitleSubtitleScreen> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: DisplayImageScreen(
          getDataForDisplayImage: widget.dataForTitleAndSubtitle),
      title: textWithSemiBoldStyle(
        widget.dataForTitleAndSubtitle['communityName'].toString(),
        16.0,
        Colors.black,
      ),
      subtitle: textWithRegularStyle(
        '${widget.dataForTitleAndSubtitle['joined_members_count']} members',
        12.0,
        Colors.black,
        'left',
      ),
    );
  }
}
