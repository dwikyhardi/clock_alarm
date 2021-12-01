import 'package:clock_alarm/src/core/error/failure.dart';
import 'package:clock_alarm/src/core/usecase/usecase.dart';
import 'package:clock_alarm/src/feature/clock/domain/repositories/clock_repository.dart';
import 'package:clock_alarm/src/feature/clock/domain/usecases/get_alarm_usecase.dart'
    as paramsId;
import 'package:dartz/dartz.dart';

class StopAlarmUseCase extends UseCase<bool, Params> {
  final ClockRepository repository;

  StopAlarmUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(Params params) async {
    return await repository.stopAlarm(
        alarmId: params.alarmId, timeToStopAlarm: params.timeToStopAlarm);
  }
}

class Params extends paramsId.Params {
  final int timeToStopAlarm;

  Params({required this.timeToStopAlarm, required int alarmId})
      : super(alarmId: alarmId);
}
