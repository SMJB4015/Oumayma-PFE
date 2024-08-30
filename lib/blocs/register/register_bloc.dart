import '../../repo/register_repo.dart';
import 'register_events.dart';
import 'register_states.dart';
import 'package:dealdiscover/repo/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterBloc extends Bloc<RegisterEvents,RegisterStates>{
  RegisterRepo repo;
  RegisterBloc(RegisterStates RegisterInitState,this.repo) : super(RegisterInitState){
    on<StartAEvent>((event, emit) async {

    });
/*    on<LoginButtonPressed>((event, emit) async {
      var pref= await SharedPreferences.getInstance();
      emit(LoginLoadingState()) ;
      var data = await repo.login(event.email,event.password);
      print(data);
      if(data['stcode']==200){
        pref.setString('nom', data['data']['user']['email']);
        //pref.setString('place', data['place']);
        pref.setString('token', data['data']['user']['token']);
        emit(UserInState(nom: data['data']['user']['email'] ,token: data['data']['user']['token']));

      }else {
        emit(LoginErrorState(message: data['data']['message']));
      }
    });*/
    on<RegisterButtonPressed>((event, emit) async {
      var pref= await SharedPreferences.getInstance();
      var data = await repo.register(event.user);
      emit(RegisterLoadingState()) ;
      print(data);
      if(data['stcode']==201){
        emit(UserRegisterSuccessState());
      }else{
        emit(RegisterErrorState(message: data['message']));
      }
    });
    on<RegisterPartnerButtonPressed>((event, emit) async {
      var pref= await SharedPreferences.getInstance();
      var data = await repo.registerPartenaire(event.partenaire);
      emit(RegisterLoadingState()) ;
      print(data);
      if(data['stcode']==201){
        emit(UserRegisterSuccessState());
      }else{
        emit(RegisterErrorState(message: data['message']));

      }
    });
  }
}


