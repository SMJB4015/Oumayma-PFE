import 'auth_events.dart';
import '../auth/auth_states.dart';
import 'package:dealdiscover/repo/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthBloc extends Bloc<AuthEvents,AuthStates>{
  AuthRepo repo;
  AuthBloc(AuthStates LoginInitState,this.repo) : super(LoginInitState){
    on<StartAEvent>((event, emit) async {
      var pref= await SharedPreferences.getInstance();
      if(pref.getString('nom')!=''){
        emit(UserInState(nom: pref.getString('nom') ,token: pref.getString('token'), role: pref.getString('role')));
      }

    });
    on<LoginButtonPressed>((event, emit) async {
      var pref= await SharedPreferences.getInstance();
      emit(LoginLoadingState()) ;
      var data = await repo.login(event.email,event.password);
      if(data['stcode']==200){
        pref.setString('nom', data['data']['user']['email']);
        pref.setString('token', data['data']['user']['token']);
        pref.setString('role', data['data']['user']['roles'][0]);
        emit(UserInState(nom: data['data']['user']['email'] ,token: data['data']['user']['token'],role: data['data']['user']['roles'][0]));

      }else {
        emit(LoginErrorState(message: data['data']['message']));
      }
    });
    // on<RegisterButtonPressed>((event, emit) async {
    //   var pref= await SharedPreferences.getInstance();
    //   var data = await repo.register(event.user);
    //   emit(LoginLoadingState()) ;
    //   if(data['token']!=''){
    //     emit(UserRegisterSuccessState());
    //
    //   }else{
    //     emit(LoginErrorState(message: data['error']));
    //   }
    // });
    on<DecoButtonPressed>((event, emit) async {
      var pref= await SharedPreferences.getInstance();
      pref.clear();
      emit(UserDecoState()) ;

    });
  }
}


