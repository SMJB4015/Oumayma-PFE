// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Plan {
  String id;
  String? title;
  String? address;
  String? dateFrom;
  String? dateTo;
  final String? timeFrom;
  String? timeTo;
  final int? nb_personnes;
  final String? reminder;



  Plan({
    required this.id,
    required this.title,
    required this.address,
    required this.dateFrom,
    required this.dateTo,
    required this.timeFrom,
    required this.timeTo,
    required this.nb_personnes,
    required this.reminder,
  });

}