// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class ServerException extends Equatable implements Exception {
  final String? msg;
  ServerException({
    this.msg,
  });

  @override
  List<Object?> get props => [msg];
  @override
  String toString() => '$msg';
}

class FetchDataException extends ServerException {
  FetchDataException([message]) : super(msg: 'Error During Communication');
}

class BadRequestException extends ServerException {
  BadRequestException([message]) : super(msg: 'Bad Request');
}

class UnauthorizedException extends ServerException {
  UnauthorizedException([message]) : super(msg: 'Unauthorized');
}

class NotFoundException extends ServerException {
  NotFoundException([message]) : super(msg: 'Request Info Not Found');
}

class ConflictException extends ServerException {
  ConflictException([message]) : super(msg: 'Conflict Occurred');
}

class InternalServerErrorException extends ServerException {
  InternalServerErrorException([message]) : super(msg: 'Internal Server Error');
}

class NoInternetConnectionException extends ServerException {
  NoInternetConnectionException([message])
      : super(msg: 'No Internet Connection');
}

class CacheException implements Exception {}
