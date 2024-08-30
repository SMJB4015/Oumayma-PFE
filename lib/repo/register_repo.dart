import 'dart:convert';
import 'package:dealdiscover/client/end_points.dart';
import 'package:dealdiscover/model/partenaire.dart';
import 'package:http/http.dart' as http;
import 'package:dealdiscover/client/constantes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user.dart';
class RegisterRepo {
  login(String email,String password) async {
    Uri url= Uri.parse(baseurl+EndPoints.signinuser);
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({
      'email': email,
      'password': password,
    });
    var res= await http.post(url,
      headers: headers ,body: body);
  final data= json.decode(res.body);
  return {'data': data, 'stcode': res.statusCode};
  }
  register(User user) async {
    Uri url= Uri.parse(baseurl+EndPoints.signupuser);
    var res= await http.post(url,
        headers: {'Content-Type':'application/json'},
        body: json.encode({
          'username': user.username,
          'lastname': user.lastname,
          'email': user.email,
          'password': user.password,
          'age': user.age,
          'adress': user.adress
        }));
    final data= json.decode(res.body);
    return {'message': data['message'],'stcode' : res.statusCode};


  }
  registerPartenaire(Partenaire partenaire) async {
    Uri url= Uri.parse(baseurl+EndPoints.partnersignup);
    var res= await http.post(url,
        headers: {'Content-Type':'application/json'},
        body: json.encode({
          'name': partenaire.name,
          'adress': partenaire.adress,
          'email': partenaire.email,
          'password': partenaire.password,
        }));
    final data= json.decode(res.body);
    return {'message': data['message'],'stcode' : res.statusCode};


  }
  update(String email,String password,String infos_liv,String name) async {
    var pref= await SharedPreferences.getInstance();
    Uri url= Uri.parse(baseurl+'/User/Add');
    String? token=pref.getString('token');
    var res= await http.put(url,
        headers: {'Content-Type':'application/json'},
        body: json.encode({"email":email,"infos_liv":infos_liv,"name":name,"password":password}));
    final data= json.decode(res.body);
    if(data['token']!=''){
      return data;

    }else{
      return data['message'];
    }


  }

}