// ignore_for_file: prefer_typing_uninitialized_variables

// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DisplayImageScreen extends StatefulWidget {
  const DisplayImageScreen({super.key, this.getDataForDisplayImage});

  final getDataForDisplayImage;

  @override
  State<DisplayImageScreen> createState() => _DisplayImageScreenState();
}

class _DisplayImageScreenState extends State<DisplayImageScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            12.0,
          ),
          border: Border.all(width: 0.2)),
    );
  }
}
