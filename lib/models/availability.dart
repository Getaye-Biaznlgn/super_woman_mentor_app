import 'package:flutter/material.dart';

class Availability {
  int? id;
  String day;
  TimeOfDay from;
  TimeOfDay to;
  bool isSelected = false;
  Availability(
      { this.id, required this.day, required this.from, required this.to, isSelected});
  factory Availability.fromJson(Map<String, dynamic> json) {
    return Availability(
       id: json['id'],
        day: json['day'],
        from: TimeOfDay(hour:int.parse(json['from'].split(":")[0]),minute: int.parse(json['from'].split(":")[1])),
        to: TimeOfDay(hour:int.parse(json['to'].split(":")[0]),minute: int.parse(json['to'].split(":")[1])));
  
  }
}
