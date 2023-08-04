import 'dart:typed_data';

import 'package:shared_preferences/shared_preferences.dart';

String DefaultProfilePic = "data:image/jpeg;base64,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";

Future<void> WriteUserData(UserData) async {

  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('token',UserData['token']);
  await prefs.setString('email',UserData['data']['email']);
  await prefs.setString('firstName',UserData['data']['firstName']);
  await prefs.setString('lastname',UserData['data']['lastName']);
  await prefs.setString('mobile',UserData['data']['mobile']);
  await prefs.setString('photo',UserData['data']['photo']);
}

Future<void> WriteEmailVerification(Email) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('EmailVerification',Email);
}

Future<void> WriteOTPVerification(OTP) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('OTPVerification',OTP);
}

Future<String?> ReadUserData(Key) async {
  final prefs = await SharedPreferences.getInstance();
  String? mydata = await prefs.getString(Key);
  return mydata;
}

Future<bool>RemoveToken() async{
  final prefs = await SharedPreferences.getInstance();
  await prefs.clear();
  return true;
}


ShowBase64Image(Base64String){
  UriData? data = Uri.parse(Base64String).data;
  Uint8List MyImage = data!.contentAsBytes();
  return MyImage;
}
