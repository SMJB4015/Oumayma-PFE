import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/plan.dart';
import '../model/pub.dart';
import 'package:dealdiscover/client/constantes.dart';
import 'package:dealdiscover/client/end_points.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:http/http.dart' as http;
class ConvRepo {

  getPubs() async {


    Uri url= Uri.parse(baseurl+EndPoints.getPubs);
    // Replace with your actual endpoint
    final headers = {'Content-Type': 'application/json'};

    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<Pub> pubs = [] ;
      List<Pub> filteredPubs = [];
      List<Pub> PromoPubs = [];
      print(response.body);
      final data = json.decode(response.body);
      data.map((pub) {
        pubs.add(Pub.fromJson(pub));}).toList();
      filteredPubs = pubs
          .where((pub) => pub.state != null && pub.state == 'offre')
          .toList();
      PromoPubs = pubs
          .where((pub) => pub.state != null && pub.state == 'promo')
          .toList();
      print(PromoPubs) ;
      return {'filtred':filteredPubs, 'promo':PromoPubs ,'stcode':response.statusCode};
    } else {
      return{'message':'error' , 'stcode':response.statusCode};
    }
  }
  sendMessage(types.TextMessage message , String convID) async {
    var pref= await SharedPreferences.getInstance();
    String? token = pref.getString("token");

    Uri url= Uri.parse(baseurl+EndPoints.messageadd+convID);
    var res= await http.post(url,
        headers: {'Content-Type':'application/json',
          'Authorization': 'jwt '+token!},
        body: json.encode({
          'message': message.text,
        }));
    final data= json.decode(res.body);
    // print(data);
    if(res.statusCode == 200){
      print('we are here good');
      return {'data':data,'stcode':res.statusCode};

    }else{
      return {'message':data['message'],'stcode':res.statusCode};
    }


  }
}
