import 'package:clock_alarm/src/core/error/failure.dart';
import 'package:clock_alarm/src/core/usecase/usecase.dart';
import 'package:clock_alarm/src/feature/clock/domain/entities/alarm.dart';
import 'package:clock_alarm/src/feature/clock/domain/repositories/clock_repository.dart';
import 'package:dartz/dartz.dart';

class GatAlarmUseCase extends UseCase<Alarm, Params> {
  final ClockRepository repository;

  GatAlarmUseCase(this.repository);

  @override
  Future<Either<Failure, Alarm>> call(Params params) async {
    return repository.getAlarm(alarmId: params.alarmId);
  }
}

class Params {
  final int alarmId;

  Params({required this.alarmId});
}
