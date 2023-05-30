// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:todoapp/providers/user_provider.dart';
// import 'package:todoapp/screens/home_screen.dart';
// import 'package:todoapp/screens/login_screen.dart';
//
// class Wrapper extends StatefulWidget {
//   const Wrapper({Key? key}) : super(key: key);
//
//   static const String id = 'wrapper';
//
//   @override
//   State<Wrapper> createState() => _WrapperState();
// }
//
// class _WrapperState extends State<Wrapper> {
//   @override
//   Widget build(BuildContext context) {
//     // UserProvider _provider = UserProvider();
//
//     final _provider = Provider.of<UserProvider>(context);
//
//     final userId = _provider.uid;
//
//     log("Provider User ID -- $userId");
//
//     return userId != null ? const HomeScreen() : const LoginScreen();
//
//   }
// }
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool loginState = false;

  Future getValidation() async {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    var state = sharedPrefs.getBool('loginState');
    setState(() {
      loginState = state!;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getValidation().whenComplete(() => loginState
      ? Navigator.of(context).pushNamedAndRemoveUntil(
          '/home_screen', (route) => false)
        : Navigator.of(context).pushNamedAndRemoveUntil(
        '/login_screen', (route) => false)
    );
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
