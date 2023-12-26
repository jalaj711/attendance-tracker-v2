import 'package:attendance_tracker/actions/subject_actions.dart';
import 'package:attendance_tracker/models/subject_type.dart';
import 'package:redux/redux.dart';

final subjectsReducer = combineReducers<List<Subject>>([
  TypedReducer<List<Subject>, AddSubjectAction>(_addSubject),
  TypedReducer<List<Subject>, EditSubjectAction>(_editSubject),
]);

List<Subject> _addSubject(List<Subject> subjects, AddSubjectAction action) {
  return List.from(subjects)..add(action.subject);
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
