import 'package:attendance_tracker/components/delete_confirm.dart';
import 'package:attendance_tracker/components/edit_sheet.dart';
import 'package:attendance_tracker/database/database.dart';
import 'package:attendance_tracker/models/calendar_screen_arguments.dart';
import 'package:attendance_tracker/models/subject_type.dart';
import 'package:attendance_tracker/pages/calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SubjectCard extends ConsumerStatefulWidget {
  const SubjectCard({super.key, required this.subject});
  final Subject subject;
  @override
  ConsumerState<SubjectCard> createState() => _SubjectCardState();
}

class _SubjectCardState extends ConsumerState<SubjectCard> {
  void markAttendance(bool present) {
    ref
        .read(AppDatabase.provider)
        .markAttendance(widget.subject.id, present)
        .then((value) {})
        .onError((error, stackTrace) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Error: ${error.toString()}"),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'Okay',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          SubjectCalendarScreen.routeName,
          arguments: CalendarScreenArguments(widget.subject.id),
        );
      },
      child: Card(
          color: Theme.of(context).cardColor,
          elevation: 2,
          margin: const EdgeInsets.only(top: 12, bottom: 8),
          child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 16, 12),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.subject.title,
                        style: Theme.of(context).textTheme.headlineSmall,
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
                                        return EditSubjectSheet(
                                          subject: widget.subject,
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
                                          "Are you sure you want to delete the subject ${widget.subject.title}?",
                                      onDelete: () {
                                        ref
                                            .read(AppDatabase.provider)
                                            .deleteSubject(widget.subject.id)
                                            .onError((error, stackTrace) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text(
                                                "Error: ${error.toString()}"),
                                            behavior: SnackBarBehavior.floating,
                                            action: SnackBarAction(
                                              label: 'Okay',
                                              onPressed: () {
                                                ScaffoldMessenger.of(context)
                                                    .hideCurrentSnackBar();
                                              },
                                            ),
                                          ));
                                          return null;
                                        });
                                      },
                                    ),
                                  );
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(top: 8),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Target Level: ${widget.subject.target}%",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.merge(const TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w200)),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Status: ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.merge(const TextStyle(
                                              color: Colors.grey,
                                            )),
                                      ),
                                      (() {
                                        String text = "DANGER";
                                        Color color = const Color(0xaaff6666);
                                        if (widget.subject.attended /
                                                (widget.subject.total_classes +
                                                    1) *
                                                100 >=
                                            widget.subject.target) {
                                          text = "SAFE";
                                          color = const Color(0xaa66ff66);
                                        } else if (widget.subject.attended /
                                                widget.subject.total_classes *
                                                100 >=
                                            widget.subject.target) {
                                          text = "WARNING";
                                          color = const Color(0xaaffff66);
                                        } else {
                                          text +=
                                              " [NEED: ${((widget.subject.total_classes * widget.subject.target - 100 * widget.subject.attended) / (100 - widget.subject.target)).round()}]";
                                        }

                                        return Text(
                                          text,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.merge(TextStyle(
                                                  color: color,
                                                  fontWeight: FontWeight.w600)),
                                        );
                                      }()),
                                    ],
                                  )
                                ]),
                          ),
                          Container(
                              margin: const EdgeInsets.only(top: 8),
                              child: Row(
                                children: [
                                  Container(
                                      height: 4,
                                      width: 120,
                                      margin: const EdgeInsets.only(right: 8),
                                      child: LinearProgressIndicator(
                                        value: widget.subject.attended /
                                            widget.subject.total_classes,
                                      )),
                                  Text(
                                    "${widget.subject.attended}",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  Text(
                                    " of ${widget.subject.total_classes}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.merge(const TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w200)),
                                  ),
                                ],
                              )),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                height: 30,
                                width: 30,
                                child: IconButton.filledTonal(
                                    onPressed: () => markAttendance(false),
                                    icon: const Icon(
                                      Icons.remove,
                                      size: 14,
                                    )),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(16, 0, 16, 0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "${(widget.subject.attended / widget.subject.total_classes * 100).floor()}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall,
                                    ),
                                    Text(
                                      ".${(((widget.subject.attended / widget.subject.total_classes * 100) % 1) * 100).round()}%",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.merge(const TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w200)),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 30,
                                width: 30,
                                child: IconButton.filled(
                                    onPressed: () => markAttendance(true),
                                    icon: const Icon(
                                      Icons.add,
                                      size: 14,
                                    )),
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ))),
    );
  }
}
