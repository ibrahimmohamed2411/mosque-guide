import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:location/location.dart';
import 'package:mosque_guide/core/api/dio_consumer.dart';
import 'package:mosque_guide/core/api/end_points.dart';
import 'package:mosque_guide/core/network/network_info.dart';
import 'package:mosque_guide/features/mosque_guide/data/datasources/mosque_local_data_source.dart';
import 'package:mosque_guide/features/mosque_guide/data/datasources/mosque_remote_data_source.dart';
import 'package:mosque_guide/features/mosque_guide/data/repositories/mosque_repository_imp.dart';
import 'package:mosque_guide/features/mosque_guide/domain/repositories/mosque_repository.dart';
import 'package:mosque_guide/features/mosque_guide/domain/usecases/get_current_location_usecase.dart';
import 'package:mosque_guide/features/mosque_guide/domain/usecases/get_directions_usecase.dart';
import 'package:mosque_guide/features/mosque_guide/domain/usecases/get_mosque_by_name_usecase.dart';
import 'package:mosque_guide/features/mosque_guide/domain/usecases/get_mosques_usecase.dart';
import 'package:mosque_guide/features/mosque_guide/presentation/cubit/mosque_cubit.dart';

import 'core/api/app_interceptors.dart';
import 'core/utils/custom_marker.dart';

final sl = GetIt.instance;
Future<void> init() async {
  //!Features

  //Bloc
  sl.registerFactory(
    () => MosqueCubit(
      getCurrentLocationUseCase: sl(),
      getMosquesUseCase: sl(),
      getDirectionUseCase: sl(),
      getMosquesByNameUseCase: sl(),
    ),
  );

  //Usecases
  sl.registerLazySingleton(
      () => GetCurrentLocationUseCase(mosqueRepository: sl()));
  sl.registerLazySingleton(() => GetMosquesUseCase(mosqueRepository: sl()));

  sl.registerLazySingleton(() => GetDirectionUseCase(mosqueRepository: sl()));
  sl.registerLazySingleton(
      () => GetMosquesByNameUseCase(mosqueRepository: sl()));

  //Repositories
  sl.registerLazySingleton<MosqueRepository>(() => MosqueRepositoryImp(
      mosqueRemoteDataSource: sl(), mosqueLocalDataSource: sl()));

  //data sources
  sl.registerLazySingleton<MosqueRemoteDataSource>(
      () => MosqueRemoteDataSourceImp(firestore: sl(), dioConsumer: sl()));

  sl.registerLazySingleton<MosqueLocalDataSource>(
      () => MosqueLocalDataSourceImp(location: sl()));

  //external
  sl.registerLazySingleton(() => DataConnectionChecker());
  sl.registerLazySingleton(() => Location());
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => Dio());
  //!!!!!!!!!!!!!!!!!!

  Uint8List mosqueMarker = await CustomAssetMarker.getBytesFromAsset(
      'assets/images/marker_icon.png', 600);
  sl.registerLazySingleton<Uint8List>(()=>mosqueMarker);
  //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

  //!core
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImp(dataConnectionChecker: sl()));
  sl.registerLazySingleton(
      () => DioConsumer(client: sl(), baseUrl: EndPoints.directionsBaseUrl));
  sl.registerLazySingleton(() => AppInterceptors());
  sl.registerLazySingleton(
    () => LogInterceptor(
      request: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
      error: true,
    ),
  );
}
