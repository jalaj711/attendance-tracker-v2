import 'package:attendance_tracker/actions/subject_actions.dart';
import 'package:attendance_tracker/models/subject_type.dart';
import 'package:redux/redux.dart';

final subjectsReducer = combineReducers<List<Subject>>([
  TypedReducer<List<Subject>, AddSubjectAction>(_addSubject),
  TypedReducer<List<Subject>, EditSubjectAction>(_editSubject),
  TypedReducer<List<Subject>, MarkAttendanceAction>(_markAtendance),
  TypedReducer<List<Subject>, DeleteSubjectAction>(_deleteSubject),
]);

int i = 0;

List<Subject> _addSubject(List<Subject> subjects, AddSubjectAction action) {
  return List.from(subjects)..add(Subject.fromSubjectAtCreation(action.subject, i++));
}

List<Subject> _editSubject(List<Subject> subjects, EditSubjectAction action) {
  List<Subject> initial = List.from(subjects);
  var index = -1;
  for (var i = 0; i < initial.length; i++) {
    if (initial[i].id == action.subject.id) {
      index = i;
      break;
    }
  }
  if (index > -1) {
    initial[index] = action.subject;
  }
  return initial;
}

List<Subject> _markAtendance(
    List<Subject> subjects, MarkAttendanceAction action) {
  List<Subject> initial = List.from(subjects);
  var index = -1;
  for (var i = 0; i < initial.length; i++) {
    if (initial[i].id == action.subject.id) {
      index = i;
      break;
    }
  }
  if (index > -1) {
    initial[index] = Subject(
        title: initial[index].title,
        target: initial[index].target,
        attended: initial[index].attended + (action.present ? 1 : 0),
        total_classes: initial[index].total_classes + 1,
        id: initial[index].id);
  }
  return initial;
}


List<Subject> _deleteSubject(List<Subject> subjects, DeleteSubjectAction action) {
  List<Subject> initial = List.from(subjects);
  initial.removeWhere((element) => element.id == action.id);
  return initial;
}
