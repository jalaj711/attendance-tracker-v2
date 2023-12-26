import 'package:attendance_tracker/models/app_state.dart';
import 'package:attendance_tracker/reducers/subjects_reducer.dart';

AppState appReducer(AppState state, action) {
  return AppState(
    subjects: subjectsReducer(state.subjects, action)
  );
}