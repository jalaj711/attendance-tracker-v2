import 'package:attendance_tracker/actions/subject_actions.dart';
import 'package:attendance_tracker/models/subject_type.dart';
import 'package:redux/redux.dart';

final subjectsReducer = combineReducers<List<Subject>>([
  TypedReducer<List<Subject>, AddSubjectAction>(_addSubject),
]);

List<Subject> _addSubject(List<Subject> subjects, AddSubjectAction action) {
  return List.from(subjects)..add(action.subject);
}