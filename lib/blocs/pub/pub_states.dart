import 'package:dealdiscover/model/pub.dart';
import 'package:equatable/equatable.dart';

import '../../model/plan.dart';

class PubStates extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];

}
class PubInitState extends PubStates{}

class PubLoadingState extends PubStates{}

class PubLoadedState extends PubStates{
  final List<Pub> filtred ;
  final List<Pub> promo ;


  PubLoadedState({required this.filtred, required this.promo,});
}

class PlanPubSuccessState extends PubStates{
  final String message ;

  PlanPubSuccessState({ required this.message});
}

class PubErrorState extends PubStates{
  final String message ;

  PubErrorState({ required this.message});
}

