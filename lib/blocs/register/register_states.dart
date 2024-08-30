import 'package:equatable/equatable.dart';

class RegisterStates extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];

}
class RegisterInitState extends RegisterStates{}

class RegisterLoadingState extends RegisterStates{}

class VisiteurState extends RegisterStates{}

class UserRegisterSuccessState extends RegisterStates{}

class UserUpdateSuccessState extends RegisterStates{}

class UserLoginSuccessState extends RegisterStates{}


class RegisterErrorState extends RegisterStates{
  final String message ;

  RegisterErrorState({ required this.message});
}

