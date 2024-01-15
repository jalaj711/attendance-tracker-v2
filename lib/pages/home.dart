import 'package:attendance_tracker/components/add_subject_fab.dart';
import 'package:attendance_tracker/components/bottom_app_bar.dart';
import 'package:attendance_tracker/components/subject_card.dart';
import 'package:attendance_tracker/database/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final allSubjects = StreamProvider((ref) {
  final database = ref.watch(AppDatabase.provider);

  return database.getAllSubjects();
});

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  static const routeName = '/';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subjects = ref.watch(allSubjects);

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
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: subjects.when(
                          data: (entries) {
                            return entries
                                .map((subject) => SubjectCard(subject: subject))
                                .toList();
                          },
                          error: (e, s) {
                            debugPrintStack(label: e.toString(), stackTrace: s);
                            return [const Text('An error has occured')];
                          },
                          loading: () => [
                                const Align(
                                  alignment: Alignment.center,
                                  child: CircularProgressIndicator(),
                                )
                              ])))
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
