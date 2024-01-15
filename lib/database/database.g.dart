// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $SubjectEntriesTable extends SubjectEntries
    with TableInfo<$SubjectEntriesTable, SubjectEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SubjectEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _targetMeta = const VerificationMeta('target');
  @override
  late final GeneratedColumn<int> target = GeneratedColumn<int>(
      'target', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _attendedMeta =
      const VerificationMeta('attended');
  @override
  late final GeneratedColumn<int> attended = GeneratedColumn<int>(
      'attended', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _totalClassesMeta =
      const VerificationMeta('totalClasses');
  @override
  late final GeneratedColumn<int> totalClasses = GeneratedColumn<int>(
      'total_classes', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, target, attended, totalClasses];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'subject_entries';
  @override
  VerificationContext validateIntegrity(Insertable<SubjectEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('target')) {
      context.handle(_targetMeta,
          target.isAcceptableOrUnknown(data['target']!, _targetMeta));
    } else if (isInserting) {
      context.missing(_targetMeta);
    }
    if (data.containsKey('attended')) {
      context.handle(_attendedMeta,
          attended.isAcceptableOrUnknown(data['attended']!, _attendedMeta));
    } else if (isInserting) {
      context.missing(_attendedMeta);
    }
    if (data.containsKey('total_classes')) {
      context.handle(
          _totalClassesMeta,
          totalClasses.isAcceptableOrUnknown(
              data['total_classes']!, _totalClassesMeta));
    } else if (isInserting) {
      context.missing(_totalClassesMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SubjectEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SubjectEntry(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      target: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}target'])!,
      attended: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}attended'])!,
      totalClasses: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}total_classes'])!,
    );
  }

  @override
  $SubjectEntriesTable createAlias(String alias) {
    return $SubjectEntriesTable(attachedDatabase, alias);
  }
}

class SubjectEntry extends DataClass implements Insertable<SubjectEntry> {
  final int id;
  final String title;
  final int target;
  final int attended;
  final int totalClasses;
  const SubjectEntry(
      {required this.id,
      required this.title,
      required this.target,
      required this.attended,
      required this.totalClasses});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['target'] = Variable<int>(target);
    map['attended'] = Variable<int>(attended);
    map['total_classes'] = Variable<int>(totalClasses);
    return map;
  }

  SubjectEntriesCompanion toCompanion(bool nullToAbsent) {
    return SubjectEntriesCompanion(
      id: Value(id),
      title: Value(title),
      target: Value(target),
      attended: Value(attended),
      totalClasses: Value(totalClasses),
    );
  }

  factory SubjectEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SubjectEntry(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      target: serializer.fromJson<int>(json['target']),
      attended: serializer.fromJson<int>(json['attended']),
      totalClasses: serializer.fromJson<int>(json['totalClasses']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'target': serializer.toJson<int>(target),
      'attended': serializer.toJson<int>(attended),
      'totalClasses': serializer.toJson<int>(totalClasses),
    };
  }

  SubjectEntry copyWith(
          {int? id,
          String? title,
          int? target,
          int? attended,
          int? totalClasses}) =>
      SubjectEntry(
        id: id ?? this.id,
        title: title ?? this.title,
        target: target ?? this.target,
        attended: attended ?? this.attended,
        totalClasses: totalClasses ?? this.totalClasses,
      );
  @override
  String toString() {
    return (StringBuffer('SubjectEntry(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('target: $target, ')
          ..write('attended: $attended, ')
          ..write('totalClasses: $totalClasses')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, target, attended, totalClasses);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SubjectEntry &&
          other.id == this.id &&
          other.title == this.title &&
          other.target == this.target &&
          other.attended == this.attended &&
          other.totalClasses == this.totalClasses);
}

class SubjectEntriesCompanion extends UpdateCompanion<SubjectEntry> {
  final Value<int> id;
  final Value<String> title;
  final Value<int> target;
  final Value<int> attended;
  final Value<int> totalClasses;
  const SubjectEntriesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.target = const Value.absent(),
    this.attended = const Value.absent(),
    this.totalClasses = const Value.absent(),
  });
  SubjectEntriesCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required int target,
    required int attended,
    required int totalClasses,
  })  : title = Value(title),
        target = Value(target),
        attended = Value(attended),
        totalClasses = Value(totalClasses);
  static Insertable<SubjectEntry> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<int>? target,
    Expression<int>? attended,
    Expression<int>? totalClasses,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (target != null) 'target': target,
      if (attended != null) 'attended': attended,
      if (totalClasses != null) 'total_classes': totalClasses,
    });
  }

  SubjectEntriesCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<int>? target,
      Value<int>? attended,
      Value<int>? totalClasses}) {
    return SubjectEntriesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      target: target ?? this.target,
      attended: attended ?? this.attended,
      totalClasses: totalClasses ?? this.totalClasses,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (target.present) {
      map['target'] = Variable<int>(target.value);
    }
    if (attended.present) {
      map['attended'] = Variable<int>(attended.value);
    }
    if (totalClasses.present) {
      map['total_classes'] = Variable<int>(totalClasses.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SubjectEntriesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('target: $target, ')
          ..write('attended: $attended, ')
          ..write('totalClasses: $totalClasses')
          ..write(')'))
        .toString();
  }
}

