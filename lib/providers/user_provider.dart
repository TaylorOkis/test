import 'package:flutter/cupertino.dart';

class UserProvider with ChangeNotifier {
  String? _uid;

  String? get uid => _uid;

  setUid(String userId) {
    _uid = userId;
    notifyListeners();
  }
}