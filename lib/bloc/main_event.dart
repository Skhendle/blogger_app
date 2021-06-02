part of 'main_bloc.dart';


abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}


class IsLogOut extends UserEvent {}

class UserDataEvent extends UserEvent {}