import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart';
import 'package:mosque_guide/core/error/exceptions.dart';
import 'package:mosque_guide/core/error/failures.dart';
import 'package:mosque_guide/features/mosque_guide/data/datasources/mosque_remote_data_source.dart';
import 'package:mosque_guide/features/mosque_guide/domain/entities/mosque.dart';
import 'package:mosque_guide/features/mosque_guide/domain/entities/place_directions.dart';
import '../../domain/repositories/mosque_repository.dart';
import '../datasources/mosque_local_data_source.dart';

class MosqueRepositoryImp implements MosqueRepository {
  final MosqueRemoteDataSource mosqueRemoteDataSource;
  final MosqueLocalDataSource mosqueLocalDataSource;
  MosqueRepositoryImp({
    required this.mosqueRemoteDataSource,
    required this.mosqueLocalDataSource,
  });
  @override
  Future<Either<Failure, LatLng>> getCurrentLocation() async {
    try {
      final result = await mosqueLocalDataSource.getCurrentLocation();
      return Right(result);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Set<Mosque>>> getMosques() async {
    try {
      final result = await mosqueRemoteDataSource.getMosques();
      return Right(result);
    } catch (e) {
      debugPrint(e.toString());
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, PlaceDirections>> getDirections(
      LatLng origin, LatLng destination) async {
    try {
      final placeDirections =
          await mosqueRemoteDataSource.getDirections(origin, destination);
      return Right(placeDirections);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Mosque>>> getMosquesByName(
      String mosqueName) async {
    try {
      final mosques = await mosqueRemoteDataSource.getMosquesByName(mosqueName);
      return Right(mosques);
    } on FirebaseException catch (e) {
      print(e.toString());
      return Left(ServerFailure());
    }
  }
}
