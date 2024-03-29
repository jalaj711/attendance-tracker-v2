import 'package:attendance_tracker/models/subject_type.dart';
import 'package:attendance_tracker/models/attendance_type.dart' as models;
import 'package:drift/drift.dart';
import 'package:riverpod/riverpod.dart';

import 'connection/connection.dart' as impl;
import 'tables.dart';
// Manually generated by `drift_dev schema steps` - this file makes writing
// migrations easier. See this for details:
// https://drift.simonbinder.eu/docs/advanced-features/migrations/#step-by-step
// import 'schema_versions.dart';

// Generated by drift_dev when running `build_runner build`
part 'database.g.dart';

@DriftDatabase(tables: [SubjectEntries, Attendance])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(impl.connect());

  AppDatabase.forTesting(DatabaseConnection connection) : super(connection);

  @override
  int get schemaVersion => 1;

  // @override
  // MigrationStrategy get migration {
  //   return MigrationStrategy(
  //     onUpgrade: stepByStep(),
  //     beforeOpen: (details) async {
  //       // Make sure that foreign keys are enabled
  //       await customStatement('PRAGMA foreign_keys = ON');

  //       if (details.wasCreated) {
  //         // Create a bunch of default values so the app doesn't look too empty
  //         // on the first start.
  //         // await batch((b) {

  //         // });
  //       }

  //       // This follows the recommendation to validate that the database schema
  //       // matches what drift expects (https://drift.simonbinder.eu/docs/advanced-features/migrations/#verifying-a-database-schema-at-runtime).
  //       // It allows catching bugs in the migration logic early.
  //       await impl.validateDatabaseSchema(this);
  //     },
  //   );
  // }
  static final StateProvider<AppDatabase> provider = StateProvider((ref) {
    final database = AppDatabase();
    ref.onDispose(database.close);

    return database;
  });

  Stream<List<Subject>> getAllSubjects() {
    final query = select(subjectEntries);

    return query.map((row) {
      return Subject(
          title: row.title,
          target: row.target,
          attended: row.attended,
          total_classes: row.totalClasses,
          id: row.id);
    }).watch();
  }

  Future<List<models.Attendance>> getAllAttendances() {
    final query = select(attendance).get();

    return query.then((results) {
      return List.generate(
          results.length,
          (index) => models.Attendance(
              id: results[index].id,
              subject_id: results[index].subject,
              present: results[index].present,
              timestamp: results[index].timestamp,
              description: results[index].description ?? ""));
    });
  }

  Future<List<models.Attendance>> getAllAttendancesBySubject(int subject) {
    final query =
        (select(attendance)..where((tbl) => tbl.subject.equals(subject))).get();

    return query.then((results) {
      return List.generate(
          results.length,
          (index) => models.Attendance(
              id: results[index].id,
              subject_id: results[index].subject,
              present: results[index].present,
              timestamp: results[index].timestamp,
              description: results[index].description ?? ""));
    });
  }

  Future<Subject> getSubjectById(int id) {
    final query = (select(subjectEntries)..where((tbl) => tbl.id.equals(id)));
    return query.getSingle().then((result) {
      return Subject(
          title: result.title,
          target: result.target,
          attended: result.attended,
          total_classes: result.totalClasses,
          id: id);
    });
  }

  Stream<List<models.Attendance>> getAttendancesOnDates(
      int year, int month, int? date) {
    final query = (select(attendance)
      ..where((tbl) {
        final sameYear = tbl.timestamp.year.equals(year);
        final sameMonth = tbl.timestamp.month.equals(month);
        if (date != null) {
          final sameDay = tbl.timestamp.day.equals(date);
          return sameDay & sameMonth & sameYear;
        }
        return sameMonth & sameYear;
      }));
    return query
        .map((e) => models.Attendance(
            id: e.id,
            present: e.present,
            subject_id: e.subject,
            timestamp: e.timestamp,
            description: e.description ?? ""))
        .watch();
  }

  Stream<List<models.Attendance>> getAttendancesOnDatesWithSubject(
      int subject, int year, int month, int? date) {
    final query = (select(attendance)
      ..where((tbl) {
        final sameSubj = tbl.subject.equals(subject);
        final sameYear = tbl.timestamp.year.equals(year);
        final sameMonth = tbl.timestamp.month.equals(month);
        if (date != null) {
          final sameDay = tbl.timestamp.day.equals(date);
          return sameDay & sameMonth & sameYear & sameSubj;
        }
        return sameMonth & sameYear & sameSubj;
      }));
    return query
        .map((e) => models.Attendance(
            id: e.id,
            present: e.present,
            subject_id: e.subject,
            timestamp: e.timestamp,
            description: e.description ?? ""))
        .watch();
  }

  Future<int> markAttendance(int subject, bool present) {
    final query =
        (select(subjectEntries)..where((tbl) => tbl.id.equals(subject)));
    return query.getSingle().then((subj) {
      return (update(subjectEntries)..where((tbl) => tbl.id.equals(subject)))
          .write(SubjectEntriesCompanion(
              attended: Value(subj.attended + (present ? 1 : 0)),
              totalClasses: Value(subj.totalClasses + 1)));
    }).then((_) {
      return into(attendance).insert(AttendanceCompanion.insert(
          present: present,
          subject: subject,
          timestamp: DateTime.now(),
          description: const Value("")));
    });
  }

  Future<void> createNewSubject(SubjectAtCreation subject) {
    return transaction(() async {
      await into(subjectEntries)
          .insert(SubjectEntriesCompanion.insert(
              title: subject.title,
              target: subject.target.round(),
              attended: subject.attended,
              totalClasses: subject.total_classes))
          .then((id) async {
        List<AttendanceCompanion> queries = [];
        if (subject.attended > 0) {
          for (var i = 0; i < subject.attended; i++) {
            queries.add(AttendanceCompanion.insert(
                present: true,
                subject: id,
                timestamp: DateTime.now(),
                description:
                    const Value("[System Generated] Initial Attendance")));
          }
        }

        if (subject.total_classes > subject.attended) {
          for (var i = 0; i < subject.total_classes - subject.attended; i++) {
            queries.add(AttendanceCompanion.insert(
                present: false,
                subject: id,
                timestamp: DateTime.now(),
                description:
                    const Value("[System Generated] Initial Attendance")));
          }
        }

        await batch((batch) {
          batch.insertAll(attendance, queries);
        });
      });
    });
  }

  Future<int> updateSubject(int id, SubjectEntriesCompanion newSubject) {
    return (update(subjectEntries)..where((tbl) => tbl.id.equals(id)))
        .write(newSubject);
  }

  Future<int?> deleteSubject(int id) {
    return (delete(attendance)..where((tbl) => tbl.subject.equals(id)))
        .go()
        .then((value) {
      return (delete(subjectEntries)..where((tbl) => tbl.id.equals(id))).go();
    });
  }

  Future<int?> deleteAttendance(int id) {
    return (select(attendance)..where((tbl) => tbl.id.equals(id)))
        .getSingle()
        .then((att) {
      return (select(subjectEntries)
            ..where((tbl) => tbl.id.equals(att.subject)))
          .getSingle()
          .then((subject) {
        return (update(subjectEntries)
              ..where((tbl) => tbl.id.equals(subject.id)))
            .write(SubjectEntriesCompanion(
                totalClasses: Value(subject.totalClasses - 1),
                attended: Value(
                    att.present ? subject.attended - 1 : subject.attended)))
            .then((_) {
          return (delete(attendance)..where((tbl) => tbl.id.equals(id))).go();
        });
      });
    });
  }

  Future<int?> updateAttendance(int id, AttendanceCompanion companion) {
    return (select(attendance)..where((tbl) => tbl.id.equals(id)))
        .getSingle()
        .then((att) {
      return (select(subjectEntries)
            ..where((tbl) => tbl.id.equals(att.subject)))
          .getSingle()
          .then((subject) {
        return (update(subjectEntries)
              ..where((tbl) => tbl.id.equals(subject.id)))
            .write(SubjectEntriesCompanion(
                attended: Value(
                    (att.present ? subject.attended - 1 : subject.attended) +
                        (companion.present.present ? 1 : 0))))
            .then((_) {
          return (update(attendance)..where((tbl) => tbl.id.equals(id)))
              .write(companion);
        });
      });
    });
  }
}
