import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final ValueNotifier<bool> isPasswordVisible = ValueNotifier(false);

  void clearTextField() {
    emailController.clear();
    passwordController.clear();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
                    'LOGIN TO YOUR ACCOUNT',
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
                    controller: emailController,
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
                  child: ValueListenableBuilder(
                    valueListenable: isPasswordVisible,
                    builder: (context, value, child) => TextFormField(
                      controller: passwordController,
                      obscureText: isPasswordVisible.value,
                      autofocus: false,
                      cursorColor: Colors.blue,
                      cursorHeight: 12.0,
                      decoration: kNormalInputDecoration.copyWith(
                        hintText: 'Password',
                        suffixIcon: IconButton(
                          onPressed: () => isPasswordVisible.value =
                              !isPasswordVisible.value,
                          icon: Icon(
                              isPasswordVisible.value
                                  ? PhosphorIcons.fill.eye
                                  : PhosphorIcons.fill.eyeSlash,
                              color: Colors.black),
                        ),
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
                  child: Column(
                    children: [
                      TextButton(
                          onPressed: () async {
                            setState(() {
                              isLoading = true;
                            });

                            String email = emailController.text.trim();
                            String password = passwordController.text.trim();

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
                            } else {
                              final SharedPreferences sharedPrefs =
                                  await SharedPreferences.getInstance();
                              await _auth
                                  .signInWithEmailAndPassword(
                                      email: email, password: password)
                                  .then(
                                (_) {
                                  sharedPrefs.setBool("loginState", true);
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      '/home_screen', (route) => false);
                                },
                                onError: (e) => ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                        backgroundColor: Colors.red,
                                        content: Text("An error occurred!"))),
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
                            'LOG IN',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                          )),
                      const SizedBox(height: 15.0),
                      Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text("Don't have an account?",
                              style: TextStyle(fontSize: 15.0)),
                          GestureDetector(
                              onTap: () => Navigator.of(context)
                                  .pushReplacementNamed('/register_screen'),
                              child: const Text(
                                ' Register',
                                style: TextStyle(
                                    color: Colors.blueAccent, fontSize: 17.5),
                              ))
                        ],
                      ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
