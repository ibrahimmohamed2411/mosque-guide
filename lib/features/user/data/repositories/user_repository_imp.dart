import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mosque_guide/features/user/data/datasources/user_local_data_source.dart';
import 'package:mosque_guide/features/user/data/datasources/user_remote_data_source.dart';

import '../../../../core/error/failures.dart';
import '../../domain/repositories/user_repository.dart';

class UserRepositoryImp implements UserRepository {
  final UserRemoteDataSource userRemoteDataSource;
  final UserLocalDataSource userLocalDataSource;
  UserRepositoryImp({
    required this.userRemoteDataSource,
    required this.userLocalDataSource,
  });
  @override
  Future<Either<Failure, Unit>> signInWithGoogle() async {
    try {
      await userRemoteDataSource.signInWithGoogle();
      return Right(unit);
    } on FirebaseAuthException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> signInAnonymously() async {
    try {
      await userRemoteDataSource.signInAnonymously();
      return Right(unit);
    } on FirebaseAuthException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> signInWithFacebook() async {
    try {
      await userRemoteDataSource.signInWithFacebook();
      return Right(unit);
    } on FirebaseAuthException {
      print('signInWithFacebook Exception');
      return Left(ServerFailure());
    }
  }

}
