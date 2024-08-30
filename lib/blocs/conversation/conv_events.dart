import 'package:dealdiscover/model/user.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class ConvEvents extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];

}
class StartConvEvent extends ConvEvents{
  final List<types.Message> messages ;
  StartConvEvent({ required this.messages});

}
class SendMButtonPressed extends ConvEvents{
  final String convID ;
  final types.TextMessage message ;
  final List<types.Message> messages ;


  SendMButtonPressed({required this.message, required this.messages,required this.convID});
}

