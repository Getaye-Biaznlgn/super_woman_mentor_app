import 'package:flutter/cupertino.dart';

class MenteeRequest with ChangeNotifier{
  int id;
  String firstName;
  String lastName;
  String? profilePic;
  String educationLevel;
  String state;
  String requestMessage;

  MenteeRequest({
    required this.id,
    required this.firstName,
    required this.lastName,
     this.profilePic,
    required this.educationLevel,
    required this.state,
    required this.requestMessage,
  });

  factory MenteeRequest.fromJson(Map<String, dynamic> json) {
    return MenteeRequest(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      profilePic: json['profile_picture'],
      educationLevel: json['education_level']['level'],
      state: json['state'] ?? '',
      requestMessage: json['request_message'] ?? '',
    );
  }


}
