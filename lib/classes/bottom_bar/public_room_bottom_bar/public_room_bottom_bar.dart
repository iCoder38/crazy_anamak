import 'package:crazy_anamak/classes/dialog/dialog.dart';
import 'package:crazy_anamak/classes/public_chat_room/public_chat/new_public_chat_room.dart';
import 'package:flutter/material.dart';
import 'package:lazy_load_indexed_stack/lazy_load_indexed_stack.dart';

import '../../headers/utils/utils.dart';

class PublicRoomBottomScreen extends StatefulWidget {
  const PublicRoomBottomScreen(
      {super.key,
      required this.strGetSenderName,
      required this.strGetSenderChatId,
      required this.strGetGender});

  final String strGetSenderName;
  final String strGetSenderChatId;
  final String strGetGender;

  @override
  State<PublicRoomBottomScreen> createState() => _PublicRoomBottomScreenState();
}

class _PublicRoomBottomScreenState extends State<PublicRoomBottomScreen> {
  //
  final PageStorageBucket bucket = PageStorageBucket();
  int selectedIndex = 0;

  /// Controller to handle PageView and also handles initial page
  final _pageController = PageController(initialPage: 0);

  int maxCount = 5;

// lazy index stack
  int lazyIndex = 0;
//
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  //
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: LazyLoadIndexedStack(
          index: lazyIndex,
          children: [
            //
            // FREE ROOM
            NewPublicChatRoomScreen(
              strSenderName: widget.strGetSenderName,
              strSenderChatId: widget.strGetSenderChatId,
              strGetGender: widget.strGetGender,
            ),
            // PAID ROOM
            DialogScreen(chatIdForDialog: widget.strGetSenderChatId),
            //

            //
            // Center(
            //   child: Container(
            //     height: 40,
            //     // width: 40,
            //     color: Colors.transparent,
            //     child: Center(
            //       child: textWithRegularStyle(
            //         'coming soon 3',
            //         14.0,
            //         Colors.black,
            //         'left',
            //       ),
            //     ),
            //   ),
            // ),
            //
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.grey[200],
          onTap: (index) {
            setState(() => lazyIndex = index);
          },
          currentIndex: lazyIndex,
          items: const [
            BottomNavigationBarItem(
              // backgroundColor: community_page_navigation_color(),
              icon: Icon(
                Icons.comment,
                color: Colors.black,
              ),
              label: 'Chats',
            ),
            //
            BottomNavigationBarItem(
              // backgroundColor: community_page_navigation_color(),
              icon: Icon(
                Icons.list,
                color: Colors.black,
              ),
              label: 'Dialog',
            ),
            //
            // BottomNavigationBarItem(
            //   // backgroundColor: community_page_navigation_color(),
            //   icon: Icon(
            //     Icons.money,
            //     color: Colors.black,
            //   ),
            //   label: 'Premium',
            // ),
          ],
        ),
      ),
    );
  }
}
