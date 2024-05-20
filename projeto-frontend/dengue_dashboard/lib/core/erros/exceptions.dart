import 'package:equatable/equatable.dart';

abstract class DengueException extends Equatable implements Exception {
  final String? message;

  const DengueException([this.message]);
}

class ServerException extends DengueException {
  // ignore: annotate_overrides, overridden_fields
  final String? message;

  // ignore: prefer_const_constructors_in_immutables
  ServerException([this.message]);

  @override
  List<Object> get props => [];
}

class BadRequestException extends DengueException {
  @override
  List<Object> get props => [];
}

class NoAuthorizationException extends DengueException {
  @override
  List<Object> get props => [];
}

class NotFoundException extends DengueException {
  @override
  List<Object> get props => [];
}
