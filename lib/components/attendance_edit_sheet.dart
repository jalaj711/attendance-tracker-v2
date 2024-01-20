import 'package:attendance_tracker/database/database.dart';
import 'package:attendance_tracker/models/attendance_type.dart';
import 'package:dart_date/dart_date.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditAttendanceSheet extends ConsumerStatefulWidget {
  const EditAttendanceSheet({super.key, required this.attendance});
  final Attendance attendance;
  @override
  ConsumerState<EditAttendanceSheet> createState() =>
      _EditAttendanceSheetState();
}

class _EditAttendanceSheetState extends ConsumerState<EditAttendanceSheet> {
  bool _isPresent = false;
  DateTime _timestamp = DateTime.now();
  late TextEditingController _descriptionController;
  String _subject = "Loading...";

  @override
  void initState() {
    super.initState();
    _isPresent = widget.attendance.present;
    _timestamp = widget.attendance.timestamp;
    _descriptionController =
        TextEditingController(text: widget.attendance.description);
    ref
        .read(AppDatabase.provider)
        .getSubjectById(widget.attendance.subject_id)
        .then((value) {
      if (mounted) {
        setState(() {
          _subject = value.title;
        });
      }
    });
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  void saveAttendance() {
    ref
        .read(AppDatabase.provider)
        .updateAttendance(
            widget.attendance.id,
            AttendanceCompanion(
                present: drift.Value(_isPresent),
                timestamp: drift.Value(_timestamp),
                description: drift.Value(_descriptionController.text)))
        .then((_) {
      Navigator.pop(context);
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
                  "Edit Attendance",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Subject Name:",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(_subject,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.merge(const TextStyle(color: Colors.white54)))
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Dated:",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    TextButton(
                        onPressed: () async {
                          var newDate = await showDatePicker(
                              context: context,
                              firstDate: DateTime(
                                  widget.attendance.timestamp.year - 1),
                              lastDate: DateTime.now(),
                              initialDate: _timestamp);
                          if (newDate != null) {
                            setState(() {
                              _timestamp = newDate;
                            });
                          }
                        },
                        child: Text(
                          _timestamp.format("dd MMM yyyy").toUpperCase(),
                          style: Theme.of(context).textTheme.bodyLarge?.merge(
                              TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.primary)),
                        ))
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Present Status:",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Switch(
                        value: _isPresent,
                        onChanged: (nVal) {
                          setState(() {
                            _isPresent = nVal;
                          });
                        })
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                TextField(
                  controller: _descriptionController,
                  minLines: 3,
                  maxLines: 4,
                  decoration: const InputDecoration(
                      labelText: 'Remarks',
                      hintText: 'Remarks for the attendance',
                      border: OutlineInputBorder()),
                ),
                const SizedBox(
                  height: 16,
                ),
                FilledButton(
                  onPressed: saveAttendance,
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
