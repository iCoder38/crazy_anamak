// lazy load index
import 'package:crazy_anamak/classes/headers/utils/utils.dart';
import 'package:crazy_anamak/classes/rooms/all_rooms/all_rooms.dart';
import 'package:flutter/material.dart';
import 'package:lazy_load_indexed_stack/lazy_load_indexed_stack.dart';

//
class BottomBarRoomsScreen extends StatefulWidget {
  const BottomBarRoomsScreen({super.key});

  @override
  State<BottomBarRoomsScreen> createState() => _BottomBarRoomsScreenState();
}

class _BottomBarRoomsScreenState extends State<BottomBarRoomsScreen> {
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
            const AllRoomsScreen(
              strRoomLocked: 'no',
            ),
            // PAID ROOM
            const AllRoomsScreen(
              strRoomLocked: 'yes',
            ),
            //

            //
            Center(
              child: Container(
                height: 40,
                // width: 40,
                color: Colors.transparent,
                child: Center(
                  child: textWithRegularStyle(
                    'coming soon 3',
                    14.0,
                    Colors.black,
                    'left',
                  ),
                ),
              ),
            ),
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
                Icons.group,
                color: Colors.black,
              ),
              label: 'Free',
            ),
            //
            BottomNavigationBarItem(
              // backgroundColor: community_page_navigation_color(),
              icon: Icon(
                Icons.money,
                color: Colors.black,
              ),
              label: 'Locked',
            ),
            //
            BottomNavigationBarItem(
              // backgroundColor: community_page_navigation_color(),
              icon: Icon(
                Icons.money,
                color: Colors.black,
              ),
              label: 'Premium',
            ),
          ],
        ),
      ),
    );
  }
}
