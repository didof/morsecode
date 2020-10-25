import 'package:get_it/get_it.dart';
import 'package:morsecode/features/converter/data/interfaces/lamp_interface.dart';
import 'package:morsecode/features/converter/data/repository_impl.dart';
import 'package:morsecode/features/converter/domain/repository_contract.dart';
import 'package:morsecode/features/converter/domain/usecases/use_getStreamBoolFromWord.dart';
import 'package:morsecode/features/converter/domain/usecases/use_hasLamp.dart';
import 'package:morsecode/features/converter/domain/usecases/use_invertLampState.dart';
import 'package:morsecode/features/converter/domain/usecases/use_playLampStream.dart';
import 'package:morsecode/features/converter/domain/usecases/use_setLampState.dart';
import 'package:morsecode/features/converter/presentation/cubit/converter_cubit.dart';

final sl = GetIt.instance;

Future<void> serviceLocatorInject() async {
  // cubit
  sl.registerFactory(() {
    return ConverterCubit(
      useHasLamp: sl(),
      useSetLampState: sl(),
      useInvertLampState: sl(),
      useInstantiateMcFromWord: sl(),
      usePlayLampStream: sl(),
    );
  });

  // usecases
  sl.registerLazySingleton(() => UseHasLamp(repository: sl()));
  sl.registerLazySingleton(() => UseSetLampState(repository: sl()));
  sl.registerLazySingleton(() => UseInvertLampState(repository: sl()));
  sl.registerLazySingleton(() => UseInstantiateMcFromWord(repository: sl()));
  sl.registerLazySingleton(() => UsePlayLampStream(repository: sl()));

  // repository
  sl.registerLazySingleton<ConverterRepositoryContract>(
      () => ConverterRepositoryImpl(lampInterface: sl()));

  // external
  sl.registerLazySingleton<LampInterfaceContract>(() => LampInterfaceImpl());
}
