part of 'login_bloc.dart';


class LoginState extends Equatable {

  const LoginState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,
  });

  final Email email;
  final Password password;
  final FormzStatus status;

  LoginState copyWith({
    Email email,
    Password password,
    FormzStatus status,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [email, password, status];
}

class InitialLogin extends LoginState {}

class SubmittingLogin extends LoginState {}

class FailedLogin extends LoginState {
  final String message;

  FailedLogin(this.message): super();
}

class LoginSuccess extends LoginState {}


