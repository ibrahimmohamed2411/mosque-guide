import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:mosque_guide/core/error/failures.dart';
import 'package:mosque_guide/core/usecases/usecase.dart';
import 'package:mosque_guide/features/mosque_guide/domain/repositories/mosque_repository.dart';

class GetCurrentLocationUseCase implements UseCase<LatLng, NoParams> {
  final MosqueRepository mosqueRepository;
  GetCurrentLocationUseCase({
    required this.mosqueRepository,
  });
  @override
  Future<Either<Failure, LatLng>> call(NoParams params) {
    return mosqueRepository.getCurrentLocation();
  }
}
