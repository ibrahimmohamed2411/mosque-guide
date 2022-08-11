// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mosque_guide/core/error/failures.dart';
import 'package:mosque_guide/core/usecases/usecase.dart';
import 'package:mosque_guide/features/mosque_guide/domain/entities/place_directions.dart';
import 'package:mosque_guide/features/mosque_guide/domain/repositories/mosque_repository.dart';

class GetDirectionUseCase implements UseCase<PlaceDirections, DirectionsParam> {
  final MosqueRepository mosqueRepository;
  GetDirectionUseCase({
    required this.mosqueRepository,
  });

  @override
  Future<Either<Failure, PlaceDirections>> call(DirectionsParam params) async {
    return mosqueRepository.getDirections(params.origin, params.destination);
  }
}

class DirectionsParam extends Equatable {
  final LatLng origin;
  final LatLng destination;
  DirectionsParam({required this.destination, required this.origin});
  @override
  List<Object?> get props => [origin, destination];
}
