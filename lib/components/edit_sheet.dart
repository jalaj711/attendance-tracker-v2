import 'package:attendance_tracker/database/database.dart';
import 'package:attendance_tracker/models/subject_type.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditSubjectSheet extends ConsumerStatefulWidget {
  const EditSubjectSheet({super.key, required this.subject});
  final Subject subject;
  @override
  ConsumerState<EditSubjectSheet> createState() => _EditSubjectSheetState();
}

class _EditSubjectSheetState extends ConsumerState<EditSubjectSheet> {
  double targetAttendanceValue = 75;
  late TextEditingController _subjectNameController;

  @override
  void initState() {
    super.initState();
    _subjectNameController = TextEditingController(text: widget.subject.title);
    targetAttendanceValue = widget.subject.target.toDouble();
  }

  @override
  void dispose() {
    _subjectNameController.dispose();
    super.dispose();
  }

  void saveSubject() {
    String name = _subjectNameController.text;

    if (name == "") {
      final SnackBar snackBar = SnackBar(
        content: const Text("Subject name cannot be empty"),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'Okay',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }
    Navigator.pop(context);
    ref
        .read(AppDatabase.provider)
        .updateSubject(
            widget.subject.id,
            SubjectEntriesCompanion(
                title: drift.Value(name),
                target: drift.Value(targetAttendanceValue.round())))
        .onError((error, stackTrace) {
      final SnackBar snackBar = SnackBar(
        content: Text("Error while updating: ${error.toString()}"),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'Okay',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return -1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: const EdgeInsets.fromLTRB(12, 16, 16, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  "Edit a Subject",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextField(
                  controller: _subjectNameController,
                  decoration: const InputDecoration(
                      labelText: 'Subject Name',
                      hintText: 'Enter the name of the subject',
                      border: OutlineInputBorder()),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  "Set target attendance",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Slider(
                  value: targetAttendanceValue,
                  max: 100,
                  divisions: 100,
                  label: targetAttendanceValue.round().toString(),
                  onChanged: (double value) {
                    setState(() {
                      targetAttendanceValue = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                FilledButton(
                  onPressed: saveSubject,
                  child: const Padding(
                    padding: EdgeInsets.only(
                      top: 8,
                      bottom: 8,
                    ),
                    child: Text("Save"),
                  ),
                )
              ],
            )));
  }
}
