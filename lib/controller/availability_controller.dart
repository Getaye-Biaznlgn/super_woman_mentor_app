import 'package:flutter/material.dart';
import 'package:super_woman_mentor/models/availability.dart';
import 'package:super_woman_mentor/services/api_base_helper.dart';

class AvailabilityController extends ChangeNotifier {
  final ApiBaseHelper _apiBaseHelper = ApiBaseHelper();
  List<Availability> availabilities = [
     Availability(
        day: 'Sun',
        from: const TimeOfDay(hour: 0, minute: 0),
        to: const TimeOfDay(hour: 0, minute: 0)),
     Availability(
        day: 'Mon',
        from: const TimeOfDay(hour: 0, minute: 0),
        to: const TimeOfDay(hour: 0, minute: 0)),
    Availability(
        day: 'Tue',
        from: const TimeOfDay(hour: 0, minute: 0),
        to: const TimeOfDay(hour: 0, minute: 0)),
     Availability(
        day: 'Wed',
        from: const TimeOfDay(hour: 0, minute: 0),
        to: const TimeOfDay(hour: 0, minute: 0)),
     Availability(
        day: 'Thu',
        from: const TimeOfDay(hour: 0, minute: 0),
        to: const TimeOfDay(hour: 0, minute: 0)),
     Availability(
        day: 'Fri',
        from: const TimeOfDay(hour: 0, minute: 0),
        to: const TimeOfDay(hour: 0, minute: 0)),
     Availability(
        day: 'Sat',
        from: const TimeOfDay(hour: 0, minute: 0),
        to: const TimeOfDay(hour: 0, minute: 0)),
  ];

 Future addAvailability({day,from, to, token}) async {
   var now = DateTime.now();
    final response = await _apiBaseHelper
        .post(url: '/mentor/availabilities', token: token, payload: {
      'day': day,
      'from':  DateTime(now.year, now.month, now.day, from.hour, from.minute).toString(),
      'to': DateTime(now.year, now.month, now.day, to.hour, to.minute).toString(),
    });
  // Map<String, dynamic> map= response as Map<St>
     int index= availabilities.indexWhere((el) => el.day==response['day']);
      if(index != -1){
         availabilities[index]= Availability.fromJson(response);
         availabilities[index].isSelected= true;
         notifyListeners();
      }
    
  }
 Future deleteAvailability(id, token) async{
   final response = await _apiBaseHelper.delete(url: '/mentor/availabilities/$id', token: token);
        int index= availabilities.indexWhere((el) => el.id==id);
        if(index!=-1){
          availabilities[index].isSelected= false;
          notifyListeners();

        }
         

   
 }
  Future fetchAvailability(token) async {
    final response =
        await _apiBaseHelper.get(url: '/mentor/availabilities', token: token);
    print('😂 availability');
    print(response);
    List availabilityResponse = response as List;
    for (int i = 0; i < availabilityResponse.length; i++) {
      Map<String, dynamic> map = availabilityResponse[i];

      int index= availabilities.indexWhere((el) => el.day==map['day']);
      if(index != -1){
         availabilities[index]= Availability.fromJson(map);
         availabilities[index].isSelected= true;
      }
    }
    notifyListeners();
  }
}
