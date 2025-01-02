import 'package:flutter/material.dart';
import 'package:koala_diving/ui/pages/chat/chat_list_page.dart';
import 'package:koala_diving/ui/pages/home/_tab/calendar_tab/calendar_tab.dart';
import 'package:koala_diving/ui/pages/home/_tab/home_tab/home_tab.dart';
import 'package:koala_diving/ui/pages/home/_tab/log_book_tab/log_book_tab.dart';
import 'package:koala_diving/ui/pages/home/_tab/my_profile_tab/profile_tab.dart';
import 'package:koala_diving/ui/pages/home/home_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeIndexedStack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final currentIndex = ref.watch(homeViewModel);
        return IndexedStack(
          index: currentIndex,
          children: [
            HomeTab(),
            ChatListPage(), //chatTap 페이지 삭제하고 여기서 바로 chatListPage로 연결되도록 수정함
            CalendarTab(),
            LogBookTab(),
            ProfileTab(),
          ],
        );
      },
    );
  }
}
