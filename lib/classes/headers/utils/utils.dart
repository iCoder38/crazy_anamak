// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

var str_sign_up_alert_message =
    'We will not share any type of your personal information with anyone. This information is only for security purpose.';

var font_family_name = 'Avenir Next';

// FIREBASE MODE
// test mode
var strFirebaseMode = 'mode/test/';

// live mode
// var strFirebaseMode = 'mode/live/';

//
var app_blue_color = const Color.fromARGB(255, 85, 137, 226);
var app_color = const Color.fromRGBO(112, 202, 248, 1);

// navigation title
var str_n_t_set_name = 'Set name';

// public messgae count
var public_message_count = 40;

//
var databaseTableName = 'anamak_category_list_db_2';

/* ================== FIREBASE COLLECTIONS NAME =================== */
var collection_community = 'communities';
var collection_all_stories = 'stories';
var collection_room = 'rooms';
var collection_room_premission = 'room_permission';
/* ================================================================ */

// text with regular
Text text_with_regular_style(str) {
  return Text(
    str.toString(),
    style: GoogleFonts.montserrat(
      fontSize: 16.0,
    ),
  );
}

// text with bold
Text text_with_bold_style(str) {
  return Text(
    str.toString(),
    style: GoogleFonts.montserrat(
      fontSize: 18.0,
      fontWeight: FontWeight.w700,
    ),
  );
}

/* ================================================================ */

/* ================================================================ */

// chat user
Text textWithRegularStyle(str, textSize, textColor, textDirection) {
  return (textDirection == 'left')
      ? Text(
          str.toString(),
          textAlign: TextAlign.left,
          style: GoogleFonts.poppins(
            fontSize: textSize,
            color: textColor,
          ),
        )
      : Text(
          str.toString(),
          textAlign: TextAlign.right,
          style: GoogleFonts.poppins(
            fontSize: textSize,
            color: textColor,
          ),
        );
}

Text textWithSemiBoldStyle(str, textSize, textColor) {
  return Text(
    str.toString(),
    style: GoogleFonts.poppins(
      fontSize: textSize,
      fontWeight: FontWeight.w700,
      color: textColor,
    ),
  );
}

/* ================================================================ */
/* ================================================================ */

/* ========== CONVERT TIMESTAMP TO DATE AND TIME =============== */

funcConvertTimeStampToDateAndTime(getTimeStamp) {
  var dt = DateTime.fromMillisecondsSinceEpoch(getTimeStamp);
  // var d12HourFormat = DateFormat('dd/MM/yyyy, hh:mm').format(dt);
  var d12HourFormatTime = DateFormat('hh:mm a').format(dt);
  return d12HourFormatTime;
}

/* ================================================================ */
/* ========== DATE , TIME for CHAT ================================ */

convertTimeAndStampForChat(getTimeStamp) {
  var dt = DateTime.fromMillisecondsSinceEpoch(getTimeStamp);
  // var d12HourFormat = DateFormat('dd/MM/yyyy, hh:mm').format(dt);
  var d12HourFormatDateAndTimeboth = DateFormat('hh:mm a').format(dt);
  // var d12HourFormatTime = DateFormat('hh:mm a').format(dt);
  return d12HourFormatDateAndTimeboth;
}

/* ================================================================ */
/* ================================================================ */

ShimmerLoader({required double width, double? height, Color? color}) {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Container(
      width: width,
      height: height ?? 10,
      color: color ?? Colors.white,
    ),
  );
}
/* ================================================================ */
/* ================================================================ */