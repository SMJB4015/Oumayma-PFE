import 'package:equatable/equatable.dart';

class AuthStates extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];

}
class LoginInitState extends AuthStates{}

class LoginLoadingState extends AuthStates{}

class UserInState extends AuthStates{
  final String? nom ;
  final String? token ;
  final String? role ;


  UserInState({required this.nom, required this.token,required this.role});
}
class VisiteurState extends AuthStates{}


class UserUpdateSuccessState extends AuthStates{}

class UserLoginSuccessState extends AuthStates{}


class LoginErrorState extends AuthStates{
  final String message ;

  LoginErrorState({ required this.message});
}
class UserDecoState extends AuthStates{}


