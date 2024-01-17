import 'package:attendance_tracker/components/attendance_edit_sheet.dart';
import 'package:attendance_tracker/components/delete_confirm.dart';
import 'package:attendance_tracker/database/database.dart';
import 'package:attendance_tracker/models/attendance_type.dart';
import 'package:dart_date/dart_date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AttendanceCard extends ConsumerStatefulWidget {
  const AttendanceCard({super.key, required this.attendance});
  final Attendance attendance;
  @override
  ConsumerState<AttendanceCard> createState() => _AttendanceCardState();
}

class _AttendanceCardState extends ConsumerState<AttendanceCard> {
  String _subject = "Loading...";

  @override
  void initState() {
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
    super.initState();
  }

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
                          .format('dd MMM yyyy')
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
                              onPressed: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext cont) {
                                      return EditAttendanceSheet(
                                        attendance: widget.attendance,
                                      );
                                    });
                              },
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
                                              "Are you sure you want to delete the attendance ${widget.attendance.timestamp.format('dd MMM, HH:mm')}?",
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
                    Text(_subject.toUpperCase(),
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.merge(const TextStyle(color: Colors.white54))),
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
