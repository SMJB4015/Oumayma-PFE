import 'package:dealdiscover/blocs/pub/pub_states.dart';

import '../../repo/conv_repo.dart';
import '../../repo/pub_repo.dart';
import 'conv_events.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import 'conv_states.dart';

class ConvBloc extends Bloc<ConvEvents,ConvStates>{
  ConvRepo repo;
  final _user = const types.User(
    id: '82091008-a484-4a89-ae75-a22bf8d6f3ac',
  );

  final _chatbot = const types.User(
    id: 'Dedi-bot', // Unique ID for the chatbot
    firstName: 'Dedi', // Name of the chatbot
  );
  ConvBloc(ConvStates ConvInitState,this.repo) : super(ConvInitState){
    on<StartConvEvent>((event, emit) async {
      emit(ConvLoadingState()) ;
      emit(ConvdiscussionLoaded(messages: event.messages,convID: ''));

    });
    on<SendMButtonPressed>((event, emit) async {
      final UtextMessage = types.TextMessage(
        author: _user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: DateTime.now().toIso8601String(),
        text: event.message.text,
      );
      List<types.Message> _messages = event.messages;
      _messages.insert(0, UtextMessage);
      emit(ConvLoadingState()) ;
      emit(ConvdiscussionLoaded(messages:_messages ,convID: ''));
      var data = await repo.sendMessage(event.message,event.convID);
      if(data['stcode']==200){
        print('YYYYYYESSSS');
        print(data['conversationId']);
        print(data['response']);
        final BtextMessage = types.TextMessage(
          author: _chatbot,
          createdAt: DateTime.now().millisecondsSinceEpoch,
          id: DateTime.now().toIso8601String(),
          text: data['response'],
        );
        print('Nooo');


        _messages.insert(0, BtextMessage);
        emit(ConvdiscussionLoaded(messages: _messages,convID: data['conversationId']));

      }else{
        emit(ConvErrorState(message: data['message']));
        emit(ConvdiscussionLoaded(messages: event.messages,convID: event.convID));

      }
    });
/*    on<LoginButtonPressed>((event, emit) async {
      var pref= await SharedPreferences.getInstance();
      emit(LoginLoadingState()) ;
      var data = await repo.login(event.email,event.password);
      print(data);
      if(data['stcode']==200){
        pref.setString('nom', data['data']['user']['email']);
        pref.setString('token', data['data']['user']['token']);
        pref.setString('role', data['data']['user']['roles'][0]);
        emit(UserInState(nom: data['data']['user']['email'] ,token: data['data']['user']['token'],role: data['data']['user']['roles'][0]));

      }else {
        emit(LoginErrorState(message: data['data']['message']));
      }
    });*/
/*    on<RegisterButtonPressed>((event, emit) async {
      var pref= await SharedPreferences.getInstance();
      var data = await repo.register(event.user);
      emit(LoginLoadingState()) ;
      if(data['token']!=''){
        emit(UserRegisterSuccessState());

      }else{
        emit(LoginErrorState(message: data['error']));
      }
    });*/
  }
}


