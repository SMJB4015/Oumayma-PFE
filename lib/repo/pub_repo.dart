import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/plan.dart';
import '../model/pub.dart';
import 'package:dealdiscover/client/constantes.dart';
import 'package:dealdiscover/client/end_points.dart';
import 'package:http/http.dart' as http;
class PubRepo {

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
addPlan(Plan plan , String pubID) async {
  var pref= await SharedPreferences.getInstance();
  String? token = pref.getString("token");

  Uri url= Uri.parse(baseurl+EndPoints.planadd+pubID);
  var res= await http.post(url,
      headers: {'Content-Type':'application/json',
        'Authorization': 'jwt '+token!},
      body: json.encode({
        'title': plan.title,
        'dateFrom': plan.dateFrom,
        'dateTo': plan.dateTo,
        'timeFrom': plan.timeFrom,
        'timeTo': plan.timeTo,
        'nb_persons': plan.nb_personnes,
        'reminder': plan.reminder
      }));
  final data= json.decode(res.body);
  print(data);
  if(res.statusCode == 200){
    return {'message':'Success','stcode':res.statusCode};

  }else{
     return {'message':data['message'],'stcode':res.statusCode};
  }


}
}
