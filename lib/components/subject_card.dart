import 'package:attendance_tracker/actions/subject_actions.dart';
import 'package:attendance_tracker/components/edit_sheet.dart';
import 'package:attendance_tracker/models/app_state.dart';
import 'package:attendance_tracker/models/subject_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class SubjectCard extends StatefulWidget {
  const SubjectCard({super.key, required this.subject});
  final Subject subject;
  @override
  State<SubjectCard> createState() => _SubjectCardState();
}

class _SubjectCardState extends State<SubjectCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
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
                              onPressed: () {},
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
                                  style: Theme.of(context).textTheme.bodyLarge,
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
                              child:
                                  StoreConnector<AppState, Function(Subject)>(
                                      builder: (context, markAttendance) {
                                        return IconButton.filledTonal(
                                            onPressed: () =>
                                                markAttendance(widget.subject),
                                            icon: const Icon(
                                              Icons.remove,
                                              size: 14,
                                            ));
                                      },
                                      converter: (store) => (Subject subject) =>
                                          store.dispatch(MarkAttendanceAction(
                                              subject, false))),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
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
                              child: StoreConnector<AppState,
                                      Function(Subject)>(
                                  builder: (context, markAttendance) {
                                    return IconButton.filled(
                                        onPressed: () =>
                                            markAttendance(widget.subject),
                                        icon: const Icon(
                                          Icons.add,
                                          size: 14,
                                        ));
                                  },
                                  converter: (store) => (Subject subject) =>
                                      store.dispatch(
                                          MarkAttendanceAction(subject, true))),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                )
              ],
            )));
  }
}
