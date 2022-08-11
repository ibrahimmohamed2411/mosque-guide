import 'package:dartz/dartz.dart';
import 'package:mosque_guide/core/error/failures.dart';
import 'package:mosque_guide/core/usecases/usecase.dart';
import 'package:mosque_guide/features/mosque_guide/domain/entities/mosque.dart';
import 'package:mosque_guide/features/mosque_guide/domain/repositories/mosque_repository.dart';

class GetMosquesUseCase implements UseCase<Set<Mosque>, NoParams> {
  final MosqueRepository mosqueRepository;
  GetMosquesUseCase({
    required this.mosqueRepository,
  });
  @override
  Future<Either<Failure, Set<Mosque>>> call(NoParams params) {
    return mosqueRepository.getMosques();
  }
}
