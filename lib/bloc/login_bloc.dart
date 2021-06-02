import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:blogger_app/repo/login.dart';
import 'package:blogger_app/storage/share_prefs_app_data.dart';
import 'package:equatable/equatable.dart';
import 'package:blogger_app/data_models/data_models.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState());

  final LoginRepository repo = LoginRepository();
  LoginState get initialState => InitialLogin();

  @override
  void onTransition(Transition<LoginEvent, LoginState> transition) {
    super.onTransition(transition);
  }



  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {

    if (event is EmailChanged) {
      final email = Email.dirty(event.email);
      yield state.copyWith(
        email: email.valid ? email : Email.pure(event.email),
        status: Formz.validate([email, state.password]),
      );

    } else if (event is PasswordChanged) {
      final password = Password.dirty(event.password);
      yield state.copyWith(
        password: password.valid ? password : Password.pure(event.password),
        status: Formz.validate([state.email, password]),
      );

    } else if (event is EmailUnfocused) {

      final email = Email.dirty(state.email.value);

      yield state.copyWith(
        email: email,
        status: Formz.validate([email, state.password]),
      );

    } else if (event is PasswordUnfocused) {

      final password = Password.dirty(state.password.value);

      yield state.copyWith(
        password: password,
        status: Formz.validate([state.email, password]),
      );

    } else if (event is FormSubmitted) {

      final email = Email.dirty(state.email.value);
      final password = Password.dirty(state.password.value);

      yield state.copyWith(
        email: email,
        password: password,
        status: Formz.validate([email, password]),
      );

      if (state.status.isValidated) {
          // Display progress indicator
          yield SubmittingLogin();

          // Connecting with login repository
          // String msg = await repo.userLogin(email.value, password.value);

          // if (msg == null) yield LoginSuccess();


          // yield FailedLogin(msg);
          for(int i = 0; i < 1000; i++)

          yield LoginSuccess();

      }
    }
  }
}
