import 'package:equatable/equatable.dart';

abstract class ZurichException extends Equatable implements Exception {
  final String? message;

  const ZurichException([this.message]);
}

class ServerException extends ZurichException {
  // ignore: annotate_overrides, overridden_fields
  final String? message;

  // ignore: prefer_const_constructors_in_immutables
  ServerException([this.message]);

  @override
  List<Object> get props => [];
}

class BadRequestException extends ZurichException {
  @override
  List<Object> get props => [];
}

class NoAuthorizationException extends ZurichException {
  @override
  List<Object> get props => [];
}

class NotFoundException extends ZurichException {
  @override
  List<Object> get props => [];
}
