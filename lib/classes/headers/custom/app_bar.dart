// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names, override_on_non_overriding_member, annotate_overrides

import 'package:crazy_anamak/classes/headers/utils/utils.dart';
import 'package:flutter/material.dart';
// import 'package:my_new_orange/header/utils/Utils.dart';

class AppBarScreen extends StatefulWidget implements PreferredSizeWidget {
  @override
  final String str_status;
  final String str_app_bar_title;
  final Size preferredSize;

  const AppBarScreen({
    super.key,
    required this.str_app_bar_title,
    required this.str_status,
  })  : preferredSize = const Size.fromHeight(56.0);

  @override
  State<AppBarScreen> createState() => _AppBarScreenState();
}

class _AppBarScreenState extends State<AppBarScreen> {
  @override
  Widget build(BuildContext context) {
    return (widget.str_status == '0')
        ? AppBar(
            title: textWithRegularStyle(
              widget.str_app_bar_title,
              18.0,
              Colors.white,
              'center',
            ),
            automaticallyImplyLeading: false,
            backgroundColor: app_blue_color,
          )
        : AppBar(
            title: textWithRegularStyle(
              widget.str_app_bar_title,
              16.0,
              Colors.white,
              'center',
            ),
            leading: IconButton(
              icon: const Icon(
                Icons.chevron_left,
                color: Colors.white,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            automaticallyImplyLeading: true,
            backgroundColor: app_blue_color,
          );
  }
}
