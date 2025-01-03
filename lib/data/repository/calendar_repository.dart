import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:koala_diving/data/model/calendar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CalendarRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'calendar_events';

  // 이벤트 저장
  Stream<List<CalendarEvent>> getAllEvents() {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return Stream.value([]); // 로그인하지 않은 경우 빈 리스트 반환

    return _firestore
        .collection(_collection)
        .where('userId', isEqualTo: userId)
        // .orderBy('date', descending: false)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => CalendarEvent.fromFirestore(doc))
            .toList());
  }

  // 새 이벤트 추가
  Future<void> addEvent(CalendarEvent event) {
    return _firestore.collection(_collection).add(event.toFirestore());
  }

  // 이벤트 업데이트
  Future<void> updateEvent(CalendarEvent event) {
    return _firestore
        .collection(_collection)
        .doc(event.id)
        .update(event.toFirestore());
  }

  // 이벤트 삭제
  Future<void> deleteEvent(String id) {
    return _firestore.collection(_collection).doc(id).delete();
  }
}

// CalendarRepository Provider
final calendarRepositoryProvider = Provider((ref) => CalendarRepository());

// 캘린더 이벤트 리스트를 스트림으로 제공하는 Provider
// final calendarEventsProvider = StreamProvider((ref) {
//   final repository = ref.watch(calendarRepositoryProvider);
//   return repository.getAllEvents(); // getEvents()를 getAllEvents()로 변경
// });

final calendarEventsProvider = StreamProvider.autoDispose((ref) {
  final repository = ref.watch(calendarRepositoryProvider);
  return repository.getAllEvents();
});
