import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../constants.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool isLoading = false;

  final ValueNotifier<bool> isPasswordVisible = ValueNotifier(false);
  final ValueNotifier<bool> isConfirmPasswordVisible = ValueNotifier(false);

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  TextEditingController emailControl = TextEditingController();
  TextEditingController passwordControl = TextEditingController();
  TextEditingController confirmPasswordControl = TextEditingController();

  //Auth _authService = Auth();

  void clearTextField() {
    emailControl.clear();
    passwordControl.clear();
    confirmPasswordControl.clear();
  }

  registerUser(userEmail) async {}

  @override
  void dispose() {
    emailControl.dispose();
    passwordControl.dispose();
    confirmPasswordControl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 100.0),
                  child: const Center(
                    child: Text("TodoApp",
                        style: TextStyle(
                          color: Color(0xff2F2E41),
                          fontSize: 50.0,
                          fontWeight: FontWeight.w600,
                          shadows: <Shadow>[
                            Shadow(
                                offset: Offset(2.5, 2.5),
                                blurRadius: 1.0,
                                color: Color(0xff2F2E41)),
                          ],
                        )),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(top: 10.0),
                    width: 250.0,
                    height: 270.0,
                    child: const Center(
                      child: Image(
                        image: AssetImage('assets/login_pic.png'),
                      ),
                    )),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  child: const Text(
                    'CREATE AN ACCOUNT',
                    style: TextStyle(
                      color: Color(0xff1C2D40),
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 35.0),
                  child: TextFormField(
                    controller: emailControl,
                    cursorHeight: 12.0,
                    cursorColor: Colors.blue,
                    autofocus: false,
                    decoration: kNormalInputDecoration.copyWith(
                      hintText: 'Your Institute Email ID',
                    ),
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.only(left: 35.0, right: 35.0, top: 10.0),
                  child: TextFormField(
                    controller: passwordControl,
                    autofocus: false,
                    obscureText: isPasswordVisible.value,
                    cursorColor: Colors.blue,
                    cursorHeight: 12.0,
                    decoration: kNormalInputDecoration.copyWith(
                      hintText: 'Password',
                      suffixIcon: IconButton(
                        onPressed: () =>
                            isPasswordVisible.value = !isPasswordVisible.value,
                        icon: Icon(
                            isPasswordVisible.value
                                ? PhosphorIcons.fill.eye
                                : PhosphorIcons.fill.eyeSlash,
                            color: Colors.black),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.only(left: 35.0, right: 35.0, top: 10.0),
                  child: TextFormField(
                    controller: confirmPasswordControl,
                    autofocus: false,
                    obscureText: isConfirmPasswordVisible.value,
                    cursorColor: Colors.blue,
                    cursorHeight: 12.0,
                    decoration: kNormalInputDecoration.copyWith(
                      hintText: 'Confirm Password',
                      suffixIcon: IconButton(
                        onPressed: () => isConfirmPasswordVisible.value =
                            !isConfirmPasswordVisible.value,
                        icon: Icon(
                            isConfirmPasswordVisible.value
                                ? PhosphorIcons.fill.eye
                                : PhosphorIcons.fill.eyeSlash,
                            color: Colors.black),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                      top: 10.0, left: 255.0, right: 35.0),
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: Color(0xff6C6C6C),
                      fontWeight: FontWeight.w600,
                      fontSize: 15.0,
                    ),
                  ),
                ),
                const SizedBox(height: 50.0),
                Center(
                  child: TextButton(
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        String email = emailControl.text.trim();
                        String password = passwordControl.text.trim();
                        String confirmPassword =
                            confirmPasswordControl.text.trim();

                        if (email.isEmpty) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Institute ID field is empty!"),
                          ));
                        } else if (password.isEmpty) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Password field is empty!"),
                          ));
                        } else if (confirmPassword.isEmpty) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Confirm Password field is empty!"),
                          ));
                        } else if (password != confirmPassword) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Password do not match"),
                            backgroundColor: Colors.red,
                          ));
                        } else {
                          await _auth
                              .createUserWithEmailAndPassword(
                                  email: email, password: password)
                              .then(
                            (_) async {
                              await _firestore
                                  .collection("Users")
                                  .add({'email': email}).then(
                                (_) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              "Registration Successful!!!"),
                                          backgroundColor: Colors.green));
                                  clearTextField();
                                },
                                onError: (e) => ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("An error occurred!"),
                                  backgroundColor: Colors.red,
                                )),
                              );
                            },
                            onError: (e) => ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("An error occurred!"),
                              backgroundColor: Colors.red,
                            )),
                          );
                        }
                        setState(() {
                          isLoading = false;
                        });
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0xff3D77BB),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0)),
                        fixedSize: const Size(150, 39),
                        elevation: 2.0,
                      ),
                      child: const Text(
                        'REGISTER',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      )),
                ),
                const SizedBox(height: 15.0),
                Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text("Have an account?",
                        style: TextStyle(fontSize: 15.0)),
                    GestureDetector(
                        onTap: () => Navigator.of(context)
                            .pushReplacementNamed('/login_screen'),
                        child: const Text(
                          ' Login',
                          style: TextStyle(
                              color: Colors.blueAccent, fontSize: 17.0),
                        ))
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
