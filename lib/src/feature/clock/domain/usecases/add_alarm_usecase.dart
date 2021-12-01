import 'package:clock_alarm/src/core/error/failure.dart';
import 'package:clock_alarm/src/core/usecase/usecase.dart';
import 'package:clock_alarm/src/feature/clock/domain/entities/alarm.dart';
import 'package:clock_alarm/src/feature/clock/domain/repositories/clock_repository.dart';
import 'package:dartz/dartz.dart';

class AddAlarmUseCase extends UseCase<Alarm, Params> {
  final ClockRepository repository;

  AddAlarmUseCase(this.repository);

  @override
  Future<Either<Failure, Alarm>> call(Params params) async {
    return await repository.addAlarm(alarmTimeInMs: params.alarmTimeInMs);
  }
}

class Params {
  final int alarmTimeInMs;

  Params({required this.alarmTimeInMs});
}
