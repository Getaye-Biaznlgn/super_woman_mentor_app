import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api_base_helper.dart';
import '../services/storage_manager.dart';

class Auth with ChangeNotifier {
  ApiBaseHelper apiBaseHelper = ApiBaseHelper();
// '39|5VCtYdRIq5HSuCDWOLkDH8FAGTwsn53hr1Zegx8D'
  String? _token;
  String? _lastName;
  String? _firstName;
  String? _phoneNumber;
  String? _bio;
  int? _id;
  String? _dob;
  String? _profilePicture;
  // page loading controller
  // bool _isLoading = false;

  _fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _token = json['access_token'];
    _firstName = json['mentor']['first_name'];
    _lastName = json['mentor']['last_name'];
    _phoneNumber = json['mentor']['phone_number'];
    _profilePicture = json['mentor']['profile_picture'];
    notifyListeners();
    print('😂😂😂');
  }

  _fromJsonUserData(Map<String, dynamic> json) {
    _id = json['id'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _phoneNumber = json['phone_number'] ?? _phoneNumber;
    _profilePicture = json['profile_picture'];
    _bio = json['bio'];
    _dob = json['date_of_birth'];
    notifyListeners();

    print(json);
  }

  //
  bool get isAuth {
    return _token != null;
  }

  Future logout(token) async {
    await apiBaseHelper.post(url: '/api/logout', token: token, payload: null);
    _token = null;
    StorageManager.deleteData('authToken');
    notifyListeners();
  }

  Future signIn(phoneNo, password) async {
    Map<String, dynamic> data = {'phone_number': phoneNo, 'password': password};
    var signInResponse =
        await apiBaseHelper.post(url: '/mentor/login', payload: data);
     print(signInResponse);
    if (signInResponse != null) {
      _fromJson(signInResponse);
      StorageManager.saveData('authToken', _token);
    }
  }

  Future verifyOtp({required phoneNo, required otp}) async {
    Map<String, dynamic> userInfo = {'phone_number': phoneNo, 'otp': otp};
    var verifyOtpResponse =
        await apiBaseHelper.post(url: '/user/verify_phone', payload: userInfo);
    print(verifyOtpResponse);
    if (verifyOtpResponse != null) {
      _fromJson(verifyOtpResponse);
      StorageManager.saveData('authToken', _token);
    }
  }

  Future getUserInfo({required token}) async {
    var userData = await apiBaseHelper.get(url: '/mentor/mentor', token: token);
    if (userData != null) {
      _fromJsonUserData(userData);
    }
    print('😫 user info');
    print(userData);
  }

  Future resendOtp({required phoneNo}) async {
    Map<String, dynamic> userInfo = {'phone_number': phoneNo};

    var resendOtpResponse =
        await apiBaseHelper.post(url: '/user/resend', payload: userInfo);
    return resendOtpResponse;
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('authToken')) return false;
    _token = prefs.getString('authToken');
    notifyListeners();
    return true;
  }

  Future editProfile(
      {required firstName,
      required lastName,
      required dob,
      required eduLevelId,
      required bio,
      required token}) async {
    Map<String, dynamic> userInfo = {
      'first_name': lastName,
      'last_name': firstName,
      'bio': bio,
      'date_of_birth': dob.toString(),
      'education_level_id': eduLevelId,
    };
    // print('😁😀 before update profile');
    var editResponse = await apiBaseHelper.post(
        url: '/user/update_profile', payload: userInfo, token: token);
    // print(editResponse);
    if (editResponse != null) {
      _fromJsonUserData(editResponse);
    }
  }

  get token {
    return _token;
  }

  get lastName {
    return _lastName;
  }

  get firstName {
    return _firstName;
  }

  get phoneNumber {
    return _phoneNumber;
  }

  get bio {
    return _bio;
  }

  get profilePicture {
    return _profilePicture;
  }

  get dob {
    return _dob;
  }

  get id {
    return _id;
  }
}
