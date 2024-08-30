import 'package:equatable/equatable.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart' ;
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class ConvStates extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];

}
class ConvInitState extends ConvStates{}

class ConvLoadingState extends ConvStates{}

class ConvdiscussionLoaded extends ConvStates{
  final List<types.Message> messages ;
  final String convID;



  ConvdiscussionLoaded({required this.messages,required this.convID});
}

class ConvErrorState extends ConvStates{
  final String message ;

  ConvErrorState({ required this.message});
}


