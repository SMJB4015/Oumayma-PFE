import 'dart:convert';
import 'package:dealdiscover/client/end_points.dart';
import 'package:http/http.dart' as http;
import 'package:dealdiscover/client/constantes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user.dart';
class AuthRepo {
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
    Uri url= Uri.parse(baseurl+EndPoints.signinuser);
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
    print(data['email']);
    if(data['email']!=''){
      return data;

    }else{
      return data['message'];
    }


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