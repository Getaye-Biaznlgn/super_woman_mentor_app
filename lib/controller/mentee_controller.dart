import 'package:super_woman_mentor/models/chat_mentee.dart';

import '../services/api_base_helper.dart';

class MenteeController {
  ApiBaseHelper apiBaseHelper = ApiBaseHelper();
  // Future<List<Mentee>> fetchMyMentees(token) async {
  //   List<Mentee> mentees = [];
  //   final response = await apiBaseHelper.get(url: '/mentor/my_mentees', token: token);
  //   List menteeResponse = response['data'] as List;
  //   for (int i = 0; i < menteeResponse.length; i++) {
  //     Map<String, dynamic> map = menteeResponse[i];
  //     mentees.add(Mentee.fromJson(map));
  //   }
  //   return mentees;
  // }

  Future<List<ChatMentee>> fetchChatMentee(token) async {
    List<ChatMentee> menteeChats = [];
    final response =
        await apiBaseHelper.get(url: '/mentor/chat_mentees', token: token);
        print('😂 chat mentee');
    List menteeResponse = response as List;
    for (int i = 0; i < menteeResponse.length; i++) {
      Map<String, dynamic> map = menteeResponse[i];
      menteeChats.add(ChatMentee.fromJson(map));
    }
    return menteeChats;
  }

  // Future sendMentorRequest(mentorId, message, token) async {
  //   return await apiBaseHelper.post(
  //       url: '/user/send_mentor_request/$mentorId',
  //       payload: message,
  //       token: token);
  // }

  
}
