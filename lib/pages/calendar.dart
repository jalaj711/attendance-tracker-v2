import 'package:attendance_tracker/components/add_subject_fab.dart';
import 'package:attendance_tracker/components/attendance_card.dart';
import 'package:attendance_tracker/components/bottom_app_bar.dart';
import 'package:attendance_tracker/database/database.dart';
import 'package:attendance_tracker/models/attendance_type.dart';
import 'package:attendance_tracker/models/calendar_screen_arguments.dart';
import 'package:flutter/material.dart';
import 'package:dart_date/dart_date.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

class SubjectCalendarScreen extends ConsumerStatefulWidget {
  static const routeName = '/calendar';

  const SubjectCalendarScreen({
    super.key,
  });

  @override
  ConsumerState<SubjectCalendarScreen> createState() =>
      _SubjectCalendarScreenState();
}

class _SubjectCalendarScreenState extends ConsumerState<SubjectCalendarScreen> {
  int _month = DateTime.now().month;
  int _year = DateTime.now().year;
  List<List<CalendarEntry>> calendar = [];
  List<Attendance> _serverData = [];
  int present = 0;
  int absent = 0;
  DateTime? _selectedDate;

  void reloadAppAttendances() {
    var initialDate = DateTime(_year, _month).startOfWeek;
    var finalDate = DateTime(_year, _month).endOfMonth.endOfWeek;
    var numDays = finalDate.differenceInDays(initialDate);

    setState(() {
      calendar = List<List<CalendarEntry>>.generate(
          (numDays / 7).round(),
          (week) => List.generate(
              7,
              (day) => CalendarEntry(
                  timestamp: initialDate.addDays(week * 7 + day))));
    });

    final subjId = ((ModalRoute.of(context)!.settings.arguments
                as CalendarScreenArguments?) ??
            CalendarScreenArguments(null))
        .subjectID;

    if (subjId != null) {
      ref
          .read(AppDatabase.provider)
          .getAllAttendancesBySubject(subjId)
          .then((value) {
        setState(() {
          present = 0;
          absent = 0;
          for (var elem in value) {
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
            }
          }
        });
        _serverData = value;
      });
    } else {
      ref.read(AppDatabase.provider).getAttendancesOnDates(_year, _month, null).then((value) {
        setState(() {
          present = 0;
          absent = 0;
          for (var elem in value) {
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
            }
          }
          _serverData = value;
        });
      });
    }
  }

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      reloadAppAttendances();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 48, 12, 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Calendar',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Text(
                "subject",
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

                              reloadAppAttendances();
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

                              reloadAppAttendances();
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
                                  child: TextButton(
                                      onPressed: date.timestamp.month == _month
                                          ? () {
                                              setState(() {
                                                if (_selectedDate ==
                                                    date.timestamp) {
                                                  _selectedDate = null;
                                                } else {
                                                  _selectedDate =
                                                      date.timestamp;
                                                }
                                              });
                                            }
                                          : null,
                                      style: ButtonStyle(
                                          backgroundColor:
                                              _selectedDate == date.timestamp
                                                  ? MaterialStatePropertyAll(
                                                      Theme.of(context)
                                                          .colorScheme
                                                          .primary
                                                          .withAlpha(30))
                                                  : null),
                                      child: Text(
                                        date.timestamp.format('dd'),
                                        style: TextStyle(
                                            color:
                                                date.timestamp.month == _month
                                                    ? (date.isSet
                                                        ? (Color(date.status > 0
                                                            ? 0xaa66ff66
                                                            : (date.status == 0
                                                                ? 0xaaffff66
                                                                : 0xaaff6666)))
                                                        : Colors.white60)
                                                    : Colors.white24,
                                            fontWeight: date.isSet
                                                ? FontWeight.w600
                                                : FontWeight.normal),
                                      ))))
                              .toList()))
                      .toList()
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Card(
                elevation: 1,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "PRESENT: $present",
                        style: const TextStyle(
                            color: Color(0xaa66ff66),
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "ABSENT: $absent",
                        style: const TextStyle(
                            color: Color(0xaaff6666),
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "PERC: ${(present + absent) == 0 ? 0 : (present / (present + absent) * 100).round()}%",
                        style: const TextStyle(
                            color: Colors.white60, fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                "MARKED ATTENDANCE",
                style: TextStyle(color: Colors.white38, fontSize: 12),
              ),
              ..._serverData.map((e) => AttendanceCard(attendance: e))
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
