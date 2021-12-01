import 'package:clock_alarm/src/core/error/failure.dart';
import 'package:clock_alarm/src/core/usecase/usecase.dart';
import 'package:clock_alarm/src/feature/clock/domain/repositories/clock_repository.dart';
import 'package:clock_alarm/src/feature/clock/domain/usecases/get_alarm_usecase.dart'
    as paramId;
import 'package:dartz/dartz.dart';

class SetActiveAlarmUseCase extends UseCase<bool, Params> {
  final ClockRepository repository;

  SetActiveAlarmUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(Params params) async {
    return await repository.setActiveAlarm(
        alarmId: params.alarmId, isActive: params.isActive);
  }
}

class Params extends paramId.Params {
  final bool isActive;

  Params({required int alarmId, required this.isActive})
      : super(alarmId: alarmId);
}
