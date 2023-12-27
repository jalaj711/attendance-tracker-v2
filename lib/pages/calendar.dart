import 'package:attendance_tracker/components/add_subject_fab.dart';
import 'package:attendance_tracker/components/bottom_app_bar.dart';
import 'package:attendance_tracker/models/calendar_screen_arguments.dart';
import 'package:flutter/material.dart';

class SubjectCalendarScreen extends StatelessWidget {
  const SubjectCalendarScreen({super.key});

  static const routeName = '/calendar';

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as CalendarScreenArguments;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 48, 12, 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Subject Calendar',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Text(
                'Subject: ${args.subjectID}',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.merge(const TextStyle(color: Color(0xffaaaaaa))),
              ),
              
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