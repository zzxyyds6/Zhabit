// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $HabitsTable extends Habits with TableInfo<$HabitsTable, HabitRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HabitsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 64,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<HabitType, String> type =
      GeneratedColumn<String>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: Constant(HabitType.normal.name),
      ).withConverter<HabitType>($HabitsTable.$convertertype);
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
    'unit',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dailyGoalMeta = const VerificationMeta(
    'dailyGoal',
  );
  @override
  late final GeneratedColumn<int> dailyGoal = GeneratedColumn<int>(
    'daily_goal',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<HabitFrequency, String>
  frequency = GeneratedColumn<String>(
    'frequency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: Constant(HabitFrequency.daily.name),
  ).withConverter<HabitFrequency>($HabitsTable.$converterfrequency);
  static const VerificationMeta _frequencyValueMeta = const VerificationMeta(
    'frequencyValue',
  );
  @override
  late final GeneratedColumn<int> frequencyValue = GeneratedColumn<int>(
    'frequency_value',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _weekdaysMeta = const VerificationMeta(
    'weekdays',
  );
  @override
  late final GeneratedColumn<String> weekdays = GeneratedColumn<String>(
    'weekdays',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _reminderTimeMeta = const VerificationMeta(
    'reminderTime',
  );
  @override
  late final GeneratedColumn<String> reminderTime = GeneratedColumn<String>(
    'reminder_time',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _reminderDaysMeta = const VerificationMeta(
    'reminderDays',
  );
  @override
  late final GeneratedColumn<String> reminderDays = GeneratedColumn<String>(
    'reminder_days',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<int> color = GeneratedColumn<int>(
    'color',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0xFF2E7D6B),
  );
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
    'icon',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('star'),
  );
  static const VerificationMeta _archivedMeta = const VerificationMeta(
    'archived',
  );
  @override
  late final GeneratedColumn<bool> archived = GeneratedColumn<bool>(
    'archived',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("archived" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _vacationUntilMeta = const VerificationMeta(
    'vacationUntil',
  );
  @override
  late final GeneratedColumn<DateTime> vacationUntil =
      GeneratedColumn<DateTime>(
        'vacation_until',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    type,
    unit,
    dailyGoal,
    frequency,
    frequencyValue,
    weekdays,
    reminderTime,
    reminderDays,
    color,
    icon,
    archived,
    vacationUntil,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'habits';
  @override
  VerificationContext validateIntegrity(
    Insertable<HabitRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('unit')) {
      context.handle(
        _unitMeta,
        unit.isAcceptableOrUnknown(data['unit']!, _unitMeta),
      );
    }
    if (data.containsKey('daily_goal')) {
      context.handle(
        _dailyGoalMeta,
        dailyGoal.isAcceptableOrUnknown(data['daily_goal']!, _dailyGoalMeta),
      );
    }
    if (data.containsKey('frequency_value')) {
      context.handle(
        _frequencyValueMeta,
        frequencyValue.isAcceptableOrUnknown(
          data['frequency_value']!,
          _frequencyValueMeta,
        ),
      );
    }
    if (data.containsKey('weekdays')) {
      context.handle(
        _weekdaysMeta,
        weekdays.isAcceptableOrUnknown(data['weekdays']!, _weekdaysMeta),
      );
    }
    if (data.containsKey('reminder_time')) {
      context.handle(
        _reminderTimeMeta,
        reminderTime.isAcceptableOrUnknown(
          data['reminder_time']!,
          _reminderTimeMeta,
        ),
      );
    }
    if (data.containsKey('reminder_days')) {
      context.handle(
        _reminderDaysMeta,
        reminderDays.isAcceptableOrUnknown(
          data['reminder_days']!,
          _reminderDaysMeta,
        ),
      );
    }
    if (data.containsKey('color')) {
      context.handle(
        _colorMeta,
        color.isAcceptableOrUnknown(data['color']!, _colorMeta),
      );
    }
    if (data.containsKey('icon')) {
      context.handle(
        _iconMeta,
        icon.isAcceptableOrUnknown(data['icon']!, _iconMeta),
      );
    }
    if (data.containsKey('archived')) {
      context.handle(
        _archivedMeta,
        archived.isAcceptableOrUnknown(data['archived']!, _archivedMeta),
      );
    }
    if (data.containsKey('vacation_until')) {
      context.handle(
        _vacationUntilMeta,
        vacationUntil.isAcceptableOrUnknown(
          data['vacation_until']!,
          _vacationUntilMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HabitRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HabitRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      type: $HabitsTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}type'],
        )!,
      ),
      unit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit'],
      ),
      dailyGoal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}daily_goal'],
      ),
      frequency: $HabitsTable.$converterfrequency.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}frequency'],
        )!,
      ),
      frequencyValue: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}frequency_value'],
      ),
      weekdays: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}weekdays'],
      ),
      reminderTime: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reminder_time'],
      ),
      reminderDays: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reminder_days'],
      ),
      color: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}color'],
      )!,
      icon: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon'],
      )!,
      archived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}archived'],
      )!,
      vacationUntil: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}vacation_until'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $HabitsTable createAlias(String alias) {
    return $HabitsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<HabitType, String, String> $convertertype =
      const EnumNameConverter<HabitType>(HabitType.values);
  static JsonTypeConverter2<HabitFrequency, String, String>
  $converterfrequency = const EnumNameConverter<HabitFrequency>(
    HabitFrequency.values,
  );
}