class $AttendanceTable extends Attendance
    with TableInfo<$AttendanceTable, AttendanceEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AttendanceTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _presentMeta =
      const VerificationMeta('present');
  @override
  late final GeneratedColumn<bool> present = GeneratedColumn<bool>(
      'present', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("present" IN (0, 1))'));
  static const VerificationMeta _subjectMeta =
      const VerificationMeta('subject');
  @override
  late final GeneratedColumn<int> subject = GeneratedColumn<int>(
      'subject', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES subject_entries (id)'));
  static const VerificationMeta _timestampMeta =
      const VerificationMeta('timestamp');
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
      'timestamp', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, description, present, subject, timestamp];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'attendance';
  @override
  VerificationContext validateIntegrity(Insertable<AttendanceEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('present')) {
      context.handle(_presentMeta,
          present.isAcceptableOrUnknown(data['present']!, _presentMeta));
    } else if (isInserting) {
      context.missing(_presentMeta);
    }
    if (data.containsKey('subject')) {
      context.handle(_subjectMeta,
          subject.isAcceptableOrUnknown(data['subject']!, _subjectMeta));
    } else if (isInserting) {
      context.missing(_subjectMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(_timestampMeta,
          timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta));
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AttendanceEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AttendanceEntry(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      present: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}present'])!,
      subject: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}subject'])!,
      timestamp: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}timestamp'])!,
    );
  }

  @override
  $AttendanceTable createAlias(String alias) {
    return $AttendanceTable(attachedDatabase, alias);
  }
}

class AttendanceEntry extends DataClass implements Insertable<AttendanceEntry> {
  final int id;
  final String? description;
  final bool present;
  final int subject;
  final DateTime timestamp;
  const AttendanceEntry(
      {required this.id,
      this.description,
      required this.present,
      required this.subject,
      required this.timestamp});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['present'] = Variable<bool>(present);
    map['subject'] = Variable<int>(subject);
    map['timestamp'] = Variable<DateTime>(timestamp);
    return map;
  }

  AttendanceCompanion toCompanion(bool nullToAbsent) {
    return AttendanceCompanion(
      id: Value(id),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      present: Value(present),
      subject: Value(subject),
      timestamp: Value(timestamp),
    );
  }

  factory AttendanceEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AttendanceEntry(
      id: serializer.fromJson<int>(json['id']),
      description: serializer.fromJson<String?>(json['description']),
      present: serializer.fromJson<bool>(json['present']),
      subject: serializer.fromJson<int>(json['subject']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'description': serializer.toJson<String?>(description),
      'present': serializer.toJson<bool>(present),
      'subject': serializer.toJson<int>(subject),
      'timestamp': serializer.toJson<DateTime>(timestamp),
    };
  }

  AttendanceEntry copyWith(
          {int? id,
          Value<String?> description = const Value.absent(),
          bool? present,
          int? subject,
          DateTime? timestamp}) =>
      AttendanceEntry(
        id: id ?? this.id,
        description: description.present ? description.value : this.description,
        present: present ?? this.present,
        subject: subject ?? this.subject,
        timestamp: timestamp ?? this.timestamp,
      );
  @override
  String toString() {
    return (StringBuffer('AttendanceEntry(')
          ..write('id: $id, ')
          ..write('description: $description, ')
          ..write('present: $present, ')
          ..write('subject: $subject, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, description, present, subject, timestamp);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AttendanceEntry &&
          other.id == this.id &&
          other.description == this.description &&
          other.present == this.present &&
          other.subject == this.subject &&
          other.timestamp == this.timestamp);
}

class AttendanceCompanion extends UpdateCompanion<AttendanceEntry> {
  final Value<int> id;
  final Value<String?> description;
  final Value<bool> present;
  final Value<int> subject;
  final Value<DateTime> timestamp;
  const AttendanceCompanion({
    this.id = const Value.absent(),
    this.description = const Value.absent(),
    this.present = const Value.absent(),
    this.subject = const Value.absent(),
    this.timestamp = const Value.absent(),
  });
  AttendanceCompanion.insert({
    this.id = const Value.absent(),
    this.description = const Value.absent(),
    required bool present,
    required int subject,
    required DateTime timestamp,
  })  : present = Value(present),
        subject = Value(subject),
        timestamp = Value(timestamp);
  static Insertable<AttendanceEntry> custom({
    Expression<int>? id,
    Expression<String>? description,
    Expression<bool>? present,
    Expression<int>? subject,
    Expression<DateTime>? timestamp,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (description != null) 'description': description,
      if (present != null) 'present': present,
      if (subject != null) 'subject': subject,
      if (timestamp != null) 'timestamp': timestamp,
    });
  }

  AttendanceCompanion copyWith(
      {Value<int>? id,
      Value<String?>? description,
      Value<bool>? present,
      Value<int>? subject,
      Value<DateTime>? timestamp}) {
    return AttendanceCompanion(
      id: id ?? this.id,
      description: description ?? this.description,
      present: present ?? this.present,
      subject: subject ?? this.subject,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (present.present) {
      map['present'] = Variable<bool>(present.value);
    }
    if (subject.present) {
      map['subject'] = Variable<int>(subject.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AttendanceCompanion(')
          ..write('id: $id, ')
          ..write('description: $description, ')
          ..write('present: $present, ')
          ..write('subject: $subject, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $SubjectEntriesTable subjectEntries = $SubjectEntriesTable(this);
  late final $AttendanceTable attendance = $AttendanceTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [subjectEntries, attendance];
}
