import 'package:attendance_tracker/models/subject_type.dart';

class AppState {
  final bool isLoading;
  final List<Subject> subjects;

  AppState({
    this.isLoading = false,
    this.subjects = const [],
  });

  factory AppState.loading() => AppState(isLoading: true);

  static AppState fromJson(dynamic json) {
    if (json == null) {
      return AppState();
    }
    return AppState(
        isLoading: json["isLoading"] as bool,
        subjects: (json["subjects"] as List)
            .map((e) => Subject.fromJson(e))
            .toList());
  }

  dynamic toJson() => {
        'isLoading': isLoading,
        'subjects': subjects.map((e) => e.toJson()).toList(),
      };

  @override
  String toString() {
    return 'AppState{isLoading: $isLoading, subjects: $subjects';
  }
}
