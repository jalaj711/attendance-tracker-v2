import 'package:attendance_tracker/types/subject_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddSubjectSheet extends StatefulWidget {
  const AddSubjectSheet({super.key});
  @override
  State<AddSubjectSheet> createState() => _AddSubjectSheetState();
}

class _AddSubjectSheetState extends State<AddSubjectSheet> {
  double targetAttendanceValue = 75;
  late TextEditingController _subjectNameController;
  late TextEditingController _classesAttededController;
  late TextEditingController _totalClassesController;

  @override
  void initState() {
    super.initState();
    _subjectNameController = TextEditingController();
    _classesAttededController = TextEditingController();
    _totalClassesController = TextEditingController();
  }

  @override
  void dispose() {
    _subjectNameController.dispose();
    super.dispose();
  }

  void createSubject() {
    int attended = 0;
    int total = 0;
    if (_classesAttededController.text != "") {
      attended = int.parse(_classesAttededController.text);
    }
    if (_totalClassesController.text != "") {
      total = int.parse(_totalClassesController.text);
    }

    String name = _subjectNameController.text;
    String error = "";
    if (name == "") error = "Subject name cannot be empty";

    if (attended > total) {
      error = 'Classes Attended cannot be larger than Total Classes';
    }

    if (error != "") {
      final SnackBar snackBar = SnackBar(
        content: Text(error),
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

    // invoke some create subject method
    SubjectAtCreation(
        title: name,
        target: targetAttendanceValue.round(),
        attended: attended,
        total_classes: total);
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
                  "Add a Subject",
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
                  height: 12,
                ),
                TextField(
                  controller: _classesAttededController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                    labelText: 'Classes Attended',
                    hintText: 'Enter the number of classes attended',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                TextField(
                  controller: _totalClassesController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                      labelText: 'Total Classes',
                      hintText: 'Enter the total number of classes',
                      border: OutlineInputBorder()),
                ),
                const SizedBox(
                  height: 12,
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
                  onPressed: createSubject,
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
