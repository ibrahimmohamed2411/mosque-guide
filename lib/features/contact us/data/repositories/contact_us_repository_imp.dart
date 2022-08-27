// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:mosque_guide/core/error/failures.dart';
import 'package:mosque_guide/features/contact%20us/data/datasources/contact_us_remote_data_source.dart';
import 'package:mosque_guide/features/contact%20us/domain/repositories/contact_us_repository.dart';

class ContactUsRepositoryImp implements ContactUsRepository {
  final ContactUsRemoteDataSource contactUsRemoteDataSource;
  ContactUsRepositoryImp({
    required this.contactUsRemoteDataSource,
  });

  @override
  Future<Either<Failure, Unit>> sendMessage(String message) async {
    try {
      await contactUsRemoteDataSource.sendMessage(message);
      return Right(unit);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
