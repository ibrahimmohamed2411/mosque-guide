import 'package:dartz/dartz.dart';
import 'package:mosque_guide/core/error/failures.dart';
import 'package:mosque_guide/core/usecases/usecase.dart';
import 'package:mosque_guide/features/on_boarding/domain/repositories/on_boarding_repository.dart';

class CacheOnBoardingStateUseCase implements UseCase<Unit, NoParams> {
  final OnBoardingRepository onBoardingRepository;
  CacheOnBoardingStateUseCase({
    required this.onBoardingRepository,
  });

  @override
  Future<Either<Failure, Unit>> call(NoParams params) async{
    return await onBoardingRepository.cacheOnBoardingState();
  }
}
