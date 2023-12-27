class AttendanceAtCreation {
  final int subject_id;
  final bool present;
  final DateTime timestamp;

  AttendanceAtCreation(
      {required this.present,
      required this.subject_id,
      required this.timestamp});
}

class Attendance extends AttendanceAtCreation {
  final int id;

  Attendance(
      {required this.id,
      required bool present,
      required int subject_id,
      required DateTime timestamp})
      : super(present: present, subject_id: subject_id, timestamp: timestamp);

  dynamic toJson() => {
        'id': id,
        'subject_id': subject_id,
        'present': present,
        'timestamp': timestamp.toIso8601String()
      };
  static Attendance fromJson(dynamic json) => Attendance(
      id: json['id'],
      present: json['present'],
      subject_id: json['subject_id'],
      timestamp: DateTime.parse(json['timestamp']));
}
