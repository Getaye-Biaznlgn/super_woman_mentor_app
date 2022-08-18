import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_woman_mentor/controller/availability_controller.dart';
import 'package:super_woman_mentor/models/availability.dart';
import '../../../../providers/auth.dart';
import '../../../../utils/constants.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool _isChecked = false;
  TimeOfDay selectedTime = TimeOfDay.now();

  _selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    // if (timeOfDay != null && timeOfDay != selectedTime) {
    //   setState(() {
    //     selectedTime = timeOfDay;
    //   });
    // }
    return timeOfDay;
  }

  _fetchAvailability() async {
    AvailabilityController availabilityController =
        Provider.of<AvailabilityController>(context, listen: false);
    String token = Provider.of<Auth>(context, listen: false).token;
    await availabilityController.fetchAvailability(token);
  }

  @override
  void initState() {
    super.initState();
    _fetchAvailability();
  }

  @override
  Widget build(BuildContext context) {
    AvailabilityController avaCtrl =
        Provider.of<AvailabilityController>(context);
    List<Availability> availabilities = avaCtrl.availabilities;

    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return kSecondaryColor;
      }
      return kPrimaryColor;
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
            children: List.generate(
                availabilities.length,
                (index) => Container(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.grey)),
                      child: Row(children: [
                        Checkbox(
                          checkColor: Colors.white,
                          fillColor:
                              MaterialStateProperty.resolveWith(getColor),
                          value: availabilities[index].isSelected,
                          onChanged: (bool? value) {
                            // setState(() {
                            //   availabilities[index].isSelected = value!;
                            // });
                            String token =
                                Provider.of<Auth>(context, listen: false).token;

                            Availability availability = availabilities[index];
                            if(value?? true){
                               avaCtrl.addAvailability(
                                day: availability.day,
                                from:  availability.from,
                                to: availability.to,
                                token: token);
                            }else{
                              avaCtrl.deleteAvailability(availability.id, token);
                            }
                           
                          },
                        ),
                        Text(
                          availabilities[index].day,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const Spacer(
                          flex: 3,
                        ),
                        GestureDetector(
                          onTap: () async {
                            TimeOfDay time = await _selectTime(context);
                            setState(() {
                              avaCtrl.availabilities[index].from = time;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(4.0),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey)),
                            child: Text(availabilities[index].from.format(context)),
                          ),
                        ),
                        const Text(' -- '),
                        GestureDetector(
                          onTap: () async {
                            TimeOfDay time = await _selectTime(context);
                            setState(() {
                              avaCtrl.availabilities[index].to = time;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(4.0),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey)),
                            child: Text(
                                availabilities[index].to.format(context)),
                          ),
                        ),
                        const Spacer(),
                      ]),
                    )).toList()),
      ),
    );
  }
}
