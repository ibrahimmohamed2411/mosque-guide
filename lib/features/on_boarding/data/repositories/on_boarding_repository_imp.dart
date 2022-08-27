// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:mosque_guide/features/on_boarding/data/datasources/on_boarding_local_data_source.dart';
import 'package:mosque_guide/features/on_boarding/domain/repositories/on_boarding_repository.dart';

import '../../../../core/error/failures.dart';

class OnBoardingRepositoryImp implements OnBoardingRepository {
  final OnBoardingLocalDataSource onBoardingLocalDataSource;
  OnBoardingRepositoryImp({
    required this.onBoardingLocalDataSource,
  });
  
  @override
  Future<Either<Failure, Unit>> cacheOnBoardingState() async {
    try {
      await onBoardingLocalDataSource.cacheOnBoardingState();
      return Right(unit);
    } catch (e) {
      return Left(CacheFailure());
    }
  }
}
