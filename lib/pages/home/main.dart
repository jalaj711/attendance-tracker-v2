import 'package:attendance_tracker/components/add_sheet.dart';
import 'package:attendance_tracker/components/subject_card.dart';
import 'package:attendance_tracker/models/app_state.dart';
import 'package:attendance_tracker/models/subject_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).cardColor,
        elevation: 5,
        child: Row(
          children: <Widget>[
            IconButton(
              tooltip: 'Show Subjects',
              icon: const Icon(Icons.folder_open_rounded),
              onPressed: () {
                final SnackBar snackBar = SnackBar(
                  content: const Text('Yay! A SnackBar!'),
                  action: SnackBarAction(
                    label: 'Undo',
                    onPressed: () {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    },
                  ),
                );

                // Find the ScaffoldMessenger in the widget tree
                // and use it to show a SnackBar.
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
            ),
            IconButton(
              tooltip: 'Attendance History',
              icon: const Icon(Icons.history_rounded),
              onPressed: () {},
            ),
            IconButton(
              tooltip: 'Calendar',
              icon: const Icon(Icons.calendar_month_rounded),
              onPressed: () {},
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext cont) {
                return const AddSubjectSheet();
              });
        },
        tooltip: 'Add New Subject',
        elevation: 0,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
    );
  }
}
