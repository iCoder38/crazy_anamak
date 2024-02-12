// ignore_for_file: prefer_typing_uninitialized_variables

// import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../headers/utils/utils.dart';

class LockedRoomSettingsScreen extends StatefulWidget {
  const LockedRoomSettingsScreen({super.key, this.getLockedRoomSettings});

  final getLockedRoomSettings;

  @override
  State<LockedRoomSettingsScreen> createState() =>
      _LockedRoomSettingsScreenState();
}

class _LockedRoomSettingsScreenState extends State<LockedRoomSettingsScreen> {
  //
  bool light = true;
  bool imageSwitch = true;
  bool videoSwitch = true;
  //
  @override
  void initState() {
    if (kDebugMode) {
      print(widget.getLockedRoomSettings);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: textWithSemiBoldStyle(
          //
          'Settings',
          16.0,
          Colors.white,
        ),
        leading: IconButton(
          onPressed: () {
            FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromRGBO(31, 43, 66, 1),
      ),
      body: Column(
        children: [
          //
          ListTile(
            title: textWithSemiBoldStyle(
              'Message in group',
              18.0,
              Colors.black,
            ),
            subtitle: textWithRegularStyle(
              'Anyone in this group will send message.',
              12.0,
              Colors.grey,
              'left',
            ),
            trailing: Switch(
              // This bool value toggles the switch.
              value: light,
              activeColor: Colors.red,
              onChanged: (bool value) {
                // This is called when the user toggles the switch.
                setState(() {
                  light = value;
                });
              },
            ),
          ),
          //
          const Divider(),
          ListTile(
            title: textWithSemiBoldStyle(
              'Image',
              18.0,
              Colors.black,
            ),
            subtitle: textWithRegularStyle(
              'Anyone in this group will share images.',
              12.0,
              Colors.grey,
              'left',
            ),
            trailing: Switch(
              // This bool value toggles the switch.
              value: imageSwitch,
              activeColor: Colors.red,
              onChanged: (bool value) {
                // This is called when the user toggles the switch.
                setState(() {
                  imageSwitch = value;
                });
              },
            ),
          ),
          //
          const Divider(),
          ListTile(
            title: textWithSemiBoldStyle(
              'Video',
              18.0,
              Colors.black,
            ),
            subtitle: textWithRegularStyle(
              'Anyone in this group will share videos.',
              12.0,
              Colors.grey,
              'left',
            ),
            trailing: Switch(
              // This bool value toggles the switch.
              value: videoSwitch,
              activeColor: Colors.red,
              onChanged: (bool value) {
                // This is called when the user toggles the switch.
                setState(() {
                  videoSwitch = value;
                });
              },
            ),
          ),
          //
          const Divider(),
        ],
      ),
    );
  }
}