class HabitRow extends DataClass implements Insertable<HabitRow> {
  final int id;
  final String name;
  final HabitType type;
  final String? unit;
  final int? dailyGoal;
  final HabitFrequency frequency;
  final int? frequencyValue;
  final String? weekdays;
  final String? reminderTime;
  final String? reminderDays;
  final int color;
  final String icon;
  final bool archived;
  final DateTime? vacationUntil;
  final DateTime createdAt;
  const HabitRow({
    required this.id,
    required this.name,
    required this.type,
    this.unit,
    this.dailyGoal,
    required this.frequency,
    this.frequencyValue,
    this.weekdays,
    this.reminderTime,
    this.reminderDays,
    required this.color,
    required this.icon,
    required this.archived,
    this.vacationUntil,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    {
      map['type'] = Variable<String>($HabitsTable.$convertertype.toSql(type));
    }
    if (!nullToAbsent || unit != null) {
      map['unit'] = Variable<String>(unit);
    }
    if (!nullToAbsent || dailyGoal != null) {
      map['daily_goal'] = Variable<int>(dailyGoal);
    }
    {
      map['frequency'] = Variable<String>(
        $HabitsTable.$converterfrequency.toSql(frequency),
      );
    }
    if (!nullToAbsent || frequencyValue != null) {
      map['frequency_value'] = Variable<int>(frequencyValue);
    }
    if (!nullToAbsent || weekdays != null) {
      map['weekdays'] = Variable<String>(weekdays);
    }
    if (!nullToAbsent || reminderTime != null) {
      map['reminder_time'] = Variable<String>(reminderTime);
    }
    if (!nullToAbsent || reminderDays != null) {
      map['reminder_days'] = Variable<String>(reminderDays);
    }
    map['color'] = Variable<int>(color);
    map['icon'] = Variable<String>(icon);
    map['archived'] = Variable<bool>(archived);
    if (!nullToAbsent || vacationUntil != null) {
      map['vacation_until'] = Variable<DateTime>(vacationUntil);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  HabitsCompanion toCompanion(bool nullToAbsent) {
    return HabitsCompanion(
      id: Value(id),
      name: Value(name),
      type: Value(type),
      unit: unit == null && nullToAbsent ? const Value.absent() : Value(unit),
      dailyGoal: dailyGoal == null && nullToAbsent
          ? const Value.absent()
          : Value(dailyGoal),
      frequency: Value(frequency),
      frequencyValue: frequencyValue == null && nullToAbsent
          ? const Value.absent()
          : Value(frequencyValue),
      weekdays: weekdays == null && nullToAbsent
          ? const Value.absent()
          : Value(weekdays),
      reminderTime: reminderTime == null && nullToAbsent
          ? const Value.absent()
          : Value(reminderTime),
      reminderDays: reminderDays == null && nullToAbsent
          ? const Value.absent()
          : Value(reminderDays),
      color: Value(color),
      icon: Value(icon),
      archived: Value(archived),
      vacationUntil: vacationUntil == null && nullToAbsent
          ? const Value.absent()
          : Value(vacationUntil),
      createdAt: Value(createdAt),
    );
  }

  factory HabitRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HabitRow(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      type: $HabitsTable.$convertertype.fromJson(
        serializer.fromJson<String>(json['type']),
      ),
      unit: serializer.fromJson<String?>(json['unit']),
      dailyGoal: serializer.fromJson<int?>(json['dailyGoal']),
      frequency: $HabitsTable.$converterfrequency.fromJson(
        serializer.fromJson<String>(json['frequency']),
      ),
      frequencyValue: serializer.fromJson<int?>(json['frequencyValue']),
      weekdays: serializer.fromJson<String?>(json['weekdays']),
      reminderTime: serializer.fromJson<String?>(json['reminderTime']),
      reminderDays: serializer.fromJson<String?>(json['reminderDays']),
      color: serializer.fromJson<int>(json['color']),
      icon: serializer.fromJson<String>(json['icon']),
      archived: serializer.fromJson<bool>(json['archived']),
      vacationUntil: serializer.fromJson<DateTime?>(json['vacationUntil']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<String>(
        $HabitsTable.$convertertype.toJson(type),
      ),
      'unit': serializer.toJson<String?>(unit),
      'dailyGoal': serializer.toJson<int?>(dailyGoal),
      'frequency': serializer.toJson<String>(
        $HabitsTable.$converterfrequency.toJson(frequency),
      ),
      'frequencyValue': serializer.toJson<int?>(frequencyValue),
      'weekdays': serializer.toJson<String?>(weekdays),
      'reminderTime': serializer.toJson<String?>(reminderTime),
      'reminderDays': serializer.toJson<String?>(reminderDays),
      'color': serializer.toJson<int>(color),
      'icon': serializer.toJson<String>(icon),
      'archived': serializer.toJson<bool>(archived),
      'vacationUntil': serializer.toJson<DateTime?>(vacationUntil),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  HabitRow copyWith({
    int? id,
    String? name,
    HabitType? type,
    Value<String?> unit = const Value.absent(),
    Value<int?> dailyGoal = const Value.absent(),
    HabitFrequency? frequency,
    Value<int?> frequencyValue = const Value.absent(),
    Value<String?> weekdays = const Value.absent(),
    Value<String?> reminderTime = const Value.absent(),
    Value<String?> reminderDays = const Value.absent(),
    int? color,
    String? icon,
    bool? archived,
    Value<DateTime?> vacationUntil = const Value.absent(),
    DateTime? createdAt,
  }) => HabitRow(
    id: id ?? this.id,
    name: name ?? this.name,
    type: type ?? this.type,
    unit: unit.present ? unit.value : this.unit,
    dailyGoal: dailyGoal.present ? dailyGoal.value : this.dailyGoal,
    frequency: frequency ?? this.frequency,
    frequencyValue: frequencyValue.present
        ? frequencyValue.value
        : this.frequencyValue,
    weekdays: weekdays.present ? weekdays.value : this.weekdays,
    reminderTime: reminderTime.present ? reminderTime.value : this.reminderTime,
    reminderDays: reminderDays.present ? reminderDays.value : this.reminderDays,
    color: color ?? this.color,
    icon: icon ?? this.icon,
    archived: archived ?? this.archived,
    vacationUntil: vacationUntil.present
        ? vacationUntil.value
        : this.vacationUntil,
    createdAt: createdAt ?? this.createdAt,
  );
  HabitRow copyWithCompanion(HabitsCompanion data) {
    return HabitRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      type: data.type.present ? data.type.value : this.type,
      unit: data.unit.present ? data.unit.value : this.unit,
      dailyGoal: data.dailyGoal.present ? data.dailyGoal.value : this.dailyGoal,
      frequency: data.frequency.present ? data.frequency.value : this.frequency,
      frequencyValue: data.frequencyValue.present
          ? data.frequencyValue.value
          : this.frequencyValue,
      weekdays: data.weekdays.present ? data.weekdays.value : this.weekdays,
      reminderTime: data.reminderTime.present
          ? data.reminderTime.value
          : this.reminderTime,
      reminderDays: data.reminderDays.present
          ? data.reminderDays.value
          : this.reminderDays,
      color: data.color.present ? data.color.value : this.color,
      icon: data.icon.present ? data.icon.value : this.icon,
      archived: data.archived.present ? data.archived.value : this.archived,
      vacationUntil: data.vacationUntil.present
          ? data.vacationUntil.value
          : this.vacationUntil,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HabitRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('unit: $unit, ')
          ..write('dailyGoal: $dailyGoal, ')
          ..write('frequency: $frequency, ')
          ..write('frequencyValue: $frequencyValue, ')
          ..write('weekdays: $weekdays, ')
          ..write('reminderTime: $reminderTime, ')
          ..write('reminderDays: $reminderDays, ')
          ..write('color: $color, ')
          ..write('icon: $icon, ')
          ..write('archived: $archived, ')
          ..write('vacationUntil: $vacationUntil, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    type,
    unit,
    dailyGoal,
    frequency,
    frequencyValue,
    weekdays,
    reminderTime,
    reminderDays,
    color,
    icon,
    archived,
    vacationUntil,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HabitRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.type == this.type &&
          other.unit == this.unit &&
          other.dailyGoal == this.dailyGoal &&
          other.frequency == this.frequency &&
          other.frequencyValue == this.frequencyValue &&
          other.weekdays == this.weekdays &&
          other.reminderTime == this.reminderTime &&
          other.reminderDays == this.reminderDays &&
          other.color == this.color &&
          other.icon == this.icon &&
          other.archived == this.archived &&
          other.vacationUntil == this.vacationUntil &&
          other.createdAt == this.createdAt);
}

class HabitsCompanion extends UpdateCompanion<HabitRow> {
  final Value<int> id;
  final Value<String> name;
  final Value<HabitType> type;
  final Value<String?> unit;
  final Value<int?> dailyGoal;
  final Value<HabitFrequency> frequency;
  final Value<int?> frequencyValue;
  final Value<String?> weekdays;
  final Value<String?> reminderTime;
  final Value<String?> reminderDays;
  final Value<int> color;
  final Value<String> icon;
  final Value<bool> archived;
  final Value<DateTime?> vacationUntil;
  final Value<DateTime> createdAt;
  const HabitsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.unit = const Value.absent(),
    this.dailyGoal = const Value.absent(),
    this.frequency = const Value.absent(),
    this.frequencyValue = const Value.absent(),
    this.weekdays = const Value.absent(),
    this.reminderTime = const Value.absent(),
    this.reminderDays = const Value.absent(),
    this.color = const Value.absent(),
    this.icon = const Value.absent(),
    this.archived = const Value.absent(),
    this.vacationUntil = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  HabitsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.type = const Value.absent(),
    this.unit = const Value.absent(),
    this.dailyGoal = const Value.absent(),
    this.frequency = const Value.absent(),
    this.frequencyValue = const Value.absent(),
    this.weekdays = const Value.absent(),
    this.reminderTime = const Value.absent(),
    this.reminderDays = const Value.absent(),
    this.color = const Value.absent(),
    this.icon = const Value.absent(),
    this.archived = const Value.absent(),
    this.vacationUntil = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<HabitRow> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? type,
    Expression<String>? unit,
    Expression<int>? dailyGoal,
    Expression<String>? frequency,
    Expression<int>? frequencyValue,
    Expression<String>? weekdays,
    Expression<String>? reminderTime,
    Expression<String>? reminderDays,
    Expression<int>? color,
    Expression<String>? icon,
    Expression<bool>? archived,
    Expression<DateTime>? vacationUntil,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (unit != null) 'unit': unit,
      if (dailyGoal != null) 'daily_goal': dailyGoal,
      if (frequency != null) 'frequency': frequency,
      if (frequencyValue != null) 'frequency_value': frequencyValue,
      if (weekdays != null) 'weekdays': weekdays,
      if (reminderTime != null) 'reminder_time': reminderTime,
      if (reminderDays != null) 'reminder_days': reminderDays,
      if (color != null) 'color': color,
      if (icon != null) 'icon': icon,
      if (archived != null) 'archived': archived,
      if (vacationUntil != null) 'vacation_until': vacationUntil,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  HabitsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<HabitType>? type,
    Value<String?>? unit,
    Value<int?>? dailyGoal,
    Value<HabitFrequency>? frequency,
    Value<int?>? frequencyValue,
    Value<String?>? weekdays,
    Value<String?>? reminderTime,
    Value<String?>? reminderDays,
    Value<int>? color,
    Value<String>? icon,
    Value<bool>? archived,
    Value<DateTime?>? vacationUntil,
    Value<DateTime>? createdAt,
  }) {
    return HabitsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      unit: unit ?? this.unit,
      dailyGoal: dailyGoal ?? this.dailyGoal,
      frequency: frequency ?? this.frequency,
      frequencyValue: frequencyValue ?? this.frequencyValue,
      weekdays: weekdays ?? this.weekdays,
      reminderTime: reminderTime ?? this.reminderTime,
      reminderDays: reminderDays ?? this.reminderDays,
      color: color ?? this.color,
      icon: icon ?? this.icon,
      archived: archived ?? this.archived,
      vacationUntil: vacationUntil ?? this.vacationUntil,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(
        $HabitsTable.$convertertype.toSql(type.value),
      );
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (dailyGoal.present) {
      map['daily_goal'] = Variable<int>(dailyGoal.value);
    }
    if (frequency.present) {
      map['frequency'] = Variable<String>(
        $HabitsTable.$converterfrequency.toSql(frequency.value),
      );
    }
    if (frequencyValue.present) {
      map['frequency_value'] = Variable<int>(frequencyValue.value);
    }
    if (weekdays.present) {
      map['weekdays'] = Variable<String>(weekdays.value);
    }
    if (reminderTime.present) {
      map['reminder_time'] = Variable<String>(reminderTime.value);
    }
    if (reminderDays.present) {
      map['reminder_days'] = Variable<String>(reminderDays.value);
    }
    if (color.present) {
      map['color'] = Variable<int>(color.value);
    }
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (archived.present) {
      map['archived'] = Variable<bool>(archived.value);
    }
    if (vacationUntil.present) {
      map['vacation_until'] = Variable<DateTime>(vacationUntil.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HabitsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('unit: $unit, ')
          ..write('dailyGoal: $dailyGoal, ')
          ..write('frequency: $frequency, ')
          ..write('frequencyValue: $frequencyValue, ')
          ..write('weekdays: $weekdays, ')
          ..write('reminderTime: $reminderTime, ')
          ..write('reminderDays: $reminderDays, ')
          ..write('color: $color, ')
          ..write('icon: $icon, ')
          ..write('archived: $archived, ')
          ..write('vacationUntil: $vacationUntil, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $CheckInsTable extends CheckIns
    with TableInfo<$CheckInsTable, CheckInRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CheckInsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _habitIdMeta = const VerificationMeta(
    'habitId',
  );
  @override
  late final GeneratedColumn<int> habitId = GeneratedColumn<int>(
    'habit_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES habits (id)',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<CheckStatus, String> status =
      GeneratedColumn<String>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: Constant(CheckStatus.done.name),
      ).withConverter<CheckStatus>($CheckInsTable.$converterstatus);
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
    'amount',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    habitId,
    date,
    status,
    amount,
    note,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'check_ins';
  @override
  VerificationContext validateIntegrity(
    Insertable<CheckInRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('habit_id')) {
      context.handle(
        _habitIdMeta,
        habitId.isAcceptableOrUnknown(data['habit_id']!, _habitIdMeta),
      );
    } else if (isInserting) {
      context.missing(_habitIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CheckInRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CheckInRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      habitId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}habit_id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date'],
      )!,
      status: $CheckInsTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
    );
  }

  @override
  $CheckInsTable createAlias(String alias) {
    return $CheckInsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<CheckStatus, String, String> $converterstatus =
      const EnumNameConverter<CheckStatus>(CheckStatus.values);
}

class CheckInRow extends DataClass implements Insertable<CheckInRow> {
  final int id;
  final int habitId;

  /// YYYY-MM-DD,避免时区与日期计算歧义
  final String date;
  final CheckStatus status;
  final int? amount;
  final String? note;
  const CheckInRow({
    required this.id,
    required this.habitId,
    required this.date,
    required this.status,
    this.amount,
    this.note,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['habit_id'] = Variable<int>(habitId);
    map['date'] = Variable<String>(date);
    {
      map['status'] = Variable<String>(
        $CheckInsTable.$converterstatus.toSql(status),
      );
    }
    if (!nullToAbsent || amount != null) {
      map['amount'] = Variable<int>(amount);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    return map;
  }

  CheckInsCompanion toCompanion(bool nullToAbsent) {
    return CheckInsCompanion(
      id: Value(id),
      habitId: Value(habitId),
      date: Value(date),
      status: Value(status),
      amount: amount == null && nullToAbsent
          ? const Value.absent()
          : Value(amount),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  factory CheckInRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CheckInRow(
      id: serializer.fromJson<int>(json['id']),
      habitId: serializer.fromJson<int>(json['habitId']),
      date: serializer.fromJson<String>(json['date']),
      status: $CheckInsTable.$converterstatus.fromJson(
        serializer.fromJson<String>(json['status']),
      ),
      amount: serializer.fromJson<int?>(json['amount']),
      note: serializer.fromJson<String?>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'habitId': serializer.toJson<int>(habitId),
      'date': serializer.toJson<String>(date),
      'status': serializer.toJson<String>(
        $CheckInsTable.$converterstatus.toJson(status),
      ),
      'amount': serializer.toJson<int?>(amount),
      'note': serializer.toJson<String?>(note),
    };
  }

  CheckInRow copyWith({
    int? id,
    int? habitId,
    String? date,
    CheckStatus? status,
    Value<int?> amount = const Value.absent(),
    Value<String?> note = const Value.absent(),
  }) => CheckInRow(
    id: id ?? this.id,
    habitId: habitId ?? this.habitId,
    date: date ?? this.date,
    status: status ?? this.status,
    amount: amount.present ? amount.value : this.amount,
    note: note.present ? note.value : this.note,
  );
  CheckInRow copyWithCompanion(CheckInsCompanion data) {
    return CheckInRow(
      id: data.id.present ? data.id.value : this.id,
      habitId: data.habitId.present ? data.habitId.value : this.habitId,
      date: data.date.present ? data.date.value : this.date,
      status: data.status.present ? data.status.value : this.status,
      amount: data.amount.present ? data.amount.value : this.amount,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CheckInRow(')
          ..write('id: $id, ')
          ..write('habitId: $habitId, ')
          ..write('date: $date, ')
          ..write('status: $status, ')
          ..write('amount: $amount, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, habitId, date, status, amount, note);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CheckInRow &&
          other.id == this.id &&
          other.habitId == this.habitId &&
          other.date == this.date &&
          other.status == this.status &&
          other.amount == this.amount &&
          other.note == this.note);
}

class CheckInsCompanion extends UpdateCompanion<CheckInRow> {
  final Value<int> id;
  final Value<int> habitId;
  final Value<String> date;
  final Value<CheckStatus> status;
  final Value<int?> amount;
  final Value<String?> note;
  const CheckInsCompanion({
    this.id = const Value.absent(),
    this.habitId = const Value.absent(),
    this.date = const Value.absent(),
    this.status = const Value.absent(),
    this.amount = const Value.absent(),
    this.note = const Value.absent(),
  });
  CheckInsCompanion.insert({
    this.id = const Value.absent(),
    required int habitId,
    required String date,
    this.status = const Value.absent(),
    this.amount = const Value.absent(),
    this.note = const Value.absent(),
  }) : habitId = Value(habitId),
       date = Value(date);
  static Insertable<CheckInRow> custom({
    Expression<int>? id,
    Expression<int>? habitId,
    Expression<String>? date,
    Expression<String>? status,
    Expression<int>? amount,
    Expression<String>? note,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (habitId != null) 'habit_id': habitId,
      if (date != null) 'date': date,
      if (status != null) 'status': status,
      if (amount != null) 'amount': amount,
      if (note != null) 'note': note,
    });
  }

  CheckInsCompanion copyWith({
    Value<int>? id,
    Value<int>? habitId,
    Value<String>? date,
    Value<CheckStatus>? status,
    Value<int?>? amount,
    Value<String?>? note,
  }) {
    return CheckInsCompanion(
      id: id ?? this.id,
      habitId: habitId ?? this.habitId,
      date: date ?? this.date,
      status: status ?? this.status,
      amount: amount ?? this.amount,
      note: note ?? this.note,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (habitId.present) {
      map['habit_id'] = Variable<int>(habitId.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
        $CheckInsTable.$converterstatus.toSql(status.value),
      );
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CheckInsCompanion(')
          ..write('id: $id, ')
          ..write('habitId: $habitId, ')
          ..write('date: $date, ')
          ..write('status: $status, ')
          ..write('amount: $amount, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }
}

class $ShortTasksTable extends ShortTasks
    with TableInfo<$ShortTasksTable, ShortTaskRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ShortTasksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 128,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dueDateMeta = const VerificationMeta(
    'dueDate',
  );
  @override
  late final GeneratedColumn<DateTime> dueDate = GeneratedColumn<DateTime>(
    'due_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _reminderTimeMeta = const VerificationMeta(
    'reminderTime',
  );
  @override
  late final GeneratedColumn<DateTime> reminderTime = GeneratedColumn<DateTime>(
    'reminder_time',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _doneMeta = const VerificationMeta('done');
  @override
  late final GeneratedColumn<bool> done = GeneratedColumn<bool>(
    'done',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("done" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _hiddenMeta = const VerificationMeta('hidden');
  @override
  late final GeneratedColumn<bool> hidden = GeneratedColumn<bool>(
    'hidden',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("hidden" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    dueDate,
    reminderTime,
    done,
    completedAt,
    hidden,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'short_tasks';
  @override
  VerificationContext validateIntegrity(
    Insertable<ShortTaskRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('due_date')) {
      context.handle(
        _dueDateMeta,
        dueDate.isAcceptableOrUnknown(data['due_date']!, _dueDateMeta),
      );
    }
    if (data.containsKey('reminder_time')) {
      context.handle(
        _reminderTimeMeta,
        reminderTime.isAcceptableOrUnknown(
          data['reminder_time']!,
          _reminderTimeMeta,
        ),
      );
    }
    if (data.containsKey('done')) {
      context.handle(
        _doneMeta,
        done.isAcceptableOrUnknown(data['done']!, _doneMeta),
      );
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    if (data.containsKey('hidden')) {
      context.handle(
        _hiddenMeta,
        hidden.isAcceptableOrUnknown(data['hidden']!, _hiddenMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ShortTaskRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ShortTaskRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      dueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}due_date'],
      ),
      reminderTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}reminder_time'],
      ),
      done: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}done'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
      hidden: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}hidden'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ShortTasksTable createAlias(String alias) {
    return $ShortTasksTable(attachedDatabase, alias);
  }
}

class ShortTaskRow extends DataClass implements Insertable<ShortTaskRow> {
  final int id;
  final String name;
  final DateTime? dueDate;
  final DateTime? reminderTime;
  final bool done;
  final DateTime? completedAt;
  final bool hidden;
  final DateTime createdAt;
  const ShortTaskRow({
    required this.id,
    required this.name,
    this.dueDate,
    this.reminderTime,
    required this.done,
    this.completedAt,
    required this.hidden,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || dueDate != null) {
      map['due_date'] = Variable<DateTime>(dueDate);
    }
    if (!nullToAbsent || reminderTime != null) {
      map['reminder_time'] = Variable<DateTime>(reminderTime);
    }
    map['done'] = Variable<bool>(done);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    map['hidden'] = Variable<bool>(hidden);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ShortTasksCompanion toCompanion(bool nullToAbsent) {
    return ShortTasksCompanion(
      id: Value(id),
      name: Value(name),
      dueDate: dueDate == null && nullToAbsent
          ? const Value.absent()
          : Value(dueDate),
      reminderTime: reminderTime == null && nullToAbsent
          ? const Value.absent()
          : Value(reminderTime),
      done: Value(done),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      hidden: Value(hidden),
      createdAt: Value(createdAt),
    );
  }

  factory ShortTaskRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ShortTaskRow(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      dueDate: serializer.fromJson<DateTime?>(json['dueDate']),
      reminderTime: serializer.fromJson<DateTime?>(json['reminderTime']),
      done: serializer.fromJson<bool>(json['done']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      hidden: serializer.fromJson<bool>(json['hidden']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'dueDate': serializer.toJson<DateTime?>(dueDate),
      'reminderTime': serializer.toJson<DateTime?>(reminderTime),
      'done': serializer.toJson<bool>(done),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'hidden': serializer.toJson<bool>(hidden),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  ShortTaskRow copyWith({
    int? id,
    String? name,
    Value<DateTime?> dueDate = const Value.absent(),
    Value<DateTime?> reminderTime = const Value.absent(),
    bool? done,
    Value<DateTime?> completedAt = const Value.absent(),
    bool? hidden,
    DateTime? createdAt,
  }) => ShortTaskRow(
    id: id ?? this.id,
    name: name ?? this.name,
    dueDate: dueDate.present ? dueDate.value : this.dueDate,
    reminderTime: reminderTime.present ? reminderTime.value : this.reminderTime,
    done: done ?? this.done,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
    hidden: hidden ?? this.hidden,
    createdAt: createdAt ?? this.createdAt,
  );
  ShortTaskRow copyWithCompanion(ShortTasksCompanion data) {
    return ShortTaskRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      dueDate: data.dueDate.present ? data.dueDate.value : this.dueDate,
      reminderTime: data.reminderTime.present
          ? data.reminderTime.value
          : this.reminderTime,
      done: data.done.present ? data.done.value : this.done,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
      hidden: data.hidden.present ? data.hidden.value : this.hidden,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ShortTaskRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('dueDate: $dueDate, ')
          ..write('reminderTime: $reminderTime, ')
          ..write('done: $done, ')
          ..write('completedAt: $completedAt, ')
          ..write('hidden: $hidden, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    dueDate,
    reminderTime,
    done,
    completedAt,
    hidden,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ShortTaskRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.dueDate == this.dueDate &&
          other.reminderTime == this.reminderTime &&
          other.done == this.done &&
          other.completedAt == this.completedAt &&
          other.hidden == this.hidden &&
          other.createdAt == this.createdAt);
}

class ShortTasksCompanion extends UpdateCompanion<ShortTaskRow> {
  final Value<int> id;
  final Value<String> name;
  final Value<DateTime?> dueDate;
  final Value<DateTime?> reminderTime;
  final Value<bool> done;
  final Value<DateTime?> completedAt;
  final Value<bool> hidden;
  final Value<DateTime> createdAt;
  const ShortTasksCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.reminderTime = const Value.absent(),
    this.done = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.hidden = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ShortTasksCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.dueDate = const Value.absent(),
    this.reminderTime = const Value.absent(),
    this.done = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.hidden = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<ShortTaskRow> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<DateTime>? dueDate,
    Expression<DateTime>? reminderTime,
    Expression<bool>? done,
    Expression<DateTime>? completedAt,
    Expression<bool>? hidden,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (dueDate != null) 'due_date': dueDate,
      if (reminderTime != null) 'reminder_time': reminderTime,
      if (done != null) 'done': done,
      if (completedAt != null) 'completed_at': completedAt,
      if (hidden != null) 'hidden': hidden,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ShortTasksCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<DateTime?>? dueDate,
    Value<DateTime?>? reminderTime,
    Value<bool>? done,
    Value<DateTime?>? completedAt,
    Value<bool>? hidden,
    Value<DateTime>? createdAt,
  }) {
    return ShortTasksCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      dueDate: dueDate ?? this.dueDate,
      reminderTime: reminderTime ?? this.reminderTime,
      done: done ?? this.done,
      completedAt: completedAt ?? this.completedAt,
      hidden: hidden ?? this.hidden,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<DateTime>(dueDate.value);
    }
    if (reminderTime.present) {
      map['reminder_time'] = Variable<DateTime>(reminderTime.value);
    }
    if (done.present) {
      map['done'] = Variable<bool>(done.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (hidden.present) {
      map['hidden'] = Variable<bool>(hidden.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ShortTasksCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('dueDate: $dueDate, ')
          ..write('reminderTime: $reminderTime, ')
          ..write('done: $done, ')
          ..write('completedAt: $completedAt, ')
          ..write('hidden: $hidden, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $ReminderGlobalTable extends ReminderGlobal
    with TableInfo<$ReminderGlobalTable, ReminderGlobalRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReminderGlobalTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _enabledMeta = const VerificationMeta(
    'enabled',
  );
  @override
  late final GeneratedColumn<bool> enabled = GeneratedColumn<bool>(
    'enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  late final GeneratedColumnWithTypeConverter<ReminderMode, String> mode =
      GeneratedColumn<String>(
        'mode',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: Constant(ReminderMode.fixed.name),
      ).withConverter<ReminderMode>($ReminderGlobalTable.$convertermode);
  static const VerificationMeta _intervalMinutesMeta = const VerificationMeta(
    'intervalMinutes',
  );
  @override
  late final GeneratedColumn<int> intervalMinutes = GeneratedColumn<int>(
    'interval_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(30),
  );
  static const VerificationMeta _randomMinMeta = const VerificationMeta(
    'randomMin',
  );
  @override
  late final GeneratedColumn<int> randomMin = GeneratedColumn<int>(
    'random_min',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(15),
  );
  static const VerificationMeta _randomMaxMeta = const VerificationMeta(
    'randomMax',
  );
  @override
  late final GeneratedColumn<int> randomMax = GeneratedColumn<int>(
    'random_max',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(60),
  );
  static const VerificationMeta _activeFromMeta = const VerificationMeta(
    'activeFrom',
  );
  @override
  late final GeneratedColumn<String> activeFrom = GeneratedColumn<String>(
    'active_from',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('08:00'),
  );
  static const VerificationMeta _activeUntilMeta = const VerificationMeta(
    'activeUntil',
  );
  @override
  late final GeneratedColumn<String> activeUntil = GeneratedColumn<String>(
    'active_until',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('22:00'),
  );
  static const VerificationMeta _maxPerPopupMeta = const VerificationMeta(
    'maxPerPopup',
  );
  @override
  late final GeneratedColumn<int> maxPerPopup = GeneratedColumn<int>(
    'max_per_popup',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(3),
  );
  static const VerificationMeta _cooldownMinutesMeta = const VerificationMeta(
    'cooldownMinutes',
  );
  @override
  late final GeneratedColumn<int> cooldownMinutes = GeneratedColumn<int>(
    'cooldown_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(15),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    enabled,
    mode,
    intervalMinutes,
    randomMin,
    randomMax,
    activeFrom,
    activeUntil,
    maxPerPopup,
    cooldownMinutes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reminder_global';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReminderGlobalRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('enabled')) {
      context.handle(
        _enabledMeta,
        enabled.isAcceptableOrUnknown(data['enabled']!, _enabledMeta),
      );
    }
    if (data.containsKey('interval_minutes')) {
      context.handle(
        _intervalMinutesMeta,
        intervalMinutes.isAcceptableOrUnknown(
          data['interval_minutes']!,
          _intervalMinutesMeta,
        ),
      );
    }
    if (data.containsKey('random_min')) {
      context.handle(
        _randomMinMeta,
        randomMin.isAcceptableOrUnknown(data['random_min']!, _randomMinMeta),
      );
    }
    if (data.containsKey('random_max')) {
      context.handle(
        _randomMaxMeta,
        randomMax.isAcceptableOrUnknown(data['random_max']!, _randomMaxMeta),
      );
    }
    if (data.containsKey('active_from')) {
      context.handle(
        _activeFromMeta,
        activeFrom.isAcceptableOrUnknown(data['active_from']!, _activeFromMeta),
      );
    }
    if (data.containsKey('active_until')) {
      context.handle(
        _activeUntilMeta,
        activeUntil.isAcceptableOrUnknown(
          data['active_until']!,
          _activeUntilMeta,
        ),
      );
    }
    if (data.containsKey('max_per_popup')) {
      context.handle(
        _maxPerPopupMeta,
        maxPerPopup.isAcceptableOrUnknown(
          data['max_per_popup']!,
          _maxPerPopupMeta,
        ),
      );
    }
    if (data.containsKey('cooldown_minutes')) {
      context.handle(
        _cooldownMinutesMeta,
        cooldownMinutes.isAcceptableOrUnknown(
          data['cooldown_minutes']!,
          _cooldownMinutesMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  ReminderGlobalRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReminderGlobalRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      enabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}enabled'],
      )!,
      mode: $ReminderGlobalTable.$convertermode.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}mode'],
        )!,
      ),
      intervalMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}interval_minutes'],
      )!,
      randomMin: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}random_min'],
      )!,
      randomMax: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}random_max'],
      )!,
      activeFrom: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}active_from'],
      )!,
      activeUntil: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}active_until'],
      )!,
      maxPerPopup: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}max_per_popup'],
      )!,
      cooldownMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cooldown_minutes'],
      )!,
    );
  }

  @override
  $ReminderGlobalTable createAlias(String alias) {
    return $ReminderGlobalTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<ReminderMode, String, String> $convertermode =
      const EnumNameConverter<ReminderMode>(ReminderMode.values);
}

class ReminderGlobalRow extends DataClass
    implements Insertable<ReminderGlobalRow> {
  final int id;
  final bool enabled;
  final ReminderMode mode;
  final int intervalMinutes;
  final int randomMin;
  final int randomMax;
  final String activeFrom;
  final String activeUntil;
  final int maxPerPopup;
  final int cooldownMinutes;
  const ReminderGlobalRow({
    required this.id,
    required this.enabled,
    required this.mode,
    required this.intervalMinutes,
    required this.randomMin,
    required this.randomMax,
    required this.activeFrom,
    required this.activeUntil,
    required this.maxPerPopup,
    required this.cooldownMinutes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['enabled'] = Variable<bool>(enabled);
    {
      map['mode'] = Variable<String>(
        $ReminderGlobalTable.$convertermode.toSql(mode),
      );
    }
    map['interval_minutes'] = Variable<int>(intervalMinutes);
    map['random_min'] = Variable<int>(randomMin);
    map['random_max'] = Variable<int>(randomMax);
    map['active_from'] = Variable<String>(activeFrom);
    map['active_until'] = Variable<String>(activeUntil);
    map['max_per_popup'] = Variable<int>(maxPerPopup);
    map['cooldown_minutes'] = Variable<int>(cooldownMinutes);
    return map;
  }

  ReminderGlobalCompanion toCompanion(bool nullToAbsent) {
    return ReminderGlobalCompanion(
      id: Value(id),
      enabled: Value(enabled),
      mode: Value(mode),
      intervalMinutes: Value(intervalMinutes),
      randomMin: Value(randomMin),
      randomMax: Value(randomMax),
      activeFrom: Value(activeFrom),
      activeUntil: Value(activeUntil),
      maxPerPopup: Value(maxPerPopup),
      cooldownMinutes: Value(cooldownMinutes),
    );
  }

  factory ReminderGlobalRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReminderGlobalRow(
      id: serializer.fromJson<int>(json['id']),
      enabled: serializer.fromJson<bool>(json['enabled']),
      mode: $ReminderGlobalTable.$convertermode.fromJson(
        serializer.fromJson<String>(json['mode']),
      ),
      intervalMinutes: serializer.fromJson<int>(json['intervalMinutes']),
      randomMin: serializer.fromJson<int>(json['randomMin']),
      randomMax: serializer.fromJson<int>(json['randomMax']),
      activeFrom: serializer.fromJson<String>(json['activeFrom']),
      activeUntil: serializer.fromJson<String>(json['activeUntil']),
      maxPerPopup: serializer.fromJson<int>(json['maxPerPopup']),
      cooldownMinutes: serializer.fromJson<int>(json['cooldownMinutes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'enabled': serializer.toJson<bool>(enabled),
      'mode': serializer.toJson<String>(
        $ReminderGlobalTable.$convertermode.toJson(mode),
      ),
      'intervalMinutes': serializer.toJson<int>(intervalMinutes),
      'randomMin': serializer.toJson<int>(randomMin),
      'randomMax': serializer.toJson<int>(randomMax),
      'activeFrom': serializer.toJson<String>(activeFrom),
      'activeUntil': serializer.toJson<String>(activeUntil),
      'maxPerPopup': serializer.toJson<int>(maxPerPopup),
      'cooldownMinutes': serializer.toJson<int>(cooldownMinutes),
    };
  }

  ReminderGlobalRow copyWith({
    int? id,
    bool? enabled,
    ReminderMode? mode,
    int? intervalMinutes,
    int? randomMin,
    int? randomMax,
    String? activeFrom,
    String? activeUntil,
    int? maxPerPopup,
    int? cooldownMinutes,
  }) => ReminderGlobalRow(
    id: id ?? this.id,
    enabled: enabled ?? this.enabled,
    mode: mode ?? this.mode,
    intervalMinutes: intervalMinutes ?? this.intervalMinutes,
    randomMin: randomMin ?? this.randomMin,
    randomMax: randomMax ?? this.randomMax,
    activeFrom: activeFrom ?? this.activeFrom,
    activeUntil: activeUntil ?? this.activeUntil,
    maxPerPopup: maxPerPopup ?? this.maxPerPopup,
    cooldownMinutes: cooldownMinutes ?? this.cooldownMinutes,
  );
  ReminderGlobalRow copyWithCompanion(ReminderGlobalCompanion data) {
    return ReminderGlobalRow(
      id: data.id.present ? data.id.value : this.id,
      enabled: data.enabled.present ? data.enabled.value : this.enabled,
      mode: data.mode.present ? data.mode.value : this.mode,
      intervalMinutes: data.intervalMinutes.present
          ? data.intervalMinutes.value
          : this.intervalMinutes,
      randomMin: data.randomMin.present ? data.randomMin.value : this.randomMin,
      randomMax: data.randomMax.present ? data.randomMax.value : this.randomMax,
      activeFrom: data.activeFrom.present
          ? data.activeFrom.value
          : this.activeFrom,
      activeUntil: data.activeUntil.present
          ? data.activeUntil.value
          : this.activeUntil,
      maxPerPopup: data.maxPerPopup.present
          ? data.maxPerPopup.value
          : this.maxPerPopup,
      cooldownMinutes: data.cooldownMinutes.present
          ? data.cooldownMinutes.value
          : this.cooldownMinutes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReminderGlobalRow(')
          ..write('id: $id, ')
          ..write('enabled: $enabled, ')
          ..write('mode: $mode, ')
          ..write('intervalMinutes: $intervalMinutes, ')
          ..write('randomMin: $randomMin, ')
          ..write('randomMax: $randomMax, ')
          ..write('activeFrom: $activeFrom, ')
          ..write('activeUntil: $activeUntil, ')
          ..write('maxPerPopup: $maxPerPopup, ')
          ..write('cooldownMinutes: $cooldownMinutes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    enabled,
    mode,
    intervalMinutes,
    randomMin,
    randomMax,
    activeFrom,
    activeUntil,
    maxPerPopup,
    cooldownMinutes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReminderGlobalRow &&
          other.id == this.id &&
          other.enabled == this.enabled &&
          other.mode == this.mode &&
          other.intervalMinutes == this.intervalMinutes &&
          other.randomMin == this.randomMin &&
          other.randomMax == this.randomMax &&
          other.activeFrom == this.activeFrom &&
          other.activeUntil == this.activeUntil &&
          other.maxPerPopup == this.maxPerPopup &&
          other.cooldownMinutes == this.cooldownMinutes);
}

class ReminderGlobalCompanion extends UpdateCompanion<ReminderGlobalRow> {
  final Value<int> id;
  final Value<bool> enabled;
  final Value<ReminderMode> mode;
  final Value<int> intervalMinutes;
  final Value<int> randomMin;
  final Value<int> randomMax;
  final Value<String> activeFrom;
  final Value<String> activeUntil;
  final Value<int> maxPerPopup;
  final Value<int> cooldownMinutes;
  final Value<int> rowid;
  const ReminderGlobalCompanion({
    this.id = const Value.absent(),
    this.enabled = const Value.absent(),
    this.mode = const Value.absent(),
    this.intervalMinutes = const Value.absent(),
    this.randomMin = const Value.absent(),
    this.randomMax = const Value.absent(),
    this.activeFrom = const Value.absent(),
    this.activeUntil = const Value.absent(),
    this.maxPerPopup = const Value.absent(),
    this.cooldownMinutes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ReminderGlobalCompanion.insert({
    this.id = const Value.absent(),
    this.enabled = const Value.absent(),
    this.mode = const Value.absent(),
    this.intervalMinutes = const Value.absent(),
    this.randomMin = const Value.absent(),
    this.randomMax = const Value.absent(),
    this.activeFrom = const Value.absent(),
    this.activeUntil = const Value.absent(),
    this.maxPerPopup = const Value.absent(),
    this.cooldownMinutes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  static Insertable<ReminderGlobalRow> custom({
    Expression<int>? id,
    Expression<bool>? enabled,
    Expression<String>? mode,
    Expression<int>? intervalMinutes,
    Expression<int>? randomMin,
    Expression<int>? randomMax,
    Expression<String>? activeFrom,
    Expression<String>? activeUntil,
    Expression<int>? maxPerPopup,
    Expression<int>? cooldownMinutes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (enabled != null) 'enabled': enabled,
      if (mode != null) 'mode': mode,
      if (intervalMinutes != null) 'interval_minutes': intervalMinutes,
      if (randomMin != null) 'random_min': randomMin,
      if (randomMax != null) 'random_max': randomMax,
      if (activeFrom != null) 'active_from': activeFrom,
      if (activeUntil != null) 'active_until': activeUntil,
      if (maxPerPopup != null) 'max_per_popup': maxPerPopup,
      if (cooldownMinutes != null) 'cooldown_minutes': cooldownMinutes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ReminderGlobalCompanion copyWith({
    Value<int>? id,
    Value<bool>? enabled,
    Value<ReminderMode>? mode,
    Value<int>? intervalMinutes,
    Value<int>? randomMin,
    Value<int>? randomMax,
    Value<String>? activeFrom,
    Value<String>? activeUntil,
    Value<int>? maxPerPopup,
    Value<int>? cooldownMinutes,
    Value<int>? rowid,
  }) {
    return ReminderGlobalCompanion(
      id: id ?? this.id,
      enabled: enabled ?? this.enabled,
      mode: mode ?? this.mode,
      intervalMinutes: intervalMinutes ?? this.intervalMinutes,
      randomMin: randomMin ?? this.randomMin,
      randomMax: randomMax ?? this.randomMax,
      activeFrom: activeFrom ?? this.activeFrom,
      activeUntil: activeUntil ?? this.activeUntil,
      maxPerPopup: maxPerPopup ?? this.maxPerPopup,
      cooldownMinutes: cooldownMinutes ?? this.cooldownMinutes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (enabled.present) {
      map['enabled'] = Variable<bool>(enabled.value);
    }
    if (mode.present) {
      map['mode'] = Variable<String>(
        $ReminderGlobalTable.$convertermode.toSql(mode.value),
      );
    }
    if (intervalMinutes.present) {
      map['interval_minutes'] = Variable<int>(intervalMinutes.value);
    }
    if (randomMin.present) {
      map['random_min'] = Variable<int>(randomMin.value);
    }
    if (randomMax.present) {
      map['random_max'] = Variable<int>(randomMax.value);
    }
    if (activeFrom.present) {
      map['active_from'] = Variable<String>(activeFrom.value);
    }
    if (activeUntil.present) {
      map['active_until'] = Variable<String>(activeUntil.value);
    }
    if (maxPerPopup.present) {
      map['max_per_popup'] = Variable<int>(maxPerPopup.value);
    }
    if (cooldownMinutes.present) {
      map['cooldown_minutes'] = Variable<int>(cooldownMinutes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReminderGlobalCompanion(')
          ..write('id: $id, ')
          ..write('enabled: $enabled, ')
          ..write('mode: $mode, ')
          ..write('intervalMinutes: $intervalMinutes, ')
          ..write('randomMin: $randomMin, ')
          ..write('randomMax: $randomMax, ')
          ..write('activeFrom: $activeFrom, ')
          ..write('activeUntil: $activeUntil, ')
          ..write('maxPerPopup: $maxPerPopup, ')
          ..write('cooldownMinutes: $cooldownMinutes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $HabitsTable habits = $HabitsTable(this);
  late final $CheckInsTable checkIns = $CheckInsTable(this);
  late final $ShortTasksTable shortTasks = $ShortTasksTable(this);
  late final $ReminderGlobalTable reminderGlobal = $ReminderGlobalTable(this);
  late final Index checkInHabitDate = Index(
    'check_in_habit_date',
    'CREATE UNIQUE INDEX check_in_habit_date ON check_ins (habit_id, date)',
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    habits,
    checkIns,
    shortTasks,
    reminderGlobal,
    checkInHabitDate,
  ];
}

typedef $$HabitsTableCreateCompanionBuilder = HabitsCompanion Function({
  Value<int> id,
  required String name,
  Value<HabitType> type,
  Value<String?> unit,
  Value<int?> dailyGoal,
  Value<HabitFrequency> frequency,
  Value<int?> frequencyValue,
  Value<String?> weekdays,
  Value<String?> reminderTime,
  Value<String?> reminderDays,
  Value<int> color,
  Value<String> icon,
  Value<bool> archived,
  Value<DateTime?> vacationUntil,
  Value<DateTime> createdAt,
});
typedef $$HabitsTableUpdateCompanionBuilder = HabitsCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<HabitType> type,
  Value<String?> unit,
  Value<int?> dailyGoal,
  Value<HabitFrequency> frequency,
  Value<int?> frequencyValue,
  Value<String?> weekdays,
  Value<String?> reminderTime,
  Value<String?> reminderDays,
  Value<int> color,
  Value<String> icon,
  Value<bool> archived,
  Value<DateTime?> vacationUntil,
  Value<DateTime> createdAt,
});

final class $$HabitsTableReferences
    extends BaseReferences<_$AppDatabase, $HabitsTable, HabitRow> {
  $$HabitsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$CheckInsTable, List<CheckInRow>>
  _checkInsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.checkIns,
    aliasName: 'habits__id__check_ins__habit_id',
  );

  $$CheckInsTableProcessedTableManager get checkInsRefs {
    final manager = $$CheckInsTableTableManager(
      $_db,
      $_db.checkIns,
    ).filter((f) => f.habitId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_checkInsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$HabitsTableFilterComposer
    extends Composer<_$AppDatabase, $HabitsTable> {
  $$HabitsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<HabitType, HabitType, String> get type =>
      $composableBuilder(
        column: $table.type,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dailyGoal => $composableBuilder(
    column: $table.dailyGoal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<HabitFrequency, HabitFrequency, String>
  get frequency => $composableBuilder(
    column: $table.frequency,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get frequencyValue => $composableBuilder(
    column: $table.frequencyValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get weekdays => $composableBuilder(
    column: $table.weekdays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reminderTime => $composableBuilder(
    column: $table.reminderTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reminderDays => $composableBuilder(
    column: $table.reminderDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get archived => $composableBuilder(
    column: $table.archived,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get vacationUntil => $composableBuilder(
    column: $table.vacationUntil,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> checkInsRefs(
    Expression<bool> Function($$CheckInsTableFilterComposer f) f,
  ) {
    final $$CheckInsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.checkIns,
      getReferencedColumn: (t) => t.habitId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CheckInsTableFilterComposer(
            $db: $db,
            $table: $db.checkIns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$HabitsTableOrderingComposer
    extends Composer<_$AppDatabase, $HabitsTable> {
  $$HabitsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dailyGoal => $composableBuilder(
    column: $table.dailyGoal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get frequency => $composableBuilder(
    column: $table.frequency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get frequencyValue => $composableBuilder(
    column: $table.frequencyValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get weekdays => $composableBuilder(
    column: $table.weekdays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reminderTime => $composableBuilder(
    column: $table.reminderTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reminderDays => $composableBuilder(
    column: $table.reminderDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get archived => $composableBuilder(
    column: $table.archived,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get vacationUntil => $composableBuilder(
    column: $table.vacationUntil,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$HabitsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HabitsTable> {
  $$HabitsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumnWithTypeConverter<HabitType, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<int> get dailyGoal =>
      $composableBuilder(column: $table.dailyGoal, builder: (column) => column);

  GeneratedColumnWithTypeConverter<HabitFrequency, String> get frequency =>
      $composableBuilder(column: $table.frequency, builder: (column) => column);

  GeneratedColumn<int> get frequencyValue => $composableBuilder(
    column: $table.frequencyValue,
    builder: (column) => column,
  );

  GeneratedColumn<String> get weekdays =>
      $composableBuilder(column: $table.weekdays, builder: (column) => column);

  GeneratedColumn<String> get reminderTime => $composableBuilder(
    column: $table.reminderTime,
    builder: (column) => column,
  );

  GeneratedColumn<String> get reminderDays => $composableBuilder(
    column: $table.reminderDays,
    builder: (column) => column,
  );

  GeneratedColumn<int> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<String> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);

  GeneratedColumn<bool> get archived =>
      $composableBuilder(column: $table.archived, builder: (column) => column);

  GeneratedColumn<DateTime> get vacationUntil => $composableBuilder(
    column: $table.vacationUntil,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> checkInsRefs<T extends Object>(
    Expression<T> Function($$CheckInsTableAnnotationComposer a) f,
  ) {
    final $$CheckInsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.checkIns,
      getReferencedColumn: (t) => t.habitId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CheckInsTableAnnotationComposer(
            $db: $db,
            $table: $db.checkIns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$HabitsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HabitsTable,
          HabitRow,
          $$HabitsTableFilterComposer,
          $$HabitsTableOrderingComposer,
          $$HabitsTableAnnotationComposer,
          $$HabitsTableCreateCompanionBuilder,
          $$HabitsTableUpdateCompanionBuilder,
          (HabitRow, $$HabitsTableReferences),
          HabitRow,
          PrefetchHooks Function({bool checkInsRefs})
        > {
  $$HabitsTableTableManager(_$AppDatabase db, $HabitsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HabitsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HabitsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HabitsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<HabitType> type = const Value.absent(),
                Value<String?> unit = const Value.absent(),
                Value<int?> dailyGoal = const Value.absent(),
                Value<HabitFrequency> frequency = const Value.absent(),
                Value<int?> frequencyValue = const Value.absent(),
                Value<String?> weekdays = const Value.absent(),
                Value<String?> reminderTime = const Value.absent(),
                Value<String?> reminderDays = const Value.absent(),
                Value<int> color = const Value.absent(),
                Value<String> icon = const Value.absent(),
                Value<bool> archived = const Value.absent(),
                Value<DateTime?> vacationUntil = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => HabitsCompanion(
                id: id,
                name: name,
                type: type,
                unit: unit,
                dailyGoal: dailyGoal,
                frequency: frequency,
                frequencyValue: frequencyValue,
                weekdays: weekdays,
                reminderTime: reminderTime,
                reminderDays: reminderDays,
                color: color,
                icon: icon,
                archived: archived,
                vacationUntil: vacationUntil,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<HabitType> type = const Value.absent(),
                Value<String?> unit = const Value.absent(),
                Value<int?> dailyGoal = const Value.absent(),
                Value<HabitFrequency> frequency = const Value.absent(),
                Value<int?> frequencyValue = const Value.absent(),
                Value<String?> weekdays = const Value.absent(),
                Value<String?> reminderTime = const Value.absent(),
                Value<String?> reminderDays = const Value.absent(),
                Value<int> color = const Value.absent(),
                Value<String> icon = const Value.absent(),
                Value<bool> archived = const Value.absent(),
                Value<DateTime?> vacationUntil = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => HabitsCompanion.insert(
                id: id,
                name: name,
                type: type,
                unit: unit,
                dailyGoal: dailyGoal,
                frequency: frequency,
                frequencyValue: frequencyValue,
                weekdays: weekdays,
                reminderTime: reminderTime,
                reminderDays: reminderDays,
                color: color,
                icon: icon,
                archived: archived,
                vacationUntil: vacationUntil,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$HabitsTable, HabitRow>(table),
                  $$HabitsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({checkInsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (checkInsRefs) db.checkIns],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (checkInsRefs)
                    await $_getPrefetchedDataByColumns<
                      HabitRow,
                      $HabitsTable,
                      CheckInRow,
                      $CheckInsTable
                    >(
                      currentTable: table,
                      referencedTable: $$HabitsTableReferences
                          ._checkInsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$HabitsTableReferences(db, table, p0).checkInsRefs,
                      currentColumn: 'id',
                      referencedColumn: 'habit_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$HabitsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HabitsTable,
      HabitRow,
      $$HabitsTableFilterComposer,
      $$HabitsTableOrderingComposer,
      $$HabitsTableAnnotationComposer,
      $$HabitsTableCreateCompanionBuilder,
      $$HabitsTableUpdateCompanionBuilder,
      (HabitRow, $$HabitsTableReferences),
      HabitRow,
      PrefetchHooks Function({bool checkInsRefs})
    >;
typedef $$CheckInsTableCreateCompanionBuilder = CheckInsCompanion Function({
  Value<int> id,
  required int habitId,
  required String date,
  Value<CheckStatus> status,
  Value<int?> amount,
  Value<String?> note,
});
typedef $$CheckInsTableUpdateCompanionBuilder = CheckInsCompanion Function({
  Value<int> id,
  Value<int> habitId,
  Value<String> date,
  Value<CheckStatus> status,
  Value<int?> amount,
  Value<String?> note,
});

final class $$CheckInsTableReferences
    extends BaseReferences<_$AppDatabase, $CheckInsTable, CheckInRow> {
  $$CheckInsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $HabitsTable _habitIdTable(_$AppDatabase db) =>
      db.habits.createAlias('check_ins__habit_id__habits__id');

  $$HabitsTableProcessedTableManager get habitId {
    final $_column = $_itemColumn<int>('habit_id')!;

    final manager = $$HabitsTableTableManager(
      $_db,
      $_db.habits,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_habitIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CheckInsTableFilterComposer
    extends Composer<_$AppDatabase, $CheckInsTable> {
  $$CheckInsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<CheckStatus, CheckStatus, String> get status =>
      $composableBuilder(
        column: $table.status,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  $$HabitsTableFilterComposer get habitId {
    final $$HabitsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.habitId,
      referencedTable: $db.habits,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitsTableFilterComposer(
            $db: $db,
            $table: $db.habits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CheckInsTableOrderingComposer
    extends Composer<_$AppDatabase, $CheckInsTable> {
  $$CheckInsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  $$HabitsTableOrderingComposer get habitId {
    final $$HabitsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.habitId,
      referencedTable: $db.habits,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitsTableOrderingComposer(
            $db: $db,
            $table: $db.habits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CheckInsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CheckInsTable> {
  $$CheckInsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumnWithTypeConverter<CheckStatus, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  $$HabitsTableAnnotationComposer get habitId {
    final $$HabitsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.habitId,
      referencedTable: $db.habits,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitsTableAnnotationComposer(
            $db: $db,
            $table: $db.habits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CheckInsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CheckInsTable,
          CheckInRow,
          $$CheckInsTableFilterComposer,
          $$CheckInsTableOrderingComposer,
          $$CheckInsTableAnnotationComposer,
          $$CheckInsTableCreateCompanionBuilder,
          $$CheckInsTableUpdateCompanionBuilder,
          (CheckInRow, $$CheckInsTableReferences),
          CheckInRow,
          PrefetchHooks Function({bool habitId})
        > {
  $$CheckInsTableTableManager(_$AppDatabase db, $CheckInsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CheckInsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CheckInsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CheckInsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> habitId = const Value.absent(),
                Value<String> date = const Value.absent(),
                Value<CheckStatus> status = const Value.absent(),
                Value<int?> amount = const Value.absent(),
                Value<String?> note = const Value.absent(),
              }) => CheckInsCompanion(
                id: id,
                habitId: habitId,
                date: date,
                status: status,
                amount: amount,
                note: note,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int habitId,
                required String date,
                Value<CheckStatus> status = const Value.absent(),
                Value<int?> amount = const Value.absent(),
                Value<String?> note = const Value.absent(),
              }) => CheckInsCompanion.insert(
                id: id,
                habitId: habitId,
                date: date,
                status: status,
                amount: amount,
                note: note,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CheckInsTable, CheckInRow>(table),
                  $$CheckInsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({habitId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (habitId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.habitId,
                        referencedTable: $$CheckInsTableReferences
                            ._habitIdTable(db),
                        referencedColumn: $$CheckInsTableReferences
                            ._habitIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$CheckInsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CheckInsTable,
      CheckInRow,
      $$CheckInsTableFilterComposer,
      $$CheckInsTableOrderingComposer,
      $$CheckInsTableAnnotationComposer,
      $$CheckInsTableCreateCompanionBuilder,
      $$CheckInsTableUpdateCompanionBuilder,
      (CheckInRow, $$CheckInsTableReferences),
      CheckInRow,
      PrefetchHooks Function({bool habitId})
    >;
typedef $$ShortTasksTableCreateCompanionBuilder = ShortTasksCompanion Function({
  Value<int> id,
  required String name,
  Value<DateTime?> dueDate,
  Value<DateTime?> reminderTime,
  Value<bool> done,
  Value<DateTime?> completedAt,
  Value<bool> hidden,
  Value<DateTime> createdAt,
});
typedef $$ShortTasksTableUpdateCompanionBuilder = ShortTasksCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<DateTime?> dueDate,
  Value<DateTime?> reminderTime,
  Value<bool> done,
  Value<DateTime?> completedAt,
  Value<bool> hidden,
  Value<DateTime> createdAt,
});

class $$ShortTasksTableFilterComposer
    extends Composer<_$AppDatabase, $ShortTasksTable> {
  $$ShortTasksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get reminderTime => $composableBuilder(
    column: $table.reminderTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get done => $composableBuilder(
    column: $table.done,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get hidden => $composableBuilder(
    column: $table.hidden,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ShortTasksTableOrderingComposer
    extends Composer<_$AppDatabase, $ShortTasksTable> {
  $$ShortTasksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get reminderTime => $composableBuilder(
    column: $table.reminderTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get done => $composableBuilder(
    column: $table.done,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get hidden => $composableBuilder(
    column: $table.hidden,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ShortTasksTableAnnotationComposer
    extends Composer<_$AppDatabase, $ShortTasksTable> {
  $$ShortTasksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<DateTime> get dueDate =>
      $composableBuilder(column: $table.dueDate, builder: (column) => column);

  GeneratedColumn<DateTime> get reminderTime => $composableBuilder(
    column: $table.reminderTime,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get done =>
      $composableBuilder(column: $table.done, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get hidden =>
      $composableBuilder(column: $table.hidden, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$ShortTasksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ShortTasksTable,
          ShortTaskRow,
          $$ShortTasksTableFilterComposer,
          $$ShortTasksTableOrderingComposer,
          $$ShortTasksTableAnnotationComposer,
          $$ShortTasksTableCreateCompanionBuilder,
          $$ShortTasksTableUpdateCompanionBuilder,
          (
            ShortTaskRow,
            BaseReferences<_$AppDatabase, $ShortTasksTable, ShortTaskRow>,
          ),
          ShortTaskRow,
          PrefetchHooks Function()
        > {
  $$ShortTasksTableTableManager(_$AppDatabase db, $ShortTasksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ShortTasksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ShortTasksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ShortTasksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<DateTime?> dueDate = const Value.absent(),
                Value<DateTime?> reminderTime = const Value.absent(),
                Value<bool> done = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<bool> hidden = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ShortTasksCompanion(
                id: id,
                name: name,
                dueDate: dueDate,
                reminderTime: reminderTime,
                done: done,
                completedAt: completedAt,
                hidden: hidden,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<DateTime?> dueDate = const Value.absent(),
                Value<DateTime?> reminderTime = const Value.absent(),
                Value<bool> done = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<bool> hidden = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ShortTasksCompanion.insert(
                id: id,
                name: name,
                dueDate: dueDate,
                reminderTime: reminderTime,
                done: done,
                completedAt: completedAt,
                hidden: hidden,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ShortTasksTable, ShortTaskRow>(table),
                  BaseReferences<_$AppDatabase, $ShortTasksTable, ShortTaskRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ShortTasksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ShortTasksTable,
      ShortTaskRow,
      $$ShortTasksTableFilterComposer,
      $$ShortTasksTableOrderingComposer,
      $$ShortTasksTableAnnotationComposer,
      $$ShortTasksTableCreateCompanionBuilder,
      $$ShortTasksTableUpdateCompanionBuilder,
      (
        ShortTaskRow,
        BaseReferences<_$AppDatabase, $ShortTasksTable, ShortTaskRow>,
      ),
      ShortTaskRow,
      PrefetchHooks Function()
    >;
typedef $$ReminderGlobalTableCreateCompanionBuilder =
    ReminderGlobalCompanion Function({
      Value<int> id,
      Value<bool> enabled,
      Value<ReminderMode> mode,
      Value<int> intervalMinutes,
      Value<int> randomMin,
      Value<int> randomMax,
      Value<String> activeFrom,
      Value<String> activeUntil,
      Value<int> maxPerPopup,
      Value<int> cooldownMinutes,
      Value<int> rowid,
    });
typedef $$ReminderGlobalTableUpdateCompanionBuilder =
    ReminderGlobalCompanion Function({
      Value<int> id,
      Value<bool> enabled,
      Value<ReminderMode> mode,
      Value<int> intervalMinutes,
      Value<int> randomMin,
      Value<int> randomMax,
      Value<String> activeFrom,
      Value<String> activeUntil,
      Value<int> maxPerPopup,
      Value<int> cooldownMinutes,
      Value<int> rowid,
    });

class $$ReminderGlobalTableFilterComposer
    extends Composer<_$AppDatabase, $ReminderGlobalTable> {
  $$ReminderGlobalTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<ReminderMode, ReminderMode, String> get mode =>
      $composableBuilder(
        column: $table.mode,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<int> get intervalMinutes => $composableBuilder(
    column: $table.intervalMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get randomMin => $composableBuilder(
    column: $table.randomMin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get randomMax => $composableBuilder(
    column: $table.randomMax,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get activeFrom => $composableBuilder(
    column: $table.activeFrom,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get activeUntil => $composableBuilder(
    column: $table.activeUntil,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get maxPerPopup => $composableBuilder(
    column: $table.maxPerPopup,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get cooldownMinutes => $composableBuilder(
    column: $table.cooldownMinutes,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ReminderGlobalTableOrderingComposer
    extends Composer<_$AppDatabase, $ReminderGlobalTable> {
  $$ReminderGlobalTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mode => $composableBuilder(
    column: $table.mode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get intervalMinutes => $composableBuilder(
    column: $table.intervalMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get randomMin => $composableBuilder(
    column: $table.randomMin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get randomMax => $composableBuilder(
    column: $table.randomMax,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get activeFrom => $composableBuilder(
    column: $table.activeFrom,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get activeUntil => $composableBuilder(
    column: $table.activeUntil,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get maxPerPopup => $composableBuilder(
    column: $table.maxPerPopup,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get cooldownMinutes => $composableBuilder(
    column: $table.cooldownMinutes,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ReminderGlobalTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReminderGlobalTable> {
  $$ReminderGlobalTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get enabled =>
      $composableBuilder(column: $table.enabled, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ReminderMode, String> get mode =>
      $composableBuilder(column: $table.mode, builder: (column) => column);

  GeneratedColumn<int> get intervalMinutes => $composableBuilder(
    column: $table.intervalMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get randomMin =>
      $composableBuilder(column: $table.randomMin, builder: (column) => column);

  GeneratedColumn<int> get randomMax =>
      $composableBuilder(column: $table.randomMax, builder: (column) => column);

  GeneratedColumn<String> get activeFrom => $composableBuilder(
    column: $table.activeFrom,
    builder: (column) => column,
  );

  GeneratedColumn<String> get activeUntil => $composableBuilder(
    column: $table.activeUntil,
    builder: (column) => column,
  );

  GeneratedColumn<int> get maxPerPopup => $composableBuilder(
    column: $table.maxPerPopup,
    builder: (column) => column,
  );

  GeneratedColumn<int> get cooldownMinutes => $composableBuilder(
    column: $table.cooldownMinutes,
    builder: (column) => column,
  );
}

class $$ReminderGlobalTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReminderGlobalTable,
          ReminderGlobalRow,
          $$ReminderGlobalTableFilterComposer,
          $$ReminderGlobalTableOrderingComposer,
          $$ReminderGlobalTableAnnotationComposer,
          $$ReminderGlobalTableCreateCompanionBuilder,
          $$ReminderGlobalTableUpdateCompanionBuilder,
          (
            ReminderGlobalRow,
            BaseReferences<
              _$AppDatabase,
              $ReminderGlobalTable,
              ReminderGlobalRow
            >,
          ),
          ReminderGlobalRow,
          PrefetchHooks Function()
        > {
  $$ReminderGlobalTableTableManager(
    _$AppDatabase db,
    $ReminderGlobalTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReminderGlobalTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReminderGlobalTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReminderGlobalTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<bool> enabled = const Value.absent(),
                Value<ReminderMode> mode = const Value.absent(),
                Value<int> intervalMinutes = const Value.absent(),
                Value<int> randomMin = const Value.absent(),
                Value<int> randomMax = const Value.absent(),
                Value<String> activeFrom = const Value.absent(),
                Value<String> activeUntil = const Value.absent(),
                Value<int> maxPerPopup = const Value.absent(),
                Value<int> cooldownMinutes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ReminderGlobalCompanion(
                id: id,
                enabled: enabled,
                mode: mode,
                intervalMinutes: intervalMinutes,
                randomMin: randomMin,
                randomMax: randomMax,
                activeFrom: activeFrom,
                activeUntil: activeUntil,
                maxPerPopup: maxPerPopup,
                cooldownMinutes: cooldownMinutes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<bool> enabled = const Value.absent(),
                Value<ReminderMode> mode = const Value.absent(),
                Value<int> intervalMinutes = const Value.absent(),
                Value<int> randomMin = const Value.absent(),
                Value<int> randomMax = const Value.absent(),
                Value<String> activeFrom = const Value.absent(),
                Value<String> activeUntil = const Value.absent(),
                Value<int> maxPerPopup = const Value.absent(),
                Value<int> cooldownMinutes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ReminderGlobalCompanion.insert(
                id: id,
                enabled: enabled,
                mode: mode,
                intervalMinutes: intervalMinutes,
                randomMin: randomMin,
                randomMax: randomMax,
                activeFrom: activeFrom,
                activeUntil: activeUntil,
                maxPerPopup: maxPerPopup,
                cooldownMinutes: cooldownMinutes,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ReminderGlobalTable, ReminderGlobalRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $ReminderGlobalTable,
                    ReminderGlobalRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ReminderGlobalTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReminderGlobalTable,
      ReminderGlobalRow,
      $$ReminderGlobalTableFilterComposer,
      $$ReminderGlobalTableOrderingComposer,
      $$ReminderGlobalTableAnnotationComposer,
      $$ReminderGlobalTableCreateCompanionBuilder,
      $$ReminderGlobalTableUpdateCompanionBuilder,
      (
        ReminderGlobalRow,
        BaseReferences<_$AppDatabase, $ReminderGlobalTable, ReminderGlobalRow>,
      ),
      ReminderGlobalRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$HabitsTableTableManager get habits =>
      $$HabitsTableTableManager(_db, _db.habits);
  $$CheckInsTableTableManager get checkIns =>
      $$CheckInsTableTableManager(_db, _db.checkIns);
  $$ShortTasksTableTableManager get shortTasks =>
      $$ShortTasksTableTableManager(_db, _db.shortTasks);
  $$ReminderGlobalTableTableManager get reminderGlobal =>
      $$ReminderGlobalTableTableManager(_db, _db.reminderGlobal);
}
