import 'package:clock_alarm/src/core/error/failure.dart';
import 'package:clock_alarm/src/core/usecase/usecase.dart';
import 'package:clock_alarm/src/feature/clock/domain/entities/alarm.dart';
import 'package:clock_alarm/src/feature/clock/domain/repositories/clock_repository.dart';
import 'package:dartz/dartz.dart';

class GetAllAlarmUseCase extends UseCase<List<Alarm>, NoParams> {
  final ClockRepository repository;

  GetAllAlarmUseCase(this.repository);

  @override
  Future<Either<Failure, List<Alarm>>> call(NoParams params) async {
    return await repository.getAllAlarm();
  }
}
