// import 'package:shared_preferences/shared_preferences.dart';
//
// class Helper {
//   String? finalEmail;
//
//   void setEmail(email) async {
//     final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     sharedPreferences.setString('email', email);
//   }
//
//   Future<String> getEmail() async {
//     final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     var obtainEmail = sharedPreferences.getString('email');
//     return obtainEmail;
//   }
// }