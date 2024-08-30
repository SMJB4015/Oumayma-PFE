// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Message {
  String id;
  String sender;
  String text;
  String timestamp;




  Message({
    required this.id,
    required this.sender,
    required this.text,
    required this.timestamp
  });

}