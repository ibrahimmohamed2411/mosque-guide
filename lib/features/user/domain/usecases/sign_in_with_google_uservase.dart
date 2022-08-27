import 'package:dartz/dartz.dart';
import 'package:mosque_guide/core/error/failures.dart';
import 'package:mosque_guide/core/usecases/usecase.dart';

import '../repositories/user_repository.dart';

class SignInWithGoogleUseCase extends UseCase<Unit, NoParams> {
  final UserRepository userRepository;
  SignInWithGoogleUseCase({
    required this.userRepository,
  });
  @override
  Future<Either<Failure, Unit>> call(NoParams params) async{
    return await userRepository.signInWithGoogle();
  }
}
