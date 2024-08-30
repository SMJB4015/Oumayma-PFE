import 'package:dealdiscover/model/partenaire.dart';
import 'package:dealdiscover/model/user.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';

class RegisterEvents extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];

}
class StartAEvent extends RegisterEvents{}

class RegisterButtonPressed extends RegisterEvents {
  final User user ;


  RegisterButtonPressed(
      {required this.user});
}
class RegisterPartnerButtonPressed extends RegisterEvents {
  final Partenaire partenaire ;


  RegisterPartnerButtonPressed(
      {required this.partenaire});
}

class UpdateButtonPressed extends RegisterEvents {
  final String email ;
  final String password ;
  final String infos_liv;
  final String nom;

  UpdateButtonPressed(
      {required this.email, required this.password, required this.infos_liv, required this.nom});
}