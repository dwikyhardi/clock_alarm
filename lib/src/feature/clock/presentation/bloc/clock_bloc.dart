import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:clock_alarm/src/core/error/failure.dart';
import 'package:clock_alarm/src/core/usecase/usecase.dart';
import 'package:clock_alarm/src/feature/clock/domain/entities/alarm.dart';
import 'package:clock_alarm/src/feature/clock/domain/usecases/add_alarm_usecase.dart'
    as addAlarm;
import 'package:clock_alarm/src/feature/clock/domain/usecases/get_alarm_usecase.dart';
import 'package:clock_alarm/src/feature/clock/domain/usecases/remove_alarm_usecase.dart';
import 'package:clock_alarm/src/feature/clock/domain/usecases/set_active_alarm_usecase.dart'
    as paramIsActive;
import 'package:clock_alarm/src/feature/clock/domain/usecases/stop_alarm_usecase.dart';
import 'package:clock_alarm/src/feature/clock/domain/usecases/stream_alarm_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'clock_event.dart';

part 'clock_state.dart';

class ClockBloc extends Bloc<ClockEvent, ClockState> {
  final addAlarm.AddAlarmUseCase addAlarmUseCase;
  final GatAlarmUseCase gatAlarmUseCase;
  final RemoveAlarmUseCase removeAlarmUseCase;
  final StopAlarmUseCase stopAlarmUseCase;
  final StreamAlarmUseCase streamAlarmUseCase;
  final paramIsActive.SetActiveAlarmUseCase setActiveAlarmUseCase;

  ClockBloc({
    required this.addAlarmUseCase,
    required this.gatAlarmUseCase,
    required this.removeAlarmUseCase,
    required this.stopAlarmUseCase,
    required this.streamAlarmUseCase,
    required this.setActiveAlarmUseCase,
  }) : super(const ClockInitial()) {
    on<AddAlarmEvent>((event, emit) => onAddAlarmEvent(event, emit));
    on<RemoveAlarmEvent>((event, emit) => onRemoveAlarmEvent(event, emit));
    on<StopAlarmEvent>((event, emit) => onStopAlarmEvent(event, emit));
    on<GetAlarmEvent>((event, emit) => onGetAlarmEvent(event, emit));
    on<SetIsActiveAlarmEvent>(
        (event, emit) => onSetIsActiveAlarmEvent(event, emit));
  }

  void onSetIsActiveAlarmEvent(
      SetIsActiveAlarmEvent event, Emitter<ClockState> emitter) {
    setActiveAlarmUseCase(
        paramIsActive.Params(alarmId: event.alarmId, isActive: event.isActive));
  }

  void onAddAlarmEvent(AddAlarmEvent event, Emitter<ClockState> emitter) {
    addAlarmUseCase(addAlarm.Params(alarmTimeInMs: event.alarmTimeInMs));
  }

  void onRemoveAlarmEvent(RemoveAlarmEvent event, Emitter<ClockState> emitter) {
    removeAlarmUseCase(Params(alarmId: event.alarmId));
  }

  void onStopAlarmEvent(StopAlarmEvent event, Emitter<ClockState> emitter) {
    stopAlarmUseCase(Params(alarmId: event.alarmId));
  }

  void onGetAlarmEvent(GetAlarmEvent event, Emitter<ClockState> emitter) {
    gatAlarmUseCase(Params(alarmId: event.alarmId));
  }

  Stream<List<Alarm>> streamListAlarm() async* {
    StreamTransformer<Either<Failure, List<Alarm>>, List<Alarm>> transformer =
        StreamTransformer.fromHandlers(handleData:
            (Either<Failure, List<Alarm>> data, EventSink<List<Alarm>> output) {
      if (data.isRight()) {
        output.add(data.getOrElse(() => []));
      }
    });
    yield* streamAlarmUseCase(NoParams()).transform(transformer);
  }
}
