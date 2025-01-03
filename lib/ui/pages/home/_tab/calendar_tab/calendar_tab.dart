import 'package:flutter/material.dart';
import 'package:koala_diving/data/model/calendar.dart';
import 'package:koala_diving/data/repository/calendar_repository.dart';
import 'package:koala_diving/ui/pages/home/_tab/calendar_tab/widgets/calendar_tab_app_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'widgets/calendar_view.dart';
import 'widgets/calendar_list.dart';

class CalendarTab extends ConsumerStatefulWidget {
  const CalendarTab({super.key});

  @override
  ConsumerState<CalendarTab> createState() => _CalendarTabState();
}

class _CalendarTabState extends ConsumerState<CalendarTab> {
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        ref.refresh(calendarEventsProvider);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final eventsAsyncValue = ref.watch(calendarEventsProvider);

    return Container(
      color: Colors.white,
      child: SizedBox.expand(
        child: Column(
          children: [
            CalendarTabAppBar(
              selectedDate: selectedDate,
              onAddItem: (Map<String, String> newItem) {
                final userId = FirebaseAuth.instance.currentUser?.uid;
                if (userId == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('로그인이 필요합니다')),
                  );
                  return;
                }

                final event = CalendarEvent(
                  id: '',
                  userId: userId, // userId 필드 다시 추가
                  title: newItem['name'] ?? '',
                  date: _parseDateString(newItem['date'] ?? ''),
                  time: newItem['time'] ?? '',
                  location: newItem['location'] ?? '',
                );
                ref.read(calendarRepositoryProvider).addEvent(event);
              },
            ),
            Expanded(
              child: Column(
                children: [
                  CalendarView(
                    key: ValueKey(eventsAsyncValue.hashCode),
                    onDateSelected: (date) {
                      setState(() {
                        selectedDate = date;
                      });
                    },
                    savedItems: eventsAsyncValue.when(
                      data: (events) => events.map((e) => e.toMap()).toList(),
                      loading: () => [],
                      error: (_, __) => [],
                    ),
                  ),
                  eventsAsyncValue.when(
                    data: (events) => CalendarList(
                      savedItems: events.map((e) => e.toMap()).toList(),
                      onDelete: (String id) {
                        ref.read(calendarRepositoryProvider).deleteEvent(id);
                      },
                    ),
                    loading: () => CircularProgressIndicator(),
                    error: (_, __) => Text('Error loading events'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  DateTime _parseDateString(String dateStr) {
    final regex = RegExp(r'(\d{4})년\s*(\d{1,2})월\s*(\d{1,2})일');
    final match = regex.firstMatch(dateStr);
    if (match != null) {
      final year = int.parse(match.group(1)!);
      final month = int.parse(match.group(2)!);
      final day = int.parse(match.group(3)!);
      return DateTime(year, month, day);
    }
    return DateTime.now();
  }
}
