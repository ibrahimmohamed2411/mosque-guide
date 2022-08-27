import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

abstract class UserRepository {
  Future<Either<Failure, Unit>> signInWithGoogle();
  Future<Either<Failure, Unit>> signInWithFacebook();
  Future<Either<Failure, Unit>> signInAnonymously();

}
