// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:mosque_guide/core/error/failures.dart';
import 'package:mosque_guide/core/usecases/usecase.dart';
import 'package:mosque_guide/features/contact%20us/domain/repositories/contact_us_repository.dart';

class SendMessageUseCase implements UseCase<Unit, String> {
  final ContactUsRepository contactUsRepository;
  SendMessageUseCase({
    required this.contactUsRepository,
  });
  @override
  Future<Either<Failure, Unit>> call(String params) async{
    return await contactUsRepository.sendMessage(params);
  }
}
