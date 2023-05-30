import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todoapp/providers/user_provider.dart';

class Auth {
  String? uid;

  Auth({this.uid});

  Future createAccount({required String email, required String password, required String confirmPassword,}) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    UserProvider _userProvider = UserProvider();

    try {
      var authUser = await _auth.createUserWithEmailAndPassword(email: email, password: password);

      var currentUser = authUser.user;

      //set user id in provider class
      _userProvider.setUid(currentUser!.uid);

      // TODO: Implement firestore function immediately after creating user account

      return currentUser;

    } on FirebaseAuthException catch (e) {
      log('${e.message}');
      return null;
    }
  }

}