import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_woman_mentor/controller/experience_controller.dart';
import 'package:super_woman_mentor/models/experience.dart';
import 'package:super_woman_mentor/ui/screens/edit_profile/components/experience_item.dart';
import '../../../../providers/auth.dart';
import '../../../../providers/themes.dart';
import '../../../../utils/constants.dart';
import '../../../widgets/primary_button.dart';

class MyExperience extends StatefulWidget {
  const MyExperience({Key? key}) : super(key: key);

  @override
  State<MyExperience> createState() => _MyExperienceState();
}

class _MyExperienceState extends State<MyExperience> {
  final ExperienceController _experienceCtrl = ExperienceController();
  List<Experience> _experiences = [];
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _positionCtrl = TextEditingController();
  final TextEditingController _orgCtrl = TextEditingController();
  final TextEditingController _fromCtrl = TextEditingController();
  final TextEditingController _toCtrl = TextEditingController();
  DateTime _fromDate = DateTime.now();
  DateTime _toDate = DateTime.now();

  // bool _isCurrent = false;
  bool _isLoading = false;

  Future fetchExperience() async {
    try {
      setState(() {
        _isLoading = true;
      });

      String token = Provider.of<Auth>(context, listen: false).token;
      _experiences = await _experienceCtrl.fetchExperience(token);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      helpText: "SELECT YOUR BIRTH DATE",
      initialDate: _fromDate,
      firstDate: DateTime(1920),
      lastDate: DateTime.now(),
    );

    if (selected != null && selected != _fromDate) {
      return selected;
    }
    return DateTime.now();
  }

  Future _addExperience() async {
    if (_formKey.currentState!.validate()) {
      Auth auth = Provider.of<Auth>(context, listen: false);
      Experience experience = await _experienceCtrl.addExperience(
          position: _positionCtrl.text,
          org: _orgCtrl.text,
          from: _fromDate.toString(),
          to: _toDate.toString(),
          token: auth.token);
      setState(() {
        _experiences.add(experience);
      });

      Navigator.of(context).pop();
      _fromCtrl.clear();
      _toCtrl.clear();
      _positionCtrl.clear();
      _orgCtrl.clear();
    }
  }

  Future deleteExperience(token, experienceId) async {
    await _experienceCtrl.deleteExperience(experienceId, token);
    setState(() {
      _experiences.removeWhere((el) => el.id == experienceId);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchExperience();
  }

  Future<void> _showDeleteDialog(experienceId) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Do you want to delete?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () async {
                String token = Provider.of<Auth>(context, listen: false).token;
                await deleteExperience(token, experienceId);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _showAddExperienceDialog() {
    // Color getColor(Set<MaterialState> states) {
    //   const Set<MaterialState> interactiveStates = <MaterialState>{
    //     MaterialState.pressed,
    //     MaterialState.hovered,
    //     MaterialState.focused,
    //   };
    //   if (states.any(interactiveStates.contains)) {
    //     return kSecondaryColor;
    //   }
    //   return kPrimaryColor;
    // }

    bool isDark = Provider.of<ThemeNotifier>(context, listen: false).isDark;
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(kDefaultPadding * 0.5),
        child: Container(
          width: double.infinity,
          height: 400,
          decoration: BoxDecoration(
            color: isDark ? kDarkBlueColor : Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Position'),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          controller: _positionCtrl,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Position is required';
                            }
                            return null;
                          },
                          decoration:
                              const InputDecoration(hintText: 'Lecturer'),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text('Organization'),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          controller: _orgCtrl,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Organization is required';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              hintText: 'Bahir Dar University'),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text('From'),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: _fromCtrl,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'From is required';
                            }
                            return null;
                          },
                          onTap: () async {
                            _fromDate = await _selectDate(context);
                            setState(() {
                              _fromCtrl.text =
                                  "${_fromDate.day}/${_fromDate.month}/${_fromDate.year}";
                            });
                          },
                          decoration: const InputDecoration(hintText: '2010'),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text('To'),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: _toCtrl,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'From is required';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(hintText: '2014'),
                          onTap: () async {
                            _toDate = await _selectDate(context);
                            setState(() {
                              _toCtrl.text =
                                  "${_toDate.day}/${_toDate.month}/${_toDate.year}";
                            });
                          },
                        ),
                        // Row(
                        //   children: [
                        //     Checkbox(
                        //       checkColor: Colors.white,
                        //       fillColor:
                        //           MaterialStateProperty.resolveWith(getColor),
                        //       value: _isCurrent,
                        //       onChanged: (bool? value) {
                        //         setState(() {
                        //           _isCurrent = value!;
                        //         });
                        //       },
                        //     ),
                        //     const Text('Current'),
                        //   ],
                        // ),
                        const SizedBox(
                          height: 10,
                        ),
                        PrimaryButton(
                            child: const Text(
                              'Save',
                              style: TextStyle(color: Colors.white),
                            ),
                            press: () async {
                              await _addExperience();
                            }),
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Auth auth = Provider.of<Auth>(context);
    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: kDefaultPadding * 0.5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'My Experience',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              IconButton(
                  icon: const Icon(
                    Icons.add_circle_outline,
                    color: kPrimaryColor,
                  ),
                  onPressed: () {
                    _showAddExperienceDialog();
                  }),
            ],
          ),
        ),
        const Divider(
          thickness: 2,
          color: Colors.grey,
        ),
        _isLoading
            ? const CircularProgressIndicator()
            : Expanded(
                child: ListView.builder(
                    itemCount: _experiences.length,
                    itemBuilder: (context, index) {
                      return ExperienceItem(
                          experience: _experiences[index],
                          onDelete: () {
                            _showDeleteDialog(_experiences[index].id);
                          },
                          onUpdate: () {});
                    })
                // child: FutureBuilder(
                //     future: _experienceCtrl.fetchExperience(auth.token),
                //     builder: (context, snapshot) {
                //       if (snapshot.connectionState == ConnectionState.done) {
                //         if (snapshot.hasError) {
                //           return const Center(
                //             child: Text('Faild to load data'),
                //           );
                //         } else if (snapshot.hasData) {
                //           List<Experience> experiences =
                //               snapshot.data as List<Experience>;
                //           return ListView.builder(
                //               itemCount: experiences.length,
                //               itemBuilder: (context, index) {
                //                 return ExperienceItem(
                //                   experience: experiences[index],
                //                 );
                //               });
                //         }
                //       }
                //       return const Center(
                //         child: CircularProgressIndicator(),
                //       );
                //     })
                //     ,
                ),
      ],
    );
  }
}
