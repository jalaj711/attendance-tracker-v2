import 'package:attendance_tracker/components/add_subject_fab.dart';
import 'package:attendance_tracker/components/attendance_card.dart';
import 'package:attendance_tracker/components/bottom_app_bar.dart';
import 'package:attendance_tracker/models/attendance_type.dart';
import 'package:attendance_tracker/models/calendar_screen_arguments.dart';
import 'package:flutter/material.dart';
import 'package:dart_date/dart_date.dart';

class CalendarEntry {
  DateTime timestamp;
  int status;
  bool isSet;

  CalendarEntry({required this.timestamp, this.status = 0, this.isSet = false});

  @override
  String toString() {
    return "CalendarEntry{timestamp=$timestamp, status=$status, isSet=$isSet}";
  }
}

class SubjectCalendarScreen extends StatefulWidget {
  static const routeName = '/calendar';

  const SubjectCalendarScreen({
    super.key,
  });

  @override
  State<SubjectCalendarScreen> createState() => _SubjectCalendarScreenState();
}

class _SubjectCalendarScreenState extends State<SubjectCalendarScreen> {
  int _month = DateTime.now().month;
  int _year = DateTime.now().year;

  @override
  Widget build(BuildContext context) {
    var args = (ModalRoute.of(context)!.settings.arguments
            as CalendarScreenArguments?) ??
        CalendarScreenArguments(null);

    var initialDate = DateTime(_year, _month).startOfWeek;
    var finalDate = DateTime(_year, _month).endOfMonth.endOfWeek;
    var numDays = finalDate.differenceInDays(initialDate);

    var serverData = [
      Attendance(
          id: 1,
          present: true,
          subject_id: 1,
          timestamp: DateTime.now().subDays(14)),
      Attendance(
          id: 1,
          present: false,
          subject_id: 1,
          timestamp: DateTime.now().subDays(12)),
      Attendance(
          id: 1,
          present: true,
          subject_id: 1,
          timestamp: DateTime.now().subDays(12)),
      Attendance(
          id: 1,
          present: false,
          subject_id: 1,
          timestamp: DateTime.now().subDays(10)),
      Attendance(
          id: 1,
          present: true,
          subject_id: 1,
          timestamp: DateTime.now().subDays(8)),
      Attendance(
          id: 1,
          present: false,
          subject_id: 1,
          timestamp: DateTime.now().subDays(6)),
      Attendance(
          id: 1,
          present: true,
          subject_id: 1,
          timestamp: DateTime.now().subDays(4)),
      Attendance(
          id: 1,
          present: true,
          subject_id: 1,
          timestamp: DateTime.now().subDays(4)),
      Attendance(
          id: 1,
          present: true,
          subject_id: 1,
          timestamp: DateTime.now().subDays(2)),
      Attendance(
          id: 1,
          present: false,
          subject_id: 1,
          timestamp: DateTime.now().subDays(1)),
      Attendance(
          id: 1,
          present: false,
          subject_id: 1,
          timestamp: DateTime.now().subDays(1)),
    ];

    var calendar = List<List<CalendarEntry>>.generate(
        (numDays / 7).round(),
        (week) => List.generate(
            7,
            (day) =>
                CalendarEntry(timestamp: initialDate.addDays(week * 7 + day))));

    var present = 0;
    var absent = 0;
    serverData.forEach((elem) {
      var diff = elem.timestamp.differenceInDays(initialDate);
      if (!calendar[(diff / 7).floor()][diff % 7].isSet) {
        calendar[(diff / 7).floor()][diff % 7].isSet = true;
      }

      if (elem.present) {
        present++;
        calendar[(diff / 7).floor()][diff % 7].status++;
      } else {
        absent++;
        calendar[(diff / 7).floor()][diff % 7].status--;
        print("absent on ${calendar[(diff / 7).floor()][diff % 7]}");
      }
    });

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 48, 12, 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Calendar',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Text(
                'Subject: ${args.subjectID}',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.merge(const TextStyle(color: Color(0xffaaaaaa))),
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateTime(_year, _month).format('yMMMM'),
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              if (_month == 1) {
                                _month = 12;
                                _year -= 1;
                              } else {
                                _month -= 1;
                              }
                            });
                          },
                          icon: const Icon(Icons.chevron_left_rounded)),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              if (_month == 12) {
                                _month = 1;
                                _year += 1;
                              } else {
                                _month += 1;
                              }
                            });
                          },
                          icon: const Icon(Icons.chevron_right_rounded))
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Table(
                children: [
                  TableRow(
                      children: ["S", "M", "T", "W", "T", "F", "S"]
                          .map((e) => TextButton(
                              onPressed: null,
                              child: Text(e,
                                  style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.w600))))
                          .toList()),
                  ...calendar
                      .map((e) => TableRow(
                          children: e
                              .map((date) => Container(
                                  padding: const EdgeInsets.all(4),
                                  child: Badge(
                                      smallSize: date.isSet ? 8 : 0,
                                      backgroundColor: Color(date.status > 0 ? 0xaa66ff66 : (date.status == 0 ? 0xaaffff66 : 0xaaff6666)),
                                      child: TextButton(
                                          onPressed: date.timestamp.month == _month
                                              ? () {}
                                              : null,
                                          child: Text(
                                            date.timestamp.format('dd'),
                                            style: TextStyle(
                                                color: date.timestamp.month == _month
                                                    ? Colors.white60
                                                    : Colors.white24),
                                          )))))
                              .toList()))
                      .toList()
                ],
              ),
              AttendanceCard(
                  attendance: Attendance(
                      id: 1,
                      subject_id: 1,
                      present: true,
                      timestamp: DateTime.now()))
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomBar(),
      floatingActionButton: const AddSubjectFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
    );
  }
}
