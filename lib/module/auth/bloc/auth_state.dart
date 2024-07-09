part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class RegisterValidatorState extends AuthState {
  RegisterValidatorState(this.formKey);

  var formKey = GlobalKey<FormState>();
  @override
  List<Object?> get props => [];
}

class RegisterValidatorErrorState extends AuthState {
  final String error;

  const RegisterValidatorErrorState(this.error);

  @override
  List<Object?> get props => [];
}
