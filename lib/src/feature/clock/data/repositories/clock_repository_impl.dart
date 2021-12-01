import 'dart:async';

import 'package:clock_alarm/src/core/error/exception.dart';
import 'package:clock_alarm/src/core/error/failure.dart';
import 'package:clock_alarm/src/feature/clock/data/datasource/clock_datasource.dart';
import 'package:clock_alarm/src/feature/clock/domain/entities/alarm.dart';
import 'package:clock_alarm/src/feature/clock/domain/repositories/clock_repository.dart';
import 'package:dartz/dartz.dart';

class ClockRepositoryImpl implements ClockRepository {
  final ClockDatasource datasource;

  ClockRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, Alarm>> addAlarm({required int alarmTimeInMs}) async {
    try {
      var id = await datasource.addAlarm(alarmTimeInMs: alarmTimeInMs);
      Alarm result = await datasource.getAlarm(alarmId: id);
      return Right(result);
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> stopAlarm({required int alarmId}) async {
    try {
      var result = await datasource.stopAlarm(alarmId: alarmId);
      return Right(result);
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, Alarm>> getAlarm({required int alarmId}) async {
    try {
      var result = await datasource.getAlarm(alarmId: alarmId);
      return Right(result);
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> removeAlarm({required int alarmId}) async {
    try {
      await datasource.deleteAlarm(alarmId: alarmId);
      return const Right(true);
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Stream<Either<Failure, List<Alarm>>> streamAlarm() async* {
    try {
      StreamTransformer<List<Alarm>, Either<Failure, List<Alarm>>> transformer =
          StreamTransformer.fromHandlers(handleData: (List<Alarm> data,
              EventSink<Either<Failure, List<Alarm>>> output) {
        if (data.isNotEmpty) {
          output.add(Right(data));
        } else {
          output.add(Left(DatabaseFailure()));
        }
      });
      yield* datasource.streamAlarm().transform(transformer);
    } on DatabaseException {
      yield Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> setActiveAlarm({required int alarmId, required bool isActive}) async{
    try{
      var result = await datasource.setIsActiveAlarm(alarmId: alarmId, isActive: isActive);
      return Right(result);
    }on DatabaseException{
      return Left(DatabaseFailure());
    }
  }
}
