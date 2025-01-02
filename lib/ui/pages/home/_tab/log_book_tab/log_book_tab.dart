import 'package:flutter/material.dart';
import 'package:koala_diving/data/model/calendar.dart';
import 'package:koala_diving/data/repository/calendar_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:koala_diving/ui/pages/home/_tab/log_book_tab/widgets/log_calendar_view.dart';
import 'package:koala_diving/ui/pages/home/_tab/log_book_tab/widgets/log_calendar_tab_app_bar.dart';

class LogBookTab extends StatefulWidget {
  LogBookTab({super.key});

  @override
  State<LogBookTab> createState() => _LogBookTabState();
}

class _LogBookTabState extends State<LogBookTab> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final eventsAsyncValue = ref.watch(calendarEventsProvider);

        return Container(
          color: Colors.white,
          child: SizedBox.expand(
            child: Column(
              children: [
                LogCalendarTabAppBar(
                  selectedDate: selectedDate,
                  onAddItem: (Map<String, String> newItem) {
                    final event = CalendarEvent(
                      id: '',
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
                      LogCalendarView(
                        key: ValueKey(eventsAsyncValue.hashCode),
                        onDateSelected: (date) {
                          setState(() {
                            selectedDate = date;
                          });
                        },
                        savedItems: eventsAsyncValue.when(
                          data: (events) =>
                              events.map((e) => e.toMap()).toList(),
                          loading: () => [],
                          error: (_, __) => [],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
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
