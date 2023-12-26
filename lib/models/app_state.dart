
import 'package:attendance_tracker/models/subject_type.dart';

class AppState {
  final bool isLoading;
  final List<Subject> subjects;

  AppState(
      {this.isLoading = false,
      this.subjects = const [],});

  factory AppState.loading() => AppState(isLoading: true);

  @override
  String toString() {
    return 'AppState{isLoading: $isLoading, subjects: $subjects';
  }
}