import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../headers/utils/utils.dart';

class TotalViewsOnStoryScreen extends StatefulWidget {
  const TotalViewsOnStoryScreen({super.key, required this.strViewCount});

  final String strViewCount;

  @override
  State<TotalViewsOnStoryScreen> createState() =>
      _TotalViewsOnStoryScreenState();
}

class _TotalViewsOnStoryScreenState extends State<TotalViewsOnStoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          onPressed: () {
            //
          },
          icon: const Icon(
            Icons.remove_red_eye,
            size: 18.0,
          ),
        ),
        textWithSemiBoldStyle(
          //
          widget.strViewCount.toString(),
          16.0,
          const Color.fromARGB(255, 176, 3, 3),
        ),
       
        Column(
          children: [
            if (widget.strViewCount.toString() == '0') ...[
              //
               textWithRegularStyle(
              ' view',
              12.0,
              Colors.black,
              'left',
            ),
            ] else if (widget.strViewCount.toString() == '1') ...[
              //
               textWithRegularStyle(
              ' view',
              12.0,
              Colors.black,
              'left',
            ),
            ] else ...[
              //
               textWithRegularStyle(
              ' views',
              12.0,
              Colors.black,
              'left',
            ),
            ],
            
          ],
        ),
      ],
    );
  }
}
