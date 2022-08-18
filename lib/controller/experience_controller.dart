import 'package:super_woman_mentor/models/experience.dart';
import 'package:super_woman_mentor/services/api_base_helper.dart';

class ExperienceController {
  final ApiBaseHelper _apiBaseHelper = ApiBaseHelper();

  Future<Experience> addExperience({position, org, from, to, token}) async {
    Experience experience;
    final response = await _apiBaseHelper
        .post(url: '/mentor/experiances', token: token, payload: {
      'position': position,
      'organization': org,
      'from': from,
      'to': to,
      // 'is_current': exp.isCurrent,
    });

    experience = Experience.fromJson(response);

    return experience;
  }

  Future deleteExperience(experienceId, token) async {
    Experience experience;
    final response = await _apiBaseHelper.delete(
        url: '/mentor/experiances/$experienceId', token: token);

        
  }

  Future<List<Experience>> fetchExperience(token) async {
    List<Experience> experiences = [];
    final response =
        await _apiBaseHelper.get(url: '/mentor/experiances', token: token);
    List menteeResponse = response as List;
    for (int i = 0; i < menteeResponse.length; i++) {
      Map<String, dynamic> map = menteeResponse[i];
      experiences.add(Experience.fromJson(map));
    }
    return experiences;
  }
}
