import 'package:flutter/cupertino.dart';
import 'package:super_woman_mentor/models/request.dart';
import '../services/api_base_helper.dart';

class RequestController with ChangeNotifier {
  ApiBaseHelper apiBaseHelper = ApiBaseHelper();
  List<MenteeRequest> requests = [];

  Future<List<MenteeRequest>> fetchMenteeRequest(token) async {
    List<MenteeRequest> menteeRequests = [];
    final response =
        await apiBaseHelper.get(url: '/mentor/mentee_requests', token: token);
    List requestResponse = response as List;
    for (int i = 0; i < requestResponse.length; i++) {
      Map<String, dynamic> map = requestResponse[i];
      menteeRequests.add(MenteeRequest.fromJson(map));
    }

    requests = menteeRequests;
    notifyListeners();
  return  menteeRequests;
  }
}
