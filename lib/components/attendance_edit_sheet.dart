import 'package:attendance_tracker/models/app_state.dart';
import 'package:attendance_tracker/models/attendance_type.dart';
import 'package:dart_date/dart_date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class EditAttendanceSheet extends StatefulWidget {
  const EditAttendanceSheet({super.key, required this.attendance});
  final Attendance attendance;
  @override
  State<EditAttendanceSheet> createState() => _EditAttendanceSheetState();
}

class _EditAttendanceSheetState extends State<EditAttendanceSheet> {
  bool _isPresent = false;
  DateTime _timestamp = DateTime.now();

  @override
  void initState() {
    super.initState();
    _isPresent = widget.attendance.present;
    _timestamp = widget.attendance.timestamp;
  }

  VoidCallback saveAttendance(Function(Attendance) creator) {
    return () {};
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
                    StoreConnector<AppState, String>(
                        builder: (cont, subject) => Text(subject.toUpperCase(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.merge(
                                    const TextStyle(color: Colors.white54))),
                        converter: (store) {
                          var subject = "SUBJ NOT FOUND";
                          for (var i = 0;
                              i < store.state.subjects.length;
                              i++) {
                            if (widget.attendance.subject_id ==
                                store.state.subjects[i].id) {
                              subject = store.state.subjects[i].title;
                              break;
                            }
                          }
                          return subject;
                        })
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
                FilledButton(
                  onPressed: () {},
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
