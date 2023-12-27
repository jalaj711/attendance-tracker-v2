import 'package:attendance_tracker/components/add_subject_fab.dart';
import 'package:attendance_tracker/components/bottom_app_bar.dart';
import 'package:attendance_tracker/models/calendar_screen_arguments.dart';
import 'package:flutter/material.dart';
import 'package:dart_date/dart_date.dart';

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

    var calendar =
        List<List<DateTime>>.generate((numDays / 7).round(), (index) => []);

    for (var i = 0; i < numDays; i++) {
      calendar[(i / 7).floor()].add(initialDate.addDays(i));
    }

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
                              .map((date) => TextButton(
                                  onPressed:
                                      date.month == _month ? () {} : null,
                                  child: Text(
                                    date.format('dd'),
                                    style: TextStyle(
                                        color: date.month == _month
                                            ? Colors.white60
                                            : Colors.white24),
                                  )))
                              .toList()))
                      .toList()
                ],
              )
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
