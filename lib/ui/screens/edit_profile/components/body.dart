import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_woman_mentor/providers/themes.dart';
import 'package:super_woman_mentor/ui/widgets/primary_button.dart';
import 'package:super_woman_mentor/utils/constants.dart';
import '../../../../providers/auth.dart';
import 'my_experience.dart';

class Body extends StatefulWidget {
  Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameCtrl = TextEditingController();
  final TextEditingController _lastNameCtrl = TextEditingController();

  final _formKey2 = GlobalKey<FormState>();
  String _phoneCode = '+251';
  String? _phoneNo;
  String? _otp;

  Widget _buildDropdownItem(Country country) => Row(
        children: <Widget>[
          CountryPickerUtils.getDefaultFlagImage(country),
          const SizedBox(
            width: kDefaultPadding * 0.5,
          ),
          country.name.length > 15
              ? Text(country.name.substring(0, 15) + " (${country.phoneCode})")
              : Text(country.name + "+ (${country.phoneCode})"),
        ],
      );

  _updateProfileName(Auth auth) async {
    if (_formKey.currentState!.validate()) {
      await auth.updateProfileName(
          firstName: _firstNameCtrl.text, lastName: _lastNameCtrl.text);
      Navigator.of(context).pop();
    }
  }

  _confrimOtp(Auth auth) async {
    if (_otp != null) {
      await auth.verifyOtp(
        otp: _otp,
        phoneNo: '$_phoneCode$_phoneNo',
      );
      Navigator.of(context).pop();
    }
  }

  Future _updatePhoneNo(Auth auth) async {
    if (_formKey2.currentState!.validate()) {
      await auth.changePhoneNo(phoneNo: _phoneNo, code: _phoneCode);
      Navigator.of(context).pop();
      _showOtpDialog(auth);
    }
  }

  _showChangePhoneNoDialog(Auth auth) {
    bool isDark = Provider.of<ThemeNotifier>(context, listen: false).isDark;

    showDialog<String>(
      context: context,
      builder: (BuildContext context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(kDefaultPadding * 0.5),
        child: Container(
          width: double.infinity,
          height: 250,
          decoration: BoxDecoration(
            color: isDark ? kDarkBlueColor : Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Column(
            children: [
              Form(
                  key: _formKey2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Phone Number'),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 8.0),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border.all(color: const Color(0XFFd1d1d1))),
                        child: CountryPickerDropdown(
                          initialValue: 'et',
                          isExpanded: true,
                          itemBuilder: _buildDropdownItem,
                          onValuePicked: (Country country) {
                            _phoneCode = country.phoneCode;
                          },
                        ),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter phone number';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          _phoneNo = value;
                        },
                        decoration: const InputDecoration(
                            hintText: " ",
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xffd1d1d1))),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xffd1d1d1))),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: kPrimaryColor)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: kPrimaryColor))),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                          'We will send you a code over SMS to your new phone to confirm your number'),
                      const SizedBox(
                        height: 10,
                      ),
                      PrimaryButton(
                          child: const Text(
                            'Change',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          press: () {
                            _updatePhoneNo(auth);
                          })
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  _showEditNameDialog(Auth auth) {
    bool isDark = Provider.of<ThemeNotifier>(context, listen: false).isDark;

    _firstNameCtrl.text = auth.firstName;
    _lastNameCtrl.text = auth.lastName;

    showDialog<String>(
      context: context,
      builder: (BuildContext context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(kDefaultPadding * 0.5),
        child: Container(
          width: double.infinity,
          height: 300,
          decoration: BoxDecoration(
            color: isDark ? kDarkBlueColor : Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Column(
            children: [
              Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('First Name'),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _firstNameCtrl,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'First name is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text('Last Name'),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _lastNameCtrl,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Last name is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      PrimaryButton(
                          child: const Text(
                            'Save',
                            style: TextStyle(color: Colors.white),
                          ),
                          press: () {
                            _updateProfileName(auth);
                          })
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  _showOtpDialog(Auth auth) {
    bool isDark = Provider.of<ThemeNotifier>(context, listen: false).isDark;

    showDialog<String>(
      context: context,
      builder: (BuildContext context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(kDefaultPadding * 0.5),
        child: Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            color: isDark ? kDarkBlueColor : Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Confirm your number',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                'Enter the code we sent over SMS to $_phoneCode$_phoneNo',
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Otp required';
                  }
                  return null;
                },
                onChanged: (value) {
                  _otp = value;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              PrimaryButton(
                  child: const Text(
                    'Confirm',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  press: () {
                    _confrimOtp(auth);
                  })
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of<Auth>(context);

    return Column(
      children: [
        Container(
          padding:
              const EdgeInsets.symmetric(horizontal: kDefaultPadding * 0.5),
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.grey[300]),
            onPressed: () {
              _showEditNameDialog(auth);
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Name'),
                  Text('${auth.firstName} ${auth.lastName}')
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          padding:
              const EdgeInsets.symmetric(horizontal: kDefaultPadding * 0.5),
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.grey[300]),
            onPressed: () {
              _showChangePhoneNoDialog(auth);
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Phone Number'),
                  Text('${auth.phoneNumber}'),
                ],
              ),
            ),
          ),
        ),
        const Expanded(child: MyExperience())
      ],
    );
  }
}
