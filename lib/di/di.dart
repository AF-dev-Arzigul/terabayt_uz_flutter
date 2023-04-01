import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:terabayt_uz/data/source/remote/api/app_api.dart';

/// Creator : Azimjon Makhmudov
/// Date : 2/15/2023 Time : 08:06
/// Project : terabayt_uz
/// Package : lib/di

final GetIt di = GetIt.instance;

void setUp() {
  di.registerLazySingleton(() => Dio(BaseOptions(baseUrl: "https://www.terabayt.uz/")));
  di.registerLazySingleton(() => AppApi(di.get<Dio>()));
}
