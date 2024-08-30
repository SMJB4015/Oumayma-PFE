import 'package:dealdiscover/blocs/pub/pub_states.dart';

import '../../repo/pub_repo.dart';
import 'pub_events.dart';
import '../auth/auth_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PubBloc extends Bloc<PubEvents,PubStates>{
  PubRepo repo;
  PubBloc(PubStates PubInitState,this.repo) : super(PubInitState){
    on<StartPubAEvent>((event, emit) async {
      emit(PubLoadingState()) ;
      var data = await repo.getPubs();
      if(data['stcode']==200){
        emit(PubLoadedState(filtred: data['filtred'] ,promo: data['promo']));
      }else{
        emit(PubErrorState(message: data['message']));
      }

    });
    on<AddPlanPubButtonPressed>((event, emit) async {
      var pref= await SharedPreferences.getInstance();
      var data = await repo.addPlan(event.plan,event.pubID);
      emit(PubLoadingState()) ;
      if(data['stcode']==200){
        emit(PlanPubSuccessState(message: 'Success'));

      }else{
        emit(PubErrorState(message: data['message']));
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


