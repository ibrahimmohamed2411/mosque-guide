import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mosque_guide/core/error/failures.dart';
import 'package:mosque_guide/features/mosque_guide/domain/entities/mosque.dart';
import 'package:mosque_guide/features/mosque_guide/domain/entities/place_directions.dart';

abstract class MosqueRepository {
  Future<Either<Failure, LatLng>> getCurrentLocation();

  Future<Either<Failure, Set<Mosque>>> getMosques();

  Future<Either<Failure, PlaceDirections>> getDirections(
      LatLng origin, LatLng destination);
  Future<Either<Failure, List<Mosque>>> getMosquesByName(String mosqueName);
}
