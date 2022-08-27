// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:mosque_guide/core/error/failures.dart';
import 'package:mosque_guide/core/usecases/usecase.dart';
import 'package:mosque_guide/features/user/domain/repositories/user_repository.dart';

class SignInAnonymouslyUseCase extends UseCase<Unit, NoParams> {
  final UserRepository userRepository;
  SignInAnonymouslyUseCase({
    required this.userRepository,
  });
  @override
  Future<Either<Failure, Unit>> call(NoParams params) async {
    return await userRepository.signInAnonymously();
  }
}
