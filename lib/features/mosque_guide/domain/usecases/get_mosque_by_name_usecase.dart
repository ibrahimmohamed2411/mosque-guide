import 'package:dartz/dartz.dart';
import 'package:mosque_guide/core/error/failures.dart';

import '../../../../core/usecases/usecase.dart';
import '../entities/mosque.dart';
import '../repositories/mosque_repository.dart';

class GetMosquesByNameUseCase implements UseCase<List<Mosque>, String> {
  final MosqueRepository mosqueRepository;
  GetMosquesByNameUseCase({required this.mosqueRepository});
  @override
  Future<Either<Failure, List<Mosque>>> call(String mosqueName) async {
    return await mosqueRepository.getMosquesByName(mosqueName);
  }
}