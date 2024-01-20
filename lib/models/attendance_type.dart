class AttendanceAtCreation {
  final int subject_id;
  final bool present;
  final DateTime timestamp;
  final String description;

  AttendanceAtCreation(
      {required this.present,
      required this.subject_id,
      required this.timestamp,
      required this.description});
}

class Attendance extends AttendanceAtCreation {
  final int id;

  Attendance(
      {required this.id,
      required bool present,
      required int subject_id,
      required DateTime timestamp,
      required String description})
      : super(
            present: present,
            subject_id: subject_id,
            timestamp: timestamp,
            description: description);

  dynamic toJson() => {
        'id': id,
        'subject_id': subject_id,
        'present': present,
        'description': description,
        'timestamp': timestamp.toIso8601String()
      };
  static Attendance fromJson(dynamic json) => Attendance(
      id: json['id'],
      present: json['present'],
      subject_id: json['subject_id'],
      description: json['description'],
      timestamp: DateTime.parse(json['timestamp']));
}
