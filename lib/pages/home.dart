import 'package:attendance_tracker/components/add_subject_fab.dart';
import 'package:attendance_tracker/components/bottom_app_bar.dart';
import 'package:attendance_tracker/components/subject_card.dart';
import 'package:attendance_tracker/models/app_state.dart';
import 'package:attendance_tracker/models/subject_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 48, 12, 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Attendance Tracker',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Text(
                'Easily track your attendance with cloud backup',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.merge(const TextStyle(color: Color(0xffaaaaaa))),
              ),
              StoreConnector<AppState, List<Subject>>(
                  builder: (context, subjects) {
                    return Container(
                        margin: const EdgeInsets.only(top: 48),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: subjects
                                .map((subject) => SubjectCard(subject: subject))
                                .toList()));
                  },
                  converter: (store) => store.state.subjects)
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
