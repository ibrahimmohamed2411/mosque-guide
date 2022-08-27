import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:location/location.dart';
import 'package:mosque_guide/core/api/dio_consumer.dart';
import 'package:mosque_guide/core/api/end_points.dart';
import 'package:mosque_guide/core/network/network_info.dart';
import 'package:mosque_guide/features/contact%20us/data/datasources/contact_us_remote_data_source.dart';
import 'package:mosque_guide/features/contact%20us/data/repositories/contact_us_repository_imp.dart';
import 'package:mosque_guide/features/contact%20us/domain/repositories/contact_us_repository.dart';
import 'package:mosque_guide/features/contact%20us/domain/usecases/send_message_usecase.dart';
import 'package:mosque_guide/features/contact%20us/presentation/cubit/contact_us_cubit.dart';
import 'package:mosque_guide/features/mosque_guide/data/datasources/mosque_local_data_source.dart';
import 'package:mosque_guide/features/mosque_guide/data/datasources/mosque_remote_data_source.dart';
import 'package:mosque_guide/features/mosque_guide/data/repositories/mosque_repository_imp.dart';
import 'package:mosque_guide/features/mosque_guide/domain/repositories/mosque_repository.dart';
import 'package:mosque_guide/features/mosque_guide/domain/usecases/get_current_location_usecase.dart';
import 'package:mosque_guide/features/mosque_guide/domain/usecases/get_directions_usecase.dart';
import 'package:mosque_guide/features/mosque_guide/domain/usecases/get_mosque_by_name_usecase.dart';
import 'package:mosque_guide/features/mosque_guide/domain/usecases/get_mosques_usecase.dart';
import 'package:mosque_guide/features/mosque_guide/presentation/cubit/mosque_cubit.dart';
import 'package:mosque_guide/features/on_boarding/data/datasources/on_boarding_local_data_source.dart';
import 'package:mosque_guide/features/on_boarding/data/repositories/on_boarding_repository_imp.dart';
import 'package:mosque_guide/features/on_boarding/domain/repositories/on_boarding_repository.dart';
import 'package:mosque_guide/features/on_boarding/domain/usecases/cache_on_boarding_state_usecase.dart';
import 'package:mosque_guide/features/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:mosque_guide/features/user/data/datasources/user_local_data_source.dart';
import 'package:mosque_guide/features/user/data/datasources/user_remote_data_source.dart';
import 'package:mosque_guide/features/user/domain/repositories/user_repository.dart';
import 'package:mosque_guide/features/user/domain/usecases/sign_in_with_facebook_usecase.dart';
import 'package:mosque_guide/features/user/domain/usecases/sign_in_with_google_uservase.dart';
import 'package:mosque_guide/features/user/presentation/bloc/user_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/api/app_interceptors.dart';
import 'core/utils/custom_marker.dart';
import 'features/user/data/repositories/user_repository_imp.dart';
import 'features/user/domain/usecases/sign_in_anonymously_usecase.dart';

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
  sl.registerFactory(() => UserBloc(
        signInWithGoogleUseCase: sl(),
        signInAnonymouslyUseCase: sl(),
        signInWithFacebookUseCase: sl(),
      ));
  sl.registerFactory(() => OnBoardingCubit(cacheOnBoardingStateUseCase: sl()));
  sl.registerFactory(() => ContactUsCubit(sendMessageUseCase: sl()));

  //Usecases
  sl.registerLazySingleton(
      () => GetCurrentLocationUseCase(mosqueRepository: sl()));
  sl.registerLazySingleton(() => GetMosquesUseCase(mosqueRepository: sl()));

  sl.registerLazySingleton(() => GetDirectionUseCase(mosqueRepository: sl()));
  sl.registerLazySingleton(
      () => GetMosquesByNameUseCase(mosqueRepository: sl()));

  sl.registerLazySingleton(() => SignInWithGoogleUseCase(userRepository: sl()));
  sl.registerLazySingleton(
      () => SignInAnonymouslyUseCase(userRepository: sl()));
  sl.registerLazySingleton(
      () => SignInWithFacebookUsecase(userRepository: sl()));
  sl.registerLazySingleton(
      () => CacheOnBoardingStateUseCase(onBoardingRepository: sl()));
  sl.registerLazySingleton(() => SendMessageUseCase(contactUsRepository: sl()));

  //Repositories
  sl.registerLazySingleton<MosqueRepository>(() => MosqueRepositoryImp(
      mosqueRemoteDataSource: sl(), mosqueLocalDataSource: sl()));
  sl.registerLazySingleton<OnBoardingRepository>(
      () => OnBoardingRepositoryImp(onBoardingLocalDataSource: sl()));

  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImp(
      userRemoteDataSource: sl(),
      userLocalDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<ContactUsRepository>(
      () => ContactUsRepositoryImp(contactUsRemoteDataSource: sl()));

  //data sources
  sl.registerLazySingleton<MosqueRemoteDataSource>(
      () => MosqueRemoteDataSourceImp(firestore: sl(), dioConsumer: sl()));

  sl.registerLazySingleton<MosqueLocalDataSource>(
      () => MosqueLocalDataSourceImp(location: sl()));

  sl.registerLazySingleton<UserRemoteDataSource>(() => UserRemoteDataSourceImp(
      firebaseAuth: sl(), googleSignIn: sl(), facebookAuth: sl()));
  sl.registerLazySingleton<UserLocalDataSource>(() => UserLocalDataSourceImp(
        firebaseAuth: sl(),
        facebookAuth: sl(),
        googleSignIn: sl(),
      ));
  sl.registerLazySingleton<OnBoardingLocalDataSource>(
      () => OnBoardingLocalDataSourceImp(sharedPreferences: sl()));
  sl.registerLazySingleton<ContactUsRemoteDataSource>(
      () => ContactUsRemoteDataSourceImp(firestore: sl(), firebaseAuth: sl()));
  //external
  sl.registerLazySingleton(() => DataConnectionChecker());
  sl.registerLazySingleton(() => Location());
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => GoogleSignIn());
  sl.registerLazySingleton(() => FacebookAuth.instance);
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  //!!!!!!!!!!!!!!!!!!

  Uint8List mosqueMarker = await CustomAssetMarker.getBytesFromAsset(
      'assets/images/marker_icon.png', 600);
  sl.registerLazySingleton<Uint8List>(() => mosqueMarker);
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
