import 'package:dealdiscover/model/user.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';

import '../../model/plan.dart';

class PubEvents extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];

}
class StartPubAEvent extends PubEvents{}

class AddPubButtonPressed extends PubEvents {
  final User user ;


  AddPubButtonPressed(
      {required this.user});
}
class AddPlanPubButtonPressed extends PubEvents {
  final Plan plan ;
  final String pubID;


  AddPlanPubButtonPressed(
      {required this.pubID,required this.plan});
}



