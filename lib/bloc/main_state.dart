part of 'main_bloc.dart';


class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class HomeState extends UserState {
  final UserData data;
  HomeState(this.data ): super();
}

class LogOut extends UserState {}


