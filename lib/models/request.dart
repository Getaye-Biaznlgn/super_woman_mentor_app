import 'package:flutter/cupertino.dart';
import '../services/api_base_helper.dart';

class MenteeRequest with ChangeNotifier {
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

  Future acceptRequest(requestId, token) async {
    ApiBaseHelper apiBaseHelper = ApiBaseHelper();
    try {
      state = 'accepted';
      // notifyListeners();
      var res = await apiBaseHelper.post(
          url: '/mentor/accept_request/$requestId',
          payload: null,
          token: token);
      state = 'accepted';
      print('😂 requested accepte');
      print(res);
      notifyListeners();
    } catch (e) {}
  }

  Future rejectRequestRequest(requestId, token) async {
    ApiBaseHelper apiBaseHelper = ApiBaseHelper();
    try {} catch (e) {
      var res = await apiBaseHelper.post(
          url: '/mentor/reject_request/$requestId',
          payload: null,
          token: token);
      state = 'rejected';
      notifyListeners();
    }
  }
}
