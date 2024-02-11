import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../headers/utils/utils.dart';

class TotalViewsOnStoryScreen extends StatefulWidget {
  const TotalViewsOnStoryScreen(
      {super.key, required this.strViewCount, required this.strLikeCount});

  final String strViewCount;
  final String strLikeCount;

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
            color: Colors.orangeAccent,
            size: 18.0,
          ),
        ),
        textWithRegularStyle(
          //
          widget.strViewCount.toString(),
          14.0,
          // const Color.fromARGB(255, 176, 3, 3),
          Colors.black,
          'left',
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
        const SizedBox(
          width: 40.0,
        ),
        (widget.strLikeCount.toString() == '0')
            ? const Icon(
                Icons.favorite_border,
                color: Colors.pinkAccent,
                size: 18.0,
              )
            : const Icon(
                Icons.favorite,
                color: Colors.pinkAccent,
                size: 18.0,
              ),
        const SizedBox(
          width: 4.0,
        ),
        textWithRegularStyle(
          //
          widget.strLikeCount.toString(),
          12.0,
          const Color.fromARGB(255, 10, 1, 1),
          'left',
        ),
        /*Column(
          children: [
            if (widget.strLikeCount.toString() == '0') ...[
              //
              textWithRegularStyle(
                ' like',
                12.0,
                Colors.black,
                'left',
              ),
            ] else if (widget.strLikeCount.toString() == '1') ...[
              //
              textWithRegularStyle(
                ' like',
                12.0,
                Colors.black,
                'left',
              ),
            ] else ...[
              //
              textWithRegularStyle(
                ' likes',
                12.0,
                Colors.black,
                'left',
              ),
            ],
          ],
        ),*/
        const Spacer(),
      ],
    );
  }
}
