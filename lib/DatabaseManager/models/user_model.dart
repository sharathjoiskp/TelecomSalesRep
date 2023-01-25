import 'dart:convert';

import 'package:intl/intl.dart';

class userResponseModel {
  String id;
  String date;
  final String contactNumber;
  final String response;
  final String sector;

  userResponseModel(
      {this.date = "",
      this.id = "",
      required this.contactNumber,
      required this.response,
      required this.sector});

  toJson() {
    return {
      'date': DateFormat.yMd().format(DateTime.now()),
      'id': id,
      "contactNumber": contactNumber,
      "response": response,
      "sector": sector,
    };
  }

  static userResponseModel fromJson(Map<String, dynamic> json) =>
      userResponseModel(
          date: json['date'],
          id: json['id'],
          contactNumber: json['contactNumber'],
          sector: json['sector'],
          response: json['response']);
}
