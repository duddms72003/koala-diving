// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:koala_diving/data/model/calendar.dart';
// import 'package:koala_diving/data/repository/calendar_repository.dart';

// // 캘린더 이벤트 리스트를 스트림으로 제공하는 Provider
// final calendarEventsProvider =
//     StreamProvider.family<List<CalendarEvent>, String>((ref, userId) {
//   final repository = ref.watch(calendarRepositoryProvider);
//   return repository.getUserEvents(userId);
// });
