import 'package:attendance_tracker/models/subject_type.dart';
import 'package:flutter/material.dart';

class EditSubjectSheet extends StatefulWidget {
  const EditSubjectSheet({super.key, required this.subject});
  final Subject subject;
  @override
  State<EditSubjectSheet> createState() => _EditSubjectSheetState();
}

class _EditSubjectSheetState extends State<EditSubjectSheet> {
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

    // invoke some edit subject method
    
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
