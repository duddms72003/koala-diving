import 'package:flutter/material.dart';
import 'package:koala_diving/ui/pages/calendar/calendar_registor_page.dart';

class LogCalendarTabAppBar extends StatelessWidget {
  final DateTime? selectedDate;
  final Function(Map<String, String>) onAddItem;

  const LogCalendarTabAppBar({
    Key? key,
    required this.selectedDate,
    required this.onAddItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: Text(
        '나의 성장 일기',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      shape: Border(
        bottom: BorderSide(
          color: Color.fromRGBO(240, 240, 240, 1),
          width: 1,
        ),
      ),
      centerTitle: true,
      actions: [
        Container(
          child: IconButton(
            icon: Icon(
              Icons.add,
              size: 24,
            ),
            onPressed: () {
              //
            },
          ),
        ),
      ],
    );
  }
}
