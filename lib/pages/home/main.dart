import 'package:attendance_tracker/components/add_sheet.dart';
import 'package:attendance_tracker/components/subject_card.dart';
import 'package:attendance_tracker/models/subject_type.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
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
              Container(
                  margin: const EdgeInsets.only(top: 48),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SubjectCard(
                        subject: Subject(
                            title: "Subject 1",
                            target: 75,
                            id: 1,
                            attended: 17,
                            total_classes: 21),
                      ),
                      SubjectCard(
                        subject: Subject(
                            title: "Subject 2",
                            target: 75,
                            id: 2,
                            attended: 16,
                            total_classes: 20),
                      ),
                      SubjectCard(
                        subject: Subject(
                            title: "Subject 3",
                            target: 75,
                            id: 3,
                            attended: 10,
                            total_classes: 21),
                      ),
                      SubjectCard(
                        subject: Subject(
                            title: "Subject 4",
                            target: 75,
                            id: 4,
                            attended: 3,
                            total_classes: 4),
                      ),
                    ],
                  ))
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
          showModalBottomSheet(context: context, builder: (BuildContext cont) {
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
