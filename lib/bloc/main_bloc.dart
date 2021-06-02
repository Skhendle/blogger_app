import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:blogger_app/repo/login.dart';
import 'package:blogger_app/storage/share_prefs_app_data.dart';
import 'package:equatable/equatable.dart';
import 'package:blogger_app/data_models/data_models.dart';


part 'main_event.dart';
part 'main_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(const UserState());

  final LoginRepository repo = LoginRepository();
  SharedPref sharedPref = SharedPref();
  UserData testData = UserData("5898", "Blogger One", "String token", 266.5);

  UserState get initialState => HomeState(sharedPref.read());
  UserData get retUserData => testData;




  @override
  void onTransition(Transition<UserEvent, UserState> transition) {
    super.onTransition(transition);
  }



  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is HomeState){
      yield HomeState(sharedPref.read());

    }else if(event is IsLogOut){

      sharedPref.remove();
      yield LogOut();
    }

  }
}
