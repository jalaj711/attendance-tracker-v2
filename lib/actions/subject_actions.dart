import 'package:attendance_tracker/models/subject_type.dart';

class AddSubjectAction {
  final Subject subject;

  AddSubjectAction(this.subject);

  @override
  String toString() {
    return 'AddSubjectAction{subject: $subject}';
  }
}
