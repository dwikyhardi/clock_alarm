import 'package:clock_alarm/src/core/error/exception.dart';
import 'package:clock_alarm/src/feature/clock/data/model/alarm_model.dart';
import 'package:clock_alarm/src/feature/clock/data/table/alarm_table.dart';
import 'package:clock_alarm/src/feature/clock/domain/entities/alarm.dart';

abstract class ClockDatasource {
  Future<int> addAlarm({required int alarmTimeInMs});

  Future<void> deleteAlarm({required int alarmId});

  Future<Alarm> getAlarm({required int alarmId});

  Future<bool> stopAlarm({required int alarmId});

  Future<bool> setIsActiveAlarm({required int alarmId,required bool isActive});

  Stream<List<Alarm>> streamAlarm();
}

class ClockDataSourceImpl implements ClockDatasource {
  final AppDatabase database;

  ClockDataSourceImpl(this.database);

  @override
  Future<int> addAlarm({required int alarmTimeInMs}) async {
    try {
      return await database.appDao.saveAlarm(AlarmModels(
          alarmTimeInMs: alarmTimeInMs,
          timeToStopAlarm: 0,
          isStop: false,
          isActive: true));
    } on Exception {
      throw DatabaseException();
    }
  }

  @override
  Future<Alarm> getAlarm({required int alarmId}) async {
    try {
      return await database.appDao.getAlarm(alarmId);
    } on Exception {
      throw DatabaseException();
    }
  }

  @override
  Future<void> deleteAlarm({required int alarmId}) async {
    try {
      await database.appDao.deleteAlarm(alarmId);
    } on Exception {
      throw DatabaseException();
    }
  }

  @override
  Stream<List<Alarm>> streamAlarm() async* {
    try {
      yield* database.appDao.streamAlarms();
    } on Exception {
      throw DatabaseException();
    }
  }

  @override
  Future<bool> stopAlarm({required int alarmId}) async {
    try {
      return await database.appDao.stopAlarm(alarmId);
    } on Exception {
      throw DatabaseException();
    }
  }

  @override
  Future<bool> setIsActiveAlarm({required int alarmId,required bool isActive}) async {
    try {
      return await database.appDao.setIsActiveAlarm(alarmId, isActive);
    } on Exception {
      throw DatabaseException();
    }
  }
}
