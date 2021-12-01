import 'package:clock_alarm/src/feature/clock/data/datasource/clock_datasource.dart';
import 'package:clock_alarm/src/feature/clock/data/repositories/clock_repository_impl.dart';
import 'package:clock_alarm/src/feature/clock/data/table/alarm_table.dart';
import 'package:clock_alarm/src/feature/clock/domain/repositories/clock_repository.dart';
import 'package:clock_alarm/src/feature/clock/domain/usecases/add_alarm_usecase.dart';
import 'package:clock_alarm/src/feature/clock/domain/usecases/get_alarm_usecase.dart';
import 'package:clock_alarm/src/feature/clock/domain/usecases/remove_alarm_usecase.dart';
import 'package:clock_alarm/src/feature/clock/domain/usecases/set_active_alarm_usecase.dart';
import 'package:clock_alarm/src/feature/clock/domain/usecases/stop_alarm_usecase.dart';
import 'package:clock_alarm/src/feature/clock/domain/usecases/stream_alarm_usecase.dart';
import 'package:clock_alarm/src/feature/clock/presentation/bloc/clock_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {

  ///Feature Alarm
  //Bloc
  sl.registerFactory(() => ClockBloc(
    addAlarmUseCase: sl(),
    gatAlarmUseCase: sl(),
    removeAlarmUseCase: sl(),
    stopAlarmUseCase: sl(),
    streamAlarmUseCase: sl(),
    setActiveAlarmUseCase: sl(),
  ));

  //UseCase
  sl.registerFactory(() => StreamAlarmUseCase(sl()));
  sl.registerLazySingleton(() => AddAlarmUseCase(sl()));
  sl.registerLazySingleton(() => GatAlarmUseCase(sl()));
  sl.registerLazySingleton(() => RemoveAlarmUseCase(sl()));
  sl.registerLazySingleton(() => StopAlarmUseCase(sl()));
  sl.registerLazySingleton(() => SetActiveAlarmUseCase(sl()));

  //Repository
  sl.registerLazySingleton<ClockRepository>(() => ClockRepositoryImpl(sl()));

  //Datasource
  sl.registerFactory<ClockDatasource>(() => ClockDataSourceImpl(sl()));

  ///Core
  //Database
  sl.registerLazySingleton(() => AppDatabase());

}
