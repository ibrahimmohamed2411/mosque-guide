import 'package:dartz/dartz.dart';
import 'package:mosque_guide/core/error/failures.dart';

abstract class ContactUsRepository {
  Future<Either<Failure, Unit>> sendMessage(String message);
}
