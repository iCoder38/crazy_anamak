import 'package:crazy_anamak/classes/headers/utils/utils.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';

class StoryDescriptionScreen extends StatefulWidget {
  const StoryDescriptionScreen(
      {super.key, required this.getDescription, required this.strForDetails});

  final String getDescription;
  final String strForDetails;
  @override
  State<StoryDescriptionScreen> createState() => StoryDescriptioScreennState();
}

class StoryDescriptioScreennState extends State<StoryDescriptionScreen> {
  @override
  Widget build(BuildContext context) {
    return widget.strForDetails == 'yes'
        ? textWithRegularStyle(
            //
            widget.getDescription,
            14.0,
            Colors.black,
            'left',
          )
        : ReadMoreText(
            //
            widget.getDescription,

            trimLines: 4,
            style: GoogleFonts.poppins(
              fontSize: 12.0,
              // fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
            colorClickableText: Colors.pink,
            trimMode: TrimMode.Line,
            trimCollapsedText: '...see more',
            trimExpandedText: ' ...collapse ',
          );
  }
}
