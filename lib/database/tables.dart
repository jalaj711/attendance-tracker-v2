
import 'package:drift/drift.dart';

@DataClassName('SubjectEntry')
class SubjectEntries extends Table with AutoIncrementingPrimaryKey {
  TextColumn get title => text()();
  IntColumn get target => integer()();
  IntColumn get attended => integer()();
  IntColumn get totalClasses => integer()();

}

@DataClassName('AttendanceEntry')
class Attendance extends Table with AutoIncrementingPrimaryKey {
  TextColumn get description => text().nullable()();
  BoolColumn get present => boolean()();
  IntColumn get subject => integer().references(SubjectEntries, #id)();
  DateTimeColumn get timestamp => dateTime()();
}

// Tables can mix-in common definitions if needed
mixin AutoIncrementingPrimaryKey on Table {
  IntColumn get id => integer().autoIncrement()();
}
