import 'package:attendance_tracker/components/delete_confirm.dart';
import 'package:attendance_tracker/models/app_state.dart';
import 'package:attendance_tracker/models/attendance_type.dart';
import 'package:dart_date/dart_date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class AttendanceCard extends StatefulWidget {
  const AttendanceCard({super.key, required this.attendance});
  final Attendance attendance;
  @override
  State<AttendanceCard> createState() => _AttendanceCardState();
}

class _AttendanceCardState extends State<AttendanceCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
        color: Theme.of(context).cardColor,
        elevation: 2,
        margin: const EdgeInsets.only(top: 12, bottom: 8),
        child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.attendance.timestamp
                          .format('dd MMM, HH:mm')
                          .toUpperCase(),
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.merge(const TextStyle(color: Colors.white70)),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: 30,
                          width: 30,
                          child: IconButton(
                              onPressed: () {},
                              color: Colors.grey,
                              icon: const Icon(
                                Icons.edit_outlined,
                                size: 12,
                              )),
                        ),
                        SizedBox(
                          height: 30,
                          width: 30,
                          child: IconButton(
                              onPressed: () {
                                showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        DeleteConfirmDialog(
                                          message:
                                              "Are you sure you want to delete the attendance ${widget.attendance..timestamp.format('dd MMM, HH:mm')}?",
                                          onDelete: () {},
                                        ));
                              },
                              color: Colors.grey,
                              icon: const Icon(
                                Icons.delete_outline_rounded,
                                size: 12,
                              )),
                        ),
                      ],
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    StoreConnector<AppState, String>(
                        builder: (cont, subject) => Text(subject.toUpperCase(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.merge(const TextStyle(color: Colors.white54))),
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
                        }),
                    Text(
                      widget.attendance.present ? "PRESENT" : "ABSENT",
                      style: Theme.of(context).textTheme.bodyLarge?.merge(
                          TextStyle(
                              color: Color(widget.attendance.present
                                  ? 0xaa66ff66
                                  : 0xaaff6666),
                              fontWeight: FontWeight.w600)),
                    )
                  ],
                )
              ],
            )));
  }
}
