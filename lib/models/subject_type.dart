class SubjectAtCreation {
  const SubjectAtCreation(
      {required this.title,
      required this.target,
      required this.attended,
      required this.total_classes});
  final String title;
  final int target;
  final int attended;
  final int total_classes;
}

class Subject extends SubjectAtCreation {
  const Subject(
      {required title,
      required target,
      required attended,
      required total_classes,
      required this.id})
      : super(
            title: title,
            attended: attended,
            total_classes: total_classes,
            target: target);

  final int id;
}
