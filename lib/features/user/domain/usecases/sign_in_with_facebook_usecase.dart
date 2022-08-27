// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:mosque_guide/core/error/failures.dart';
import 'package:mosque_guide/features/user/domain/repositories/user_repository.dart';

import '../../../../core/usecases/usecase.dart';

class SignInWithFacebookUsecase extends UseCase<Unit, NoParams> {
  final UserRepository userRepository;
  SignInWithFacebookUsecase({
    required this.userRepository,
  });
  @override
  Future<Either<Failure, Unit>> call(NoParams params) async {
    return await userRepository.signInWithFacebook();
  }
}
