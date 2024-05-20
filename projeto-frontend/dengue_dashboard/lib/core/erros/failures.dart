import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class ServerFailure extends Failure {
  final String? message;

  ServerFailure([this.message]);

  @override
  List<Object?> get props => [];

  @override
  String toString() {
    return message!;
  }
}

class UserNotFoundFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class NullParamFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class EmptyParamFailure extends Failure {
  @override
  List<Object?> get props => [];
}
