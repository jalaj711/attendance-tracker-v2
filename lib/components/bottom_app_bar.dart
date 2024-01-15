import 'package:attendance_tracker/models/calendar_screen_arguments.dart';
import 'package:attendance_tracker/pages/calendar.dart';
import 'package:attendance_tracker/pages/home.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Theme.of(context).cardColor,
      elevation: 5,
      child: Row(
        children: <Widget>[
          IconButton(
            tooltip: 'Show Subjects',
            icon: const Icon(Icons.folder_open_rounded),
            onPressed: () {
              Navigator.pushNamed(
                context,
                MyHomePage.routeName,
              );
            },
          ),
          IconButton(
            tooltip: 'Calendar',
            icon: const Icon(Icons.calendar_month_rounded),
            onPressed: () {
              Navigator.pushNamed(
                context,
                SubjectCalendarScreen.routeName,
                arguments: CalendarScreenArguments(null),
              );
            },
          ),
        ],
      ),
    );
  }
}
