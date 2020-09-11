import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object> get props => [];
}

class Uninitialized extends AuthState {
  @override
  String toString() => 'No inicializado';
}

class Authenticated extends AuthState {
  final String displayName;
  const Authenticated(this.displayName);
  @override
  List<Object> get props => [displayName];
  @override
  String toString() => 'Autenticado - displayName: $displayName';
}

class Unauthenticated extends AuthState {
  @override
  String toString() => 'No autenticado';
}
